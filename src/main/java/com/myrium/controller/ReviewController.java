package com.myrium.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.myrium.domain.MemberVO;
import com.myrium.domain.OrderDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ReviewDTO;
import com.myrium.service.OrderService;
import com.myrium.service.ProductService;
import com.myrium.service.ReviewService;

@Controller
@RequestMapping("/mypage")
public class ReviewController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;
	
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
	
	@PostMapping("/review/submit")
	public String submitReview(@RequestParam("title") String title,
	                           @RequestParam("content") String content,
	                           @RequestParam("rating") int rating,
	                           @RequestParam("uploadFile1") MultipartFile file,
	                           @RequestParam("productId") Long productId,
	                           HttpSession session,
	                           Model model) {

	    // 세션에서 로그인 사용자 정보
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    Long userId = loginUser.getId();
	    String customerId = loginUser.getCustomerId();
	   
	    // 파일 저장 - 실제 경로 로직은 생략
	    String fileName = null;

	    // 이미지 파일 저장 처리
	    if (!file.isEmpty()) {
	        try {
	            String originalName = file.getOriginalFilename();
	            String uuid = UUID.randomUUID().toString();
	            String savedName = uuid + "_" + originalName;
	            String uploadPath = "C:/upload/review/";
	            
	            File destination = new File(uploadPath + savedName);
	            file.transferTo(destination);

	            // 브라우저에서 접근 가능한 경로만 저장
	            fileName = "/upload/review/" + savedName;

	        } catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("error", "파일 업로드 실패");
	            return "errorPage";
	        }
	    }

	    // 리뷰 DTO 생성 및 세팅
	    ReviewDTO dto = new ReviewDTO();
	    dto.setReviewTitle(title);
	    dto.setReviewContent(content);
	    dto.setRating(rating);
	    dto.setImageUrl(fileName);
	    dto.setUserId(userId);
	    dto.setCustomerId(customerId);
	    dto.setProductId(productId);
	    dto.setCreatedAt(new Date());
	    dto.setCreatedBy(customerId);
	    dto.setReviewDate(new Date());

	    // DB 저장 처리
	    reviewService.insertReview(dto);

	    return "redirect:/mypage/order-history";
	}
	
	@GetMapping("/review/view")
	public String viewReview(@RequestParam("id") Long reviewId, Model model) {
	    reviewService.incrementViewCount(reviewId);
	    ReviewDTO review = reviewService.getReviewById(reviewId);
	    model.addAttribute("review", review);
	    return "mypage/review";
	}


	@GetMapping("/review/viewAndRedirect") 
	public String viewAndRedirect(@RequestParam("productId") Long productId) {
	    reviewService.incrementViewCountByProductId(productId);
	    return "redirect:/sub?id=" + productId;
	}
}
