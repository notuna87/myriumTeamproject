package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderhistoryController {
	
	@GetMapping("/order_history")
	public String showJoinform() {
		return "mypage/order_history";
	}
}
