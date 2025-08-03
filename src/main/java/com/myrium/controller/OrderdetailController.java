package com.myrium.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.MemberVO;
import com.myrium.domain.OrderDTO;
import com.myrium.security.domain.CustomUser;
import com.myrium.service.OrderService;
	
	@Controller
	public class OrderdetailController {

	    @Autowired
	    private OrderService orderService;

	    @GetMapping("/mypage/order_detail")
	    public String showOrderDetail(@RequestParam("orderId") Long orderId,
	                                   Authentication authentication,
	                                   Model model) {

	        // 로그인한 사용자 정보
	        CustomUser user = (CustomUser) authentication.getPrincipal();
	        MemberVO member = user.getMember();
	        model.addAttribute("customerName", member.getCustomerName());

	        // 주문 상세 조회
	        List<OrderDTO> orders = orderService.getOrderDetail(orderId);
	        if (orders == null || orders.isEmpty()) {
	            return "redirect:/mypage/order-history"; // 예외 처리
	        }

	        OrderDTO firstOrder = orders.get(0);
	        firstOrder.setOrderDisplayId();  // 주문번호 포맷 설정 (예: 20250803-0000001)

	        model.addAttribute("orders", orders);
	        model.addAttribute("firstOrder", firstOrder);

	        return "mypage/order_detail";
	    }


	
	@GetMapping("/mypage/order_history")
	public String showOrderHistory() {
	    return "mypage/order_history";
	}
}
