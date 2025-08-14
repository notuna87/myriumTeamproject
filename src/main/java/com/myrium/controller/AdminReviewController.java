package com.myrium.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myrium.domain.Criteria;
import com.myrium.domain.PageDTO;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;
import com.myrium.service.AdminReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/adminreview/*")
public class AdminReviewController {

	private final AdminReviewService service;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
	    
	    List<ReviewsummaryVO> productReviewSummary = service.getReviewList(cri);	    
	    model.addAttribute("productReviewSummary", productReviewSummary);

	    int total = service.getDistinctProductCount(cri);
	    model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping("/productreviewlist")
	@ResponseBody
	public Map<String, Object> reviewlist(Criteria cri, int productId) {

	    List<ReviewDTO> list = service.getReviewListByproduct(cri, productId);
	    int total = service.getReviewCountByProductId(cri, productId);

	    Map<String, Object> result = new HashMap<>();
	    result.put("list", list);
	    result.put("pagination", new PageDTO(cri, total));
	    log.info("pagination: " + result);
	    return result;
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/harddel")
	public Map<String, Object> harddel(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.harddel(reviewId);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 삭제되었습니다." : "삭제 실패했습니다.");
	    return result;
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/softdel")
	public Map<String, Object> softdel(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.softdel(reviewId);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 숨김되었습니다." : "숨김 실패했습니다.");
	    return result;
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/restore")
	public Map<String, Object> restore(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.restore(reviewId);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 복구되었습니다." : "복구 실패했습니다.");
	    return result;
	}
	

}
