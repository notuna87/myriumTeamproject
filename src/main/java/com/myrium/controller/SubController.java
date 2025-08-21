package com.myrium.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.BoardVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ReviewDTO;
import com.myrium.service.AdminBoardService;
import com.myrium.service.ProductService;
import com.myrium.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class SubController {

	//private final ProductService productservice;
	private final AdminBoardService adminboardservice;
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;

	@GetMapping("/sub")
	public String showProductDetail(@RequestParam("id") Long productId,
	                                @RequestParam(value = "page", defaultValue = "1") int page,
	                                Model model) {
	    
	    // ----- 1. 상품 관련 정보 조회 -----
	    ProductDTO product_id = productService.productInfoget(productId.intValue());
	    ProductDTO thumbnail = productService.productInfothumbnail(productId.intValue());
	    ProductDTO productSliderImg = productService.productSliderImg(productId.intValue());
	    ProductDTO productDetailImg = productService.productDetailImg(productId.intValue());
	    List<ProductDTO> popularProduct = productService.getPopularProduct();

	    // ----- 2. 리뷰 페이징 처리 -----
	    int pageSize = 3;
	    int startRow = (page - 1) * pageSize + 1;
	    int endRow = page * pageSize;

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("productId", productId);
	    paramMap.put("startRow", startRow);
	    paramMap.put("endRow", endRow);

	    List<ReviewDTO> reviewList = reviewService.getPagedReviewsByProductId(paramMap);
	    int reviewCount = reviewService.countReviewsByProductId(productId);
	    int totalPages = (int) Math.ceil((double) reviewCount / pageSize);
	    // ----- 3. 평균 평점 조회 -----
	    double averageRating = reviewService.getAverageRatingByProductId(productId);

	    // ----- 4. 모델에 담기 -----
	    model.addAttribute("product", product_id.getProduct());
	    model.addAttribute("thumbnail", thumbnail.getThumbnail());
	    model.addAttribute("productSliderImg", productSliderImg.getSliderImg());
	    model.addAttribute("productDetailImg", productDetailImg.getProductDetailImg());
	    model.addAttribute("popularProduct", popularProduct);

	    model.addAttribute("reviewList", reviewList);
	    model.addAttribute("averageRating", averageRating);
	    model.addAttribute("reviewCount", reviewCount);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);

	    // 문의하기
	    List<BoardVO> boardList = adminboardservice.getBoardList(productId);
	    log.info(boardList);
	    
	    model.addAttribute("boardList", boardList);
	    
	    return "sub/sub";
	}
}
