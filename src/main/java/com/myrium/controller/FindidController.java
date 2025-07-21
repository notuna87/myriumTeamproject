package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FindidController {
	
	@GetMapping("/find_id")
	public String showJoinform() {
		return "login/find_id";
	}
	
	@GetMapping("/login/find_id_result")
	public String showCompletePage() {
	    return "login/find_id_result";
	}
}
