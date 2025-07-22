package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	@GetMapping("/mypage")
	public String showJoinform() {
		return "mypage/mypage";
	}
	
    @GetMapping("/mypage/order-history")
    public String showOrderHistory() {
        return "mypage/order_history";
    }
}
