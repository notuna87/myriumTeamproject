package com.myrium.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	                                  Model model,
	                                  RedirectAttributes rttr) {

	        if (authentication == null || !authentication.isAuthenticated()
	                || "anonymousUser".equals(String.valueOf(authentication.getPrincipal()))) {
	            rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
	            return "redirect:/login";
	        }
	        Object principal = authentication.getPrincipal();
	        if (!(principal instanceof CustomUser)) {
	            rttr.addFlashAttribute("msg", "세션이 만료되었습니다. 다시 로그인해 주세요.");
	            return "redirect:/login";
	        }
	        CustomUser user = (CustomUser) principal;
	        MemberVO member = user.getMember();
	        if (member != null) {
	            model.addAttribute("customerName", member.getCustomerName());
	        }

	        List<OrderDTO> orders = orderService.getOrderDetail(orderId);
	        if (orders == null || orders.isEmpty()) {
	            rttr.addFlashAttribute("msg", "주문을 찾을 수 없습니다.");
	            return "redirect:/mypage/order-history";
	        }

	        int totalAmount = orderService.getValidOrderTotalAmount(orderId);
	        int shippingFee = (totalAmount == 0) ? 0 : (totalAmount < 50000 ? 3000 : 0);
	        int totalPrice  = totalAmount + shippingFee;
	        model.addAttribute("totalAmount", totalAmount);
	        model.addAttribute("shippingFee", shippingFee);
	        model.addAttribute("totalPrice", totalPrice);

	        OrderDTO firstOrder = orders.get(0);
	        if (productId != null) {
	            for (OrderDTO dto : orders) {
	                if (dto.getProductId() == productId.intValue()) {
	                    firstOrder = dto;
	                    break;
	                }
	            }
	        }
	        firstOrder.setOrderDisplayId();

	        String headerStatusText;
	        if (productId != null) {
	            headerStatusText = firstOrder.getOrderStatusText();
	        } else {
	            Set<Integer> distinct = new HashSet<>();
	            for (OrderDTO dto : orders) distinct.add(dto.getOrderStatus());
	            headerStatusText = (distinct.size() == 1)
	                    ? orders.get(0).getOrderStatusText()
	                    : "진행상태(부분)";
	        }

	        // 6) 모델 바인딩
	        model.addAttribute("firstOrder", firstOrder);
	        model.addAttribute("orders", orders);
	        model.addAttribute("orderStatus", headerStatusText);

	        return "mypage/order_detail";
	    }

	}
	

