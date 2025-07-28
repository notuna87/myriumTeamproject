package com.myrium.controller;

import javax.servlet.http.HttpServletRequest;

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
                               @RequestParam String method,
                               HttpServletRequest request,
                               Model model) {

        String password = null;

        if ("email".equals(method)) {
            if (email != null && !email.isEmpty()) {
                password = memberService.findPasswordByEmail(customerId, customerName, email);
            }
        } else if ("phone".equals(method)) {
            String phone1 = request.getParameter("phone1");
            String phone2 = request.getParameter("phone2");
            String phone3 = request.getParameter("phone3");

            String phoneNumber = phone1 + "-" + phone2 + "-" + phone3;
            System.out.println("조합된 phoneNumber: " + phoneNumber);  // 디버깅용

            if (phoneNumber != null && !phoneNumber.equals("--")) {
                password = memberService.findPasswordByPhone(customerId, customerName, phoneNumber);
            }
        }

        if (password == null) {
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