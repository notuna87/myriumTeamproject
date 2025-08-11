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

	    // 0) 로그인 체크
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/login";
	    }

	    Long userId = loginUser.getId();
	    String customerId = loginUser.getCustomerId();

	    // 1) DB에 저장할 웹 경로 (없으면 null)
	    String webPath = null;

	    // 2) 이미지 파일 저장 처리 (자동 폴더 생성)
	    if (file != null && !file.isEmpty()) {
	        try {
	            String uploadRoot = "C:/upload"; 
	            String datePath   = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());

	            java.nio.file.Path saveDir = java.nio.file.Paths.get(uploadRoot, "review", datePath);
	            java.nio.file.Files.createDirectories(saveDir);   //폴더 자동 생성 (있으면 통과)

	            // 안전한 파일명 + 확장자 유지
	            String original = org.springframework.util.StringUtils.cleanPath(file.getOriginalFilename());
	            String ext = "";
	            int dot = (original != null) ? original.lastIndexOf('.') : -1;
	            if (dot != -1) ext = original.substring(dot);

	            String savedName = java.util.UUID.randomUUID().toString() + ext;

	            // 실제 저장
	            java.nio.file.Path savePath = saveDir.resolve(savedName);
	            file.transferTo(savePath.toFile());

	            // JSP에서 사용할 "웹 경로" (contextPath는 JSP에서 붙임)
	            webPath = "/upload/review/" + datePath + "/" + savedName;

	        } catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("error", "파일 업로드 실패");
	            return "errorPage";
	        }
	    }

	    // 3) 리뷰 DTO 저장
	    ReviewDTO dto = new ReviewDTO();
	    dto.setReviewTitle(title);
	    dto.setReviewContent(content);
	    dto.setRating(rating);
	    dto.setImageUrl(webPath);           // 이미지 없으면 null
	    dto.setUserId(userId);
	    dto.setCustomerId(customerId);
	    dto.setProductId(productId);
	    dto.setCreatedAt(new java.util.Date());
	    dto.setCreatedBy(customerId);
	    dto.setReviewDate(new java.util.Date());

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
