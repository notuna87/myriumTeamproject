package com.myrium.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.MemberVO;
import com.myrium.domain.OrderDTO;
import com.myrium.security.domain.CustomUser;
import com.myrium.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MypageController {

	@Autowired
	private OrderService orderService;
    
    @GetMapping("/mypage/change_password")
    public String showchangepw() {
        return "mypage/change_password";
    }
    
    @GetMapping("/mypage/order/list")
    public String showOrderList(Authentication authentication, RedirectAttributes rttr) {
        if (authentication == null || !authentication.isAuthenticated()) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
            return "redirect:/login";  //login.jsp로 리다이렉트
        }
        return "mypage/mypage"; // 로그인 된 경우만
    }
    
    //로그아웃 버튼 클릭 시 홈화면 이동
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home";
    }
    
    //회원정보수정
    @GetMapping("/mypage/member_update")
    public String showMemberUpdate(Model model) {
        // 현재 인증 정보 가져오기
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        
        // Principal에서 CustomUser 추출
        CustomUser customUser = (CustomUser) auth.getPrincipal();
        
        // 내부의 MemberVO 꺼내기
        MemberVO member = ((CustomUser) auth.getPrincipal()).getMember();
        
        // model에 담아서 JSP에서 사용 가능하도록 전달
        model.addAttribute("member", member);
        
        return "mypage/member_update";
    }
    
    //마이페이지 주문내역조회 
    @GetMapping("/mypage")
    public String showMypage(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        // 로그인 여부 확인
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            return "redirect:/login";
        }

        String customerId = auth.getName(); // username (customerId)
        log.info("로그인 ID: " + customerId);

        // 주문 내역 조회
        List<OrderDTO> orderList = orderService.getOrderListByCustomerId(customerId);
        log.info("주문 내역 수: " + orderList.size());

        // 주문 ID 기준으로 묶기
        Map<String, List<OrderDTO>> groupedOrders = new LinkedHashMap<>();
        for (OrderDTO dto : orderList) {
            dto.setOrderDisplayId(); // 표시용 주문번호 설정
            groupedOrders.computeIfAbsent(dto.getOrdersId(), k -> new ArrayList<>()).add(dto);
        }

        model.addAttribute("groupedOrders", groupedOrders);
        
        // 주문 상태별 개수 조회 추가
        List<Map<String, Object>> statusCounts = orderService.countOrdersByStatus(customerId);
        Map<String, Integer> statusMap = new LinkedHashMap<>();
        statusMap.put("0", 0); // 입금전
        statusMap.put("1", 0); // 배송준비중
        statusMap.put("2", 0); // 배송중
        statusMap.put("3", 0); // 배송완료

        for (Map<String, Object> row : statusCounts) {
            String status = (String) row.get("ORDER_STATUS");
            Object countObj = row.get("COUNT");

            log.info("===> 상태 원본 값: [" + status + "]");
            log.info("===> 카운트 원본 값: " + countObj);

            int count = 0;

            if (countObj instanceof BigDecimal) {
                count = ((BigDecimal) countObj).intValue();
            } else if (countObj instanceof Integer) {
                count = (Integer) countObj;
            } else if (countObj != null) {
                try {
                    count = Integer.parseInt(countObj.toString());
                } catch (NumberFormatException e) {
                    log.warn("count 변환 실패: " + countObj);
                }
            }

            if (status != null && statusMap.containsKey(status)) {
                statusMap.put(status, count);
            } else {
                log.warn("예상치 못한 상태값: " + status);
            }

            log.info(">> 정리된 상태명: " + status + ", 최종 개수: " + count);
        }

        
        //총주문금액
        int totalPaidAmount = orderService.getTotalPaidOrderAmount(customerId);
        log.info("총주문 금액: " + totalPaidAmount);

        model.addAttribute("totalPaidAmount", totalPaidAmount);

        model.addAttribute("statusMap", statusMap);
        //model.addAttribute("orderStatusMap", statusMap);

        return "mypage/mypage"; // mypage.jsp
    }

    
    //order_history 주문내역조회 구현
    @GetMapping("/mypage/order-history")
    public String goOrderHistoryPage(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            return "redirect:/login";
        }

        String customerId = auth.getName();

        // 주문 내역 조회
        List<OrderDTO> orderList = orderService.getOrderListByCustomerId(customerId);
        log.info("orderList" + orderList);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        for (OrderDTO dto : orderList) {
            dto.setOrderDisplayId();
            log.info("표시용 주문번호: " + dto.getOrderDisplayId());
        }

        
        Map<String, List<OrderDTO>> groupedOrders = new LinkedHashMap<>();
        for (OrderDTO order : orderList) {
        	
            groupedOrders.computeIfAbsent(order.getOrdersId(), k -> new ArrayList<>()).add(order);
        }
        model.addAttribute("groupedOrders", groupedOrders);
        model.addAttribute("orderCount", orderList.size());

        log.info(groupedOrders);
        // 교환/환불 내역 조회
        List<OrderDTO> cancelList = orderService.getCanceledOrdersByCustomerId(customerId);
        Map<String, List<OrderDTO>> cancelGroupedOrders = new LinkedHashMap<>();
        for (OrderDTO order : cancelList) {
            order.setOrderDisplayId();
            log.info("환불 주문번호 표시용 ID: " + order.getOrderDisplayId());
            cancelGroupedOrders.computeIfAbsent(order.getOrdersId(), k -> new ArrayList<>()).add(order);
        }
        model.addAttribute("cancelGroupedOrders", cancelGroupedOrders);
        model.addAttribute("cancelCount", cancelList.size());

        return "mypage/order_history";
    }

	
	//환불신청
	@PostMapping("/mypage/request-refund")
	@ResponseBody
	public Map<String, Object> requestRefund(@RequestBody Map<String, Object> payload) {
	    Long orderId = Long.valueOf(payload.get("orderId").toString());
	    Long productId = Long.valueOf(payload.get("productId").toString());

	    boolean result = orderService.applyRefund(orderId, productId);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", result);
	    return response;
	}

	//교환신청
	@PostMapping("/mypage/request-exchange")
	@ResponseBody
	public Map<String, Object> requestExchange(@RequestBody Map<String, Object> payload) {
	    Long orderId = Long.valueOf(payload.get("orderId").toString());
	    Long productId = Long.valueOf(payload.get("productId").toString());

	    boolean result = orderService.applyExchange(orderId, productId);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", result);
	    return response;
	}
    }
    


