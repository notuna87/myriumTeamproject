package com.myrium.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myrium.service.MemberService;

@RestController
@RequestMapping("/member")
public class MemberRestController {
	
	 private final MemberService memberService;

	    public MemberRestController(MemberService memberService) {
	        this.memberService = memberService;
	    }

	    // 아이디 중복 확인 API
	    @GetMapping("/check-id")
	    public ResponseEntity<String> checkId(@RequestParam String customerId) {
	        boolean isDuplicate = memberService.isCustomerIdDuplicate(customerId);
	        String result = isDuplicate ? "unavailable" : "available";
	        return ResponseEntity.ok(result);
	    }

}
