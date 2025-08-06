package com.myrium.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.OrderDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.service.OrderService;
import com.myrium.service.ProductService;

@Controller
@RequestMapping("/mypage")
public class ReviewController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/review")
	public String showReviewForm(@RequestParam("orderId") Long orderId,
	                             @RequestParam("productId") int productId,
	                             Model model) {
	    
	    // 주문 상세에서 해당 상품 정보 조회
	    OrderDTO orderProduct = orderService.getOrderProduct(orderId, productId);
	    
	    if (orderProduct == null) {
	        return "redirect:/mypage/order-history"; // 없을 경우 처리
	    }

	    model.addAttribute("product", orderProduct); // 상품명, 가격 포함됨
	    return "mypage/review";
	}
	
	@GetMapping("/sub/sub")
	public String showProductDetail(@RequestParam("id") Long productId, Model model) {
	    ProductDTO product = productService.getProductById(productId);
	    model.addAttribute("product", product);
	    return "/sub/sub"; 
	}


}
