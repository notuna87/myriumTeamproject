package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

// 메인페이지 작업을 위한 컨트롤러 작성
// 작성자 : 노기원
// 작성일 : 2025.07.22 17:00
@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class MainController {
 
	private final ProductService productservice;
	
	@GetMapping("/test")
	public void list(Model model) {
		model.addAttribute("list",productservice.getProductList());
		model.addAttribute("imgPath",productservice.getThumbnail(5));
	}
}
