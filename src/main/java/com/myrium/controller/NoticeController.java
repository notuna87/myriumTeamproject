package com.myrium.controller;

import java.security.Principal;
import java.util.ArrayList;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myrium.domain.AttachFileDTO;
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
		log.info("list__________");
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
	
//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/register")
//	public String register(NoticeVO vo, RedirectAttributes rttr) {
//		log.info("register......." + vo);
//
//		noticeservice.register(vo);
//
//		rttr.addFlashAttribute("result", vo.getId());
//		return "redirect:/notice/list";
//	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/register")
	public String register(NoticeVO vo,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(notice_file) register......." + vo);

	    // 1. JSON 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    List<AttachFileDTO> attachList = new ArrayList<>();
	    try {
	        attachList = mapper.readValue(attachListJson, new TypeReference<List<AttachFileDTO>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }

	    // 2. 공지사항 저장
	    noticeservice.register(vo);

	    // 3. 첨부파일 저장
	    if (attachList != null && !attachList.isEmpty()) {
	        for (AttachFileDTO dto : attachList) {
	            dto.setUserId(vo.getUserId()); // NotiveVO 에서 가져옴
	            dto.setNoticeId(vo.getId());
	            dto.setCustomerId(vo.getCustomerId());
	            dto.setCreatedBy(vo.getCustomerId());
	            dto.setUpdatedAt(vo.getUpdatedAt());
	            dto.setUpdatedBy(vo.getUpdatedBy());
	            
	            log.info("(notice_file) AttachFileDTO......." + dto);

	            noticeservice.insertAttach(dto);
	        }
	    }

	    return "redirect:/notice/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		
		model.addAttribute("notice", noticeservice.get(id));
		//model.addAttribute("attachFiles", noticeservice.findByNoticeId(id));
		List<AttachFileDTO> attachFiles = noticeservice.findByNoticeId(id);
		System.out.println("첨부파일 수: " + attachFiles.size()); // 디버깅
		model.addAttribute("attachFiles", attachFiles);

	}
	
	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
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
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("notice harddelete..." + id);
		if(noticeservice.harddel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("notice softdelete..." + id);
		if(noticeservice.softdel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("notice restore..." + id);
		if(noticeservice.restore(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/notice/list";
	}
	
	
}
