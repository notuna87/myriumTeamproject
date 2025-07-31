package com.myrium.controller;

import java.util.ArrayList;
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
	
//	@GetMapping("/mypage")
//	public String showJoinform() {
//		return "mypage/mypage";
//	}
	
    @GetMapping("/mypage/order-history")
    public String showOrderHistory() {
        return "mypage/order_history";
    }
    
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
    
    @GetMapping("/mypage")
    public String showMypage(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        // 로그인 여부 확인
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            log.warn("🔴 로그인하지 않은 사용자입니다.");
            return "redirect:/login"; // 또는 로그인 페이지로 리디렉트
        }

        String customerId = auth.getName(); // username (customerId)
        log.info("로그인 ID: " + customerId);

        List<OrderDTO> orderList = orderService.getOrderListByCustomerId(customerId);
        log.info("주문 내역 수: " + orderList.size());
        for (OrderDTO dto : orderList) {
            log.info(dto.getOrderId() + " - " + dto.getProductName());
        }

        // 주문 ID 기준으로 묶기
        Map<String, List<OrderDTO>> groupedOrders = new LinkedHashMap<>();
        for (OrderDTO order : orderList) {
            groupedOrders
                .computeIfAbsent(order.getOrderId(), k -> new ArrayList<>())
                .add(order);
        }

        model.addAttribute("groupedOrders", groupedOrders);
        return "mypage/mypage"; // mypage.jsp
    }

    }
    


