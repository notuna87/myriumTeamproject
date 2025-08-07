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
import com.myrium.domain.SearchCriteria;
import com.myrium.domain.SearchPageDTO;
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
    public String searchResult(SearchCriteria searchcri,@RequestParam("searchKeyword") String searchKeyword, Model model) {
       
    	List<ProductDTO> searchProductList = productservice.getSearchProductList(searchKeyword, searchcri);
        log.info("결과: " + searchProductList);
        int searchResultCount = productservice.searchResultCount(searchKeyword);
        
        log.info(searchResultCount);
        
        model.addAttribute("searchProductList", searchProductList);
        model.addAttribute("searchKeyword", searchKeyword);
    	model.addAttribute("pageMaker", new SearchPageDTO(searchcri,searchResultCount));
    	model.addAttribute("searchResultCount",searchResultCount);

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
