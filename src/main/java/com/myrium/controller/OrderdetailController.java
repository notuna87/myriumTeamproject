package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderdetailController {
	
	@GetMapping("/order_detail")
	public String showJoinform() {
		return "mypage/order_detail";
	}
	
	@GetMapping("/mypage/order_history")
	public String showOrderHistory() {
	    return "mypage/order_history";
	}
}
