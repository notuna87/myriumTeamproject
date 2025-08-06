package com.myrium.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myrium.domain.ProductDTO;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private final ProductService productservice;
	
    @GetMapping("/")
    public String goHome(Model model) {
    	
        List<ProductDTO> ceoPickList = productservice.getProductWithThumbnailList("is_mainone");
        List<ProductDTO> springList = productservice.getProductWithThumbnailList("is_maintwo");
        List<ProductDTO> timesaleList = productservice.getTimesaleWithThumbnailList();
        
	    model.addAttribute("ceopickList", ceoPickList);
	    model.addAttribute("springList", springList);
	    model.addAttribute("timesaleList",timesaleList);
	    return "home";
    }
    
    @GetMapping("/admin")
    public String adminPage() {
    	return "admin"; // leedy
    }

}
