package com.myrium.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.service.MemberService;

@Controller
@RequestMapping("/login") 
public class FindpwController {

	 @Autowired
	    private MemberService memberService;
	
    @GetMapping("/find_pw")
    public String showFindIdForm() {
        return "login/find_pw"; 
    }
    

    @PostMapping("/find_pw")
    public String findPassword(@RequestParam String customerId,
                               @RequestParam String customerName,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String phoneNumber,
                               Model model) {

        String password = null;

        if (email != null && !email.isEmpty()) {
            password = memberService.findPasswordByEmail(customerId, customerName, email);
        } else if (phoneNumber != null && !phoneNumber.isEmpty()) {
            password = memberService.findPasswordByPhone(customerId, customerName, phoneNumber);
        }

        if (password == null) {
            // 정보 일치하지 않을 때 → 쿼리 파라미터로 error=Y 추가
            return "redirect:/login/find_pw_result?error=Y";
        }

        model.addAttribute("password", password);
        return "login/find_pw_result";
    }

    @GetMapping("/find_pw_result")
    public String showFindPwResultPage() {
        return "login/find_pw_result"; 
    }
    
}