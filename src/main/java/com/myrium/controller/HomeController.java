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

/**
 * Handles requests for the application home page.
 */

//메인페이지 작업을 위한 컨트롤러 작성
//작성자 : 노기원
//작성일 : 2025.07.23 12:45
@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
// MAIN CONTROLLER 작성을 위하여 전부 주석처리.
// 작성자 : 노기원
// 작성일 : 2025.07.22 17:00
//	
//	/**
//	 * Simply selects the home view to render by returning its name.
//	 */
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
//	
	private final ProductService productservice;
	
    @GetMapping("/")
    public String goHome(Model model) {
    	
        List<ProductDTO> ceoPickList = productservice.getProductWithThumbnailList("ceopick");
        List<ProductDTO> springList = productservice.getProductWithThumbnailList("spring");
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
