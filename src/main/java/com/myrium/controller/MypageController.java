package com.myrium.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    
    @GetMapping("/mypage/order/list")
    public String showOrderList(Authentication authentication, RedirectAttributes rttr) {
        if (authentication == null || !authentication.isAuthenticated()) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
            return "redirect:/login";  //login.jsp로 리다이렉트
        }
        return "mypage/mypage"; // 로그인 된 경우만
    }

}
