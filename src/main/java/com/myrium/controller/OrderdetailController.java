package com.myrium.controller;

import java.util.ArrayList;
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

import lombok.extern.log4j.Log4j;
	
	@Controller
	@Log4j
	public class OrderdetailController {

	    @Autowired
	    private OrderService orderService;

	    @GetMapping("/mypage/order_detail")
	    public String showOrderDetail(@RequestParam("orderId") Long orderId,
	                                  @RequestParam(value = "productId", required = false) Integer productId,
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

	        // 유효 상품만 추출 (환불/교환 제외)
	        List<OrderDTO> validOrders = new ArrayList<>();
	        for (OrderDTO dto : orders) {
	            int status = dto.getOrderStatus();
	            if (status!=7 && status!=6
	                    && status!=5 && status!=4) {
	                validOrders.add(dto);
	            }
	        }

	        // 결제 금액 계산 (환불/교환 제외)
	        int totalAmount = orderService.getValidOrderTotalAmount(orderId);
	        
	        int shippingFee = (totalAmount == 0) ? 0 : (totalAmount < 50000 ? 3000 : 0);
	        int totalPrice = totalAmount + shippingFee;
	        
	        model.addAttribute("totalAmount", totalAmount);
	        model.addAttribute("shippingFee", shippingFee);
	        model.addAttribute("totalPrice", totalPrice);

	        // 대표 상품 설정
	        OrderDTO firstOrder = orders.get(0);
	        if (productId != null) {
	            for (OrderDTO dto : orders) {
	                if (dto.getProductId() == productId) {
	                    firstOrder = dto;
	                    break;
	                }
	            }
	        }
	        firstOrder.setOrderDisplayId();
	        log.info("first : " + firstOrder);
	        log.info("orders :" + orders);
	        
	        model.addAttribute("firstOrder", firstOrder);
	        model.addAttribute("orders", orders);

	        // 상태 표시용 로직
	        if (productId != null) {
	            model.addAttribute("orderStatus", validOrders.get(0).getOrderStatusText());
	        } else {
	            if (!validOrders.isEmpty()) {
	                model.addAttribute("orderStatus", validOrders.get(0).getOrderStatusText());
	            } else {
	                model.addAttribute("orderStatus", new OrderDTO(7).getOrderStatusText());
	            }
	        }

	        return "mypage/order_detail";
	    }

}
