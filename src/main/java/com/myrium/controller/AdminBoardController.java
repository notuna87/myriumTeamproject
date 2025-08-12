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

import com.myrium.domain.BoardVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.PageDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.service.AdminBoardService;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/adminboard/*")
@RequiredArgsConstructor
public class AdminBoardController {

	private final AdminBoardService boardservice;
	private final ProductService productservice;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list__________");
		log.info(cri);
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));		
		
		List<BoardVO> list = boardservice.getList(cri, isAdmin);
		
		list.forEach(board -> log.info(board));
		model.addAttribute("list", list);

		int total = boardservice.getTotal(cri, isAdmin);
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
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("register......." + vo);

		boardservice.register(vo);

		rttr.addFlashAttribute("result", vo.getId());
		return "redirect:/adminboard/list";
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(@RequestParam(required = false) Integer productid, Model model) {
		
		if(productid != null) {
			ProductDTO getProductInfo = productservice.getProductInfoWithThumbnail(productid);
			log.info(getProductInfo);
			
			model.addAttribute("product", getProductInfo);
			model.addAttribute("productid",productid);
		}

	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", boardservice.get(id));
	}
	
	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		if(boardservice.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminboard/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("harddelete..." + id);
		if(boardservice.harddel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminboard/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("softdelete..." + id);
		if(boardservice.softdel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminboard/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("board restore..." + id);
		if(boardservice.restore(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminboard/list";
	}
	
	
}
