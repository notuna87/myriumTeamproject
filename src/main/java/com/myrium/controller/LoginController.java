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
	public String showFindIdPage() {
	    return "login/find_id";
	}

	@GetMapping("/login/find_pw")
	public String showFindPwPage() {
	    return "login/find_pw";
	}
	
	@GetMapping("/home")
	public String showhome() {
		return "home";
	}

}
