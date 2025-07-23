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
    
    @GetMapping("/mypage/change_password")
    public String showchangepw() {
        return "mypage/change_password";
    }
    
    @GetMapping("/mypage/member_update")
    public String showmemberupdate() {
        return "mypage/member_update";
    }
}
