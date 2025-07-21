package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

	@GetMapping("/login")
	public String showJoinform() {
		return "login/login";
	}
	
	@GetMapping("/login/find_id")
	public String showCompletePage() {
	    return "login/find_id";
	}
}
