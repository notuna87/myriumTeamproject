package com.myrium.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myrium.domain.ReviewDTO;
import com.myrium.service.ReviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class TotalReviewController {

	
	private final ReviewService reviewService;

	@GetMapping("/total_review")
	public String total(
	        @RequestParam(value = "q", required = false) String q,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "size", required = false) Integer size, // 사용자가 준 값 무시하고 5로 고정
	        Model model) {

	    final int pageSize = 5;                 // 한 페이지 5개 고정
	    page = Math.max(1, page);              // 음수/0 방지

	    int total = reviewService.countReviews(q);
	    int last  = (int) Math.ceil(total / (double) pageSize);
	    if (last == 0) last = 1;               // 검색결과 0개일 때 안전값

	    // 현재 페이지가 마지막 범위를 넘어가면 끌어내림
	    if (page > last) page = last;

	    int offset = (page - 1) * pageSize;
	    List<ReviewDTO> reviews = reviewService.findReviews(q, offset, pageSize);

	    // 페이지 네비 계산 (현재 기준 좌우 2칸, 최대 5버튼)
	    int start = Math.max(1, Math.min(page - 2, Math.max(1, last - 4)));
	    int end   = Math.min(last, start + 4);

	    model.addAttribute("reviews", reviews);

	    model.addAttribute("paginationCurrent", page);
	    model.addAttribute("paginationStart", start);
	    model.addAttribute("paginationEnd", end);
	    model.addAttribute("paginationPrev", Math.max(1, page - 1));
	    model.addAttribute("paginationNext", Math.min(last, page + 1));

	    model.addAttribute("total", total);
	    model.addAttribute("last", last);
	    model.addAttribute("size", pageSize);
	    model.addAttribute("q", q == null ? "" : q);

	    return "total_review";
	}
}

