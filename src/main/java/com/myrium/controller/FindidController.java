package com.myrium.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.MemberVO;
import com.myrium.mapper.MemberMapper;

@Controller
@RequestMapping("/") 
public class FindidController {

	@Autowired
	private MemberMapper memberMapper;
	
    @GetMapping("/find_id")
    public String showFindIdForm() {
        return "login/find_id"; 
    }
    
    @PostMapping("/find_id_result")
    public String findIdResult(@RequestParam String customerName,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String phoneNumber,
                               @RequestParam String method, // "email" 또는 "phone"
                               Model model) {
        MemberVO member = null;

        if ("email".equals(method)) {
            member = memberMapper.findByNameAndEmail(customerName, email);
        } else if ("phone".equals(method)) {
            member = memberMapper.findByNameAndPhone(customerName, phoneNumber);
        }

        if (member != null) {
            model.addAttribute("member", member);
            return "find_id_result"; // JSP 결과 페이지
        } else {
            model.addAttribute("error", "일치하는 정보가 없습니다.");
            return "find_id"; // 다시 입력 폼으로
        }
    }
}
