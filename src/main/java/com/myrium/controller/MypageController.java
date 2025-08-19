package com.myrium.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

        // 주문 내역 조회
        List<OrderDTO> orderList = orderService.getOrderListByCustomerId(customerId);

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
            String status = row.get("ORDER_STATUS") != null ? row.get("ORDER_STATUS").toString() : null;
            Object countObj = row.get("COUNT");

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
        }

        //총주문금액
        int totalPaidAmount = orderService.getTotalPaidOrderAmount(customerId);

        model.addAttribute("totalPaidAmount", totalPaidAmount);

        model.addAttribute("statusMap", statusMap);

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
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        for (OrderDTO dto : orderList) {
            dto.setOrderDisplayId();
        }

        
        Map<String, List<OrderDTO>> groupedOrders = new LinkedHashMap<>();
        for (OrderDTO order : orderList) {
        	
            groupedOrders.computeIfAbsent(order.getOrdersId(), k -> new ArrayList<>()).add(order);
        }
        model.addAttribute("groupedOrders", groupedOrders);
        model.addAttribute("orderCount", groupedOrders.size());

        // 교환/환불 내역 조회
        List<OrderDTO> cancelAll = orderService.getCanceledOrdersByCustomerId(customerId);

     // 상태별로 나누기
     List<OrderDTO> cancelList   = new ArrayList<>(); 
     List<OrderDTO> exchangeList = new ArrayList<>(); 
     List<OrderDTO> refundList   = new ArrayList<>(); 

     for (OrderDTO dto : cancelAll) {
         int s = dto.getOrderStatus();
         if (s == 4 || s == 5) {
             exchangeList.add(dto);
         } else if (s == 6 || s == 7 || s == 14 || s == 16) {
             refundList.add(dto);
         } else if (s == 8 || s == 9 || s == 11 || s == 12) {
             cancelList.add(dto);
         }
     }

     // 탭 카운트(전체)
     int cancelTabCount = cancelList.size() + exchangeList.size() + refundList.size();
     model.addAttribute("cancelTabCount", cancelTabCount);

     // 섹션별 리스트 & 카운트
     model.addAttribute("cancelList",   cancelList);
     model.addAttribute("exchangeList", exchangeList);
     model.addAttribute("refundList",   refundList);

     model.addAttribute("cancelCount",   cancelList.size());
     model.addAttribute("exchangeCount", exchangeList.size());
     model.addAttribute("refundCount",   refundList.size());

        
        return "mypage/order_history";
    }

	
	//환불신청
    @PostMapping(value = "/mypage/updateOrderStatus", consumes = "application/json")
    @ResponseBody
    public ResponseEntity<String> updateOrderStatus(@RequestBody Map<String, Object> requestData) {
        try {
            // 필수: orderId, orderStatus
            Long orderId = ((Number) requestData.get("orderId")).longValue();
            int orderStatus = ((Number) requestData.get("orderStatus")).intValue();

            // 옵션: productId (없거나 빈문자면 전체 처리용 0으로)
            int productId = 0;
            Object pidObj = requestData.get("productId");
            if (pidObj instanceof Number) {
                productId = ((Number) pidObj).intValue();
            } else if (pidObj instanceof String) {
                String s = ((String) pidObj).trim();
                if (!s.isEmpty()) productId = Integer.parseInt(s);
            }

            // 서비스(트랜잭션)에서 productId > 0이면 부분, <=0이면 전체로 처리
            orderService.updateOrderStatus(orderId, productId, orderStatus);

            return ResponseEntity.ok("상태 변경 완료");
        } catch (Exception e) {
            log.error("updateOrderStatus error", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("에러 발생");
        }
    }
}
    


