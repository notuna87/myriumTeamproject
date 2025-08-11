package com.myrium.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.ProductDTO;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class CategoryPageController {

	private final ProductService productservice;
	
	@GetMapping("/category")
	public String goCategory(Model model, @RequestParam("category") String category){
		
		log.info(category);
		
		if (category.equals("all")) {
			List<ProductDTO> getAllProductList = productservice.getAllProductList();
			model.addAttribute("product",getAllProductList);
			log.info(getAllProductList);
			int count = getAllProductList.size();
			log.info(count);
			model.addAttribute("count",count);
		} else {
			List<ProductDTO> getCategoryList = productservice.getCategoryList(category);
			model.addAttribute("product",getCategoryList);
			log.info(getCategoryList);
			int count = getCategoryList.size();
			log.info(count);
			model.addAttribute("count",count);
		}
		
		return "category";
	}
}
