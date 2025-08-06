package com.myrium.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.ProductDTO;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class SearchController {

    private final ProductService productservice;
	
    @GetMapping("/search")
    public String goSearch() {
    
        return "/search/searchPage";
    }
	
    @GetMapping("/search/result")
    public String searchResult(@RequestParam("searchKeyword") String searchKeyword, Model model) {
        List<ProductDTO> searchProductList = productservice.getSearchProductList(searchKeyword);
        log.info("결과: " + searchProductList);
        
        model.addAttribute("searchProductList", searchProductList);
        model.addAttribute("searchKeyword", searchKeyword);
        
        log.info("리스트 : "+searchProductList);
        
        return "/search/searchPage";
    }
	
    @PostMapping("/search")
    public String searchProduct(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	
    	String searchKeyword = request.getParameter("productSearch");
    	log.info(searchKeyword);
    	
        redirectAttributes.addAttribute("searchKeyword", searchKeyword);

		return "redirect:/search/result";
    }
    
    
}
