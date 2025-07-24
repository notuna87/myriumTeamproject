package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CompleteController {

	@GetMapping("/join/complete")
	public String showCompletePage() {
	    return "join/complete"; // complete.jsp
	}
}
