package com.myrium.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.Criteria;
import com.myrium.domain.FaqVO;
import com.myrium.domain.PageDTO;
import com.myrium.service.AdminFaqService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/adminfaq/*")
@RequiredArgsConstructor
public class AdminFaqController {

	private final AdminFaqService faqservice;
	
	@GetMapping("/list")
	public void list(Model model) {
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));		
		
		List<FaqVO> list = faqservice.getList(isAdmin);
		model.addAttribute("list", list);
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(FaqVO vo, RedirectAttributes rttr) {
		faqservice.register(vo);
		rttr.addFlashAttribute("result", vo.getId());
		return "redirect:/adminfaq/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public void get(@RequestParam("id") Long id, Model model) {
		model.addAttribute("faq", faqservice.get(id));
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modify(FaqVO faq, RedirectAttributes rttr) {
		if(faqservice.modify(faq)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/adminfaq/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") Long id, RedirectAttributes rttr, String customerId) {
		if(faqservice.harddel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/adminfaq/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") Long id, RedirectAttributes rttr, String customerId) {
		if(faqservice.softdel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/adminfaq/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") Long id, RedirectAttributes rttr, String customerId) {
		if(faqservice.restore(id)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/adminfaq/list";
	}
	
}
