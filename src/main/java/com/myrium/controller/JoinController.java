package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JoinController {
	
	@GetMapping("/join")
	public String showJoinform() {
		return "join/join";
	}
	
	@GetMapping("/join/complete")
	public String showCompletePage() {
	    return "join/complete";
	}
}
