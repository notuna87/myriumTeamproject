package com.myrium.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class FindidresultController {

	@GetMapping("/find_id_result")
	public String showJoinform() {
		return "login/find_id_result";
	}
	
	@GetMapping("/login/login")
	public String showCompletePage() {
	    return "login/login";
	}
	
}
