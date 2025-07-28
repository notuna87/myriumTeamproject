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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.Criteria;
import com.myrium.domain.NoticeVO;
import com.myrium.domain.PageDTO;
import com.myrium.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/notice/*")
@RequiredArgsConstructor
public class NoticeController {

	private final NoticeService noticeservice;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("notice list__________");
		log.info(cri);
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));	
		
		List<NoticeVO> list = noticeservice.getList(cri, isAdmin);
		
		list.forEach(notice -> log.info(notice));
		model.addAttribute("list", list);

		int total = noticeservice.getTotal(cri, isAdmin);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		// Debug log
		log.info("---------------------------------------------------");

		log.info(authentication);

		System.out.println("Authentication Details:");		
		System.out.println("Principal: " + authentication.getPrincipal());
		System.out.println("Authorities: " + authentication.getAuthorities());

		log.info("---------------------------------------------------");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(NoticeVO vo, @RequestParam("uploadFiles") MultipartFile[] uploadFiles, RedirectAttributes rttr) {
		log.info("notice register......." + vo);

		noticeservice.register(vo);

		rttr.addFlashAttribute("result", vo.getId());
		return "redirect:/notice/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", noticeservice.get(id));
	}
	
	@PreAuthorize("principal.username == #notice.customerId")
	@PostMapping("/modify")
	public String modify(NoticeVO notice, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + notice);
		if(noticeservice.modify(notice)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}
	
	@PreAuthorize("principal.username == #customerId")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("harddelete..." + id);
		if(noticeservice.harddel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}

	@PreAuthorize("principal.username == #customerId")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("softdelete..." + id);
		if(noticeservice.softdel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}
	
	
}
