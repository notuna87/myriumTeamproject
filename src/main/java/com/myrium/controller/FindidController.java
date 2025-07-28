package com.myrium.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.MemberVO;
import com.myrium.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/login") 
public class FindidController {

	@Autowired
	private MemberMapper memberMapper;
	
    
	@PostMapping("/find_id_result")
	public String findIdResult(@RequestParam String customerName,
	                           @RequestParam(required = false) String email,
	                           @RequestParam(required = false) String phone1,
	                           @RequestParam(required = false) String phone2,
	                           @RequestParam(required = false) String phone3,
	                           @RequestParam String method,
	                           Model model) {

	    log.info(">>> 아이디 찾기 요청 - 이름: " + customerName);
	    log.info(">>> 인증 방법: " + method);
	    log.info(">>> 이메일: " + email);
	    log.info(">>> 휴대폰번호 파라미터: " + phone1 + "-" + phone2 + "-" + phone3);

	    String phoneNumber = null;
	    if (phone1 != null && phone2 != null && phone3 != null) {
	        phoneNumber = phone1 + "-" + phone2 + "-" + phone3;
	    }

	    MemberVO member = null;

	    if ("email".equals(method)) {
	        member = memberMapper.findByNameAndEmail(customerName, email);
	    }  else if ("phone".equals(method)) {
	        member = memberMapper.findByNameAndPhone(customerName, phoneNumber);

	        // 가운데 마스킹 처리
	        if (phone1 != null && phone3 != null) {
	            String maskedPhone = phone1 + "-****-" + phone3;
	            model.addAttribute("phoneNumber", maskedPhone);
	        }
	    }

	    log.info(">>> 조회된 회원 정보: " + member);

	    if (member != null) {
	        model.addAttribute("member", member);
	        return "login/find_id_result";
	    } else {
	        return "redirect:/login/find_id_result?error=Y";
	    }
	}

	

    // GET: 직접 URL 접근 시 기본 화면만 보여주기
    @GetMapping("/find_id_result")
    public String showFindIdResultPage() {
        return "login/find_id_result";  // member 정보 없이 빈 화면일 수 있음
    }
}
