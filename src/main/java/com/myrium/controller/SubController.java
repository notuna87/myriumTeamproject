package com.myrium.controller;


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
public class SubController {

	private final ProductService productservice;
	
	@GetMapping("/sub")
	public String goSub(@RequestParam("id") int id, Model model) {
		
		ProductDTO product_id = productservice.productInfoget(id);
		ProductDTO thumbnail = productservice.productInfothumbnail(id);
        ProductDTO productSliderImg = productservice.productSliderImg(id);

        
		
		model.addAttribute("product", product_id.getProduct());
		model.addAttribute("thumbnail", thumbnail.getThumbnail());
		model.addAttribute("productSliderImg", productSliderImg.getSliderImg());
		
	    log.info(id);
	    log.info(product_id);
	    log.info(thumbnail);
	    log.info(productSliderImg);
		
		return "sub/sub";
	}
}
