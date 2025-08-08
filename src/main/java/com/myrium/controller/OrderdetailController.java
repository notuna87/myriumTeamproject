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
	            return "redirect:/mypage/order-history";
	        }

	        List<OrderDTO> validOrders = new ArrayList<>();
	        for (OrderDTO dto : orders) {
	            int status = dto.getOrderStatus();
	            if (status != 7 && status != 6 && status != 5 && status != 4) {
	                validOrders.add(dto);
	            }
	        }

	        int totalAmount = orderService.getValidOrderTotalAmount(orderId);
	        int shippingFee = (totalAmount == 0) ? 0 : (totalAmount < 50000 ? 3000 : 0);
	        int totalPrice = totalAmount + shippingFee;

	        model.addAttribute("totalAmount", totalAmount);
	        model.addAttribute("shippingFee", shippingFee);
	        model.addAttribute("totalPrice", totalPrice);

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
	        model.addAttribute("firstOrder", firstOrder);
	        model.addAttribute("orders", orders);

	        String statusText = !validOrders.isEmpty() ? validOrders.get(0).getOrderStatusText() : firstOrder.getOrderStatusText();
	        model.addAttribute("orderStatus", statusText);

	        // ✅ 누락되면 안 되는 최종 반환값
	        return "mypage/order_detail";
	    }
	}
	

