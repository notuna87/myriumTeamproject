package com.myrium.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.CartVO;
import com.myrium.domain.ProductDTO;
import com.myrium.security.domain.CustomUser;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class CartController {

	private final ProductService productservice;

	@GetMapping("/cart")
	public String goCart(Model model) {

		// 로그인한 사용자 정보 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		Long userId = userDetails.getMember().getId();

		List<ProductDTO> cartList = productservice.CartList(userId);

		model.addAttribute("cartList", cartList);

		log.info(cartList);

		return "purchase/cart";
	}

	@PostMapping("/cart")
	public String inCrat(CartVO cart, HttpServletRequest request, RedirectAttributes rttr) {

		// 로그인한 사용자 정보 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		Long userId = userDetails.getMember().getId();
		String customerId = userDetails.getMember().getCustomerId();

		// jsp에서 수량 받아와 변수 저장
		String quantityStr = request.getParameter("quantity");
		int quantity = Integer.parseInt(quantityStr);

		// jsp로부터 상품 id값 받아와 저장
		String productIdStr = request.getParameter("productId");
		int productId = Integer.parseInt(productIdStr);

		ProductDTO inCart = productservice.inCart(quantity, productId, userId, customerId);

		return "redirect:/cart";
	}

	@PostMapping(value = "/cart/updateQuantity", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updateQuantity(@RequestBody CartVO cartVO) {
		try {
			Long productId = cartVO.getProductId();
			int quantity = cartVO.getQuantity();
			// userid 가져오기
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			CustomUser userDetails = (CustomUser) authentication.getPrincipal();
			Long userId = userDetails.getMember().getId();

			productservice.updateQuantity(productId, quantity, userId);

			Map<String, String> response = new HashMap<>();
			response.put("message", "수량 변경 성공");
			return ResponseEntity.ok(response);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "서버 오류 발생"));
		}
	}

	@PostMapping(value = "/cart/delete", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteCart(@RequestBody CartVO cartvo) {
	    Map<String, String> response = new HashMap<>();

	    try {
	        Long productId = cartvo.getProductId();

	        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        CustomUser userDetails = (CustomUser) authentication.getPrincipal();
	        Long userId = userDetails.getMember().getId(); 

	        log.info("딜리트 포스트 호출");
	        log.info("productId" + productId);
	        log.info("userId" + userId);

	        productservice.deleteCart(productId, userId);
	        response.put("status", "ok");

	        return ResponseEntity.ok(response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("error", "삭제 실패");
	        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
}
}