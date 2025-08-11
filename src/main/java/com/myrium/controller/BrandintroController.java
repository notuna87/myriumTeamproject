package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BrandintroController {

	@GetMapping("/brand_intro")
	public String showFindIdPage() {
	    return "/brand_intro";
	}
}
