package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberupdateController {

	@GetMapping("/member_update")
	public String showJoinform() {
		return "mypage/member_update";
	}
}
