package com.myrium.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import com.myrium.domain.PageDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;
import com.myrium.service.AdminProductService;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/product/*")
@RequiredArgsConstructor()
public class AdminProductController {

	private final AdminProductService service;
	private final ProductService productservice;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list__________");
		log.info(cri);
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));		
		
		List<ProductDTO> list = productservice.getProductCategoryList(cri, isAdmin);
		
		log.info(list);
		model.addAttribute("list", list);

		int total = service.getTotal(cri, isAdmin);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		// Debug log
		log.info("---------------------------------------------------");

		log.info(list);
		log.info(authentication);

		System.out.println("Authentication Details:");		
		System.out.println("Principal: " + authentication.getPrincipal());
		System.out.println("Authorities: " + authentication.getAuthorities());

		log.info("---------------------------------------------------");
	}
	
//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/register")
//	public String register(ProductVO vo, RedirectAttributes rttr) {
//		log.info("register......." + vo);
//
//		productservice.register(vo);
//
//		rttr.addFlashAttribute("result", vo.getId());
//		return "redirect:/product/list";
//	}
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/register")
	public String register(ProductVO vo,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(product) register......." + vo);

	    // 1. JSON 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    List<AttachFileDTO> attachList = new ArrayList<>();
	    try {
	        attachList = mapper.readValue(attachListJson, new TypeReference<List<AttachFileDTO>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    
	    // hasFiles 설정
//	    vo.setHasFiles((attachList != null && !attachList.isEmpty()) ? 1 : 0);
	    // 2. 공지사항 저장
	    service.register(vo);
	    
	    // 3. 첨부파일 목록 저장
//	    if (attachList != null && !attachList.isEmpty()) {
//	        for (AttachFileDTO dto : attachList) {
//	            dto.setUserId(vo.getUserId()); // NotiveVO 에서 가져옴
//	            dto.setProductId(vo.getId());
//	            dto.setCustomerId(vo.getCustomerId());
//	            dto.setCreatedBy(vo.getCustomerId());
//	            dto.setUpdatedAt(vo.getUpdatedAt());
//	            dto.setUpdatedBy(vo.getUpdatedBy());
//	            
//	            log.info("(product) AttachFileDTO......." + dto);
//
//	            service.insertAttach(dto);
//	        }
//	    }

	    return "redirect:/product/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		service.incrementReadCnt(id);  // 조회수 증가 로직 (추가)
		model.addAttribute("product", service.get(id));
		//model.addAttribute("attachFiles", productservice.findByProductId(id));
		List<AttachFileDTO> attachFiles = service.findByProductId(id);
		System.out.println("첨부파일 수: " + attachFiles.size()); // 디버깅
		model.addAttribute("attachFiles", attachFiles);

	}
	
	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/modify")
	public String modify(ProductVO vo,
			@RequestParam(value = "attachList", required = false) String attachListJson,
			@RequestParam(value = "deleteFiles", required = false) String deleteFiles,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		log.info("modify:" + vo);
		
	    // 1. JSON 파싱
		ObjectMapper mapper = new ObjectMapper();
	    List<AttachFileDTO> attachList = new ArrayList<>(); // null을 방지하기 위해 빈 리스트로 초기화
	    // json 데이터가 null이거나 비어있는 경우를 대비한 방어 코드를 추가합니다.
	    if (attachListJson != null && !attachListJson.trim().isEmpty()) {
	        try {
	            attachList = mapper.readValue(attachListJson, new TypeReference<List<AttachFileDTO>>(){});
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    // 1. 기존 첨부파일 삭제
	    if (deleteFiles != null && !deleteFiles.isEmpty()) {
	        String[] uuids = deleteFiles.split(",");
	        for (String uuid : uuids) {
	            service.deleteAttachByUuid(uuid); // delete 쿼리 실행
	        }
	    }
		
	    // hasFiles 설정
//	    vo.setHasFiles((attachList != null && !attachList.isEmpty()) ? 1 : 0);
	    // 2. 공지사항 업데이트
	    service.modify(vo);
	    
	    // 3. 첨부파일 목록 저장
//	    if (attachList != null && !attachList.isEmpty()) {
//	        for (AttachFileDTO dto : attachList) {
//	            dto.setUserId(vo.getUserId()); // NotiveVO 에서 가져옴
//	            dto.setProductId(vo.getId());
//	            dto.setCustomerId(vo.getCustomerId());
//	            dto.setCreatedBy(vo.getCustomerId());
//	            dto.setUpdatedAt(vo.getUpdatedAt());
//	            dto.setUpdatedBy(vo.getUpdatedBy());
//	            
//	            log.info("(product) AttachFileDTO......." + dto);
//
//	            service.insertAttach(dto);
//	        }
//	    }
		if(service.modify(vo)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") Long id,
	                      @ModelAttribute("cri") Criteria cri,
	                      RedirectAttributes rttr,
	                      String customerId) {

	    log.info("product harddelete..." + id);

	    try {
	    	ProductVO product = service.get(id);
	        if (product == null) {
	            rttr.addFlashAttribute("error", "존재하지 않는 게시글입니다.");
	            return "redirect:/product/list";
	        }

	        List<AttachFileDTO> attachList = service.findByProductId(id);

	        for (AttachFileDTO file : attachList) {
	            String baseDir = "C:/upload/";
	            String filePath = baseDir + "/" + file.getUuid() + "_" + file.getFileName();
	            File target = new File(filePath);

	            if (target.exists() && !target.delete()) {
	                log.warn("파일 삭제 실패: " + filePath);
	            }

	            if (file.getImage() == 1) {
	                File thumb = new File(baseDir + file.getUploadPath() + "/s_" + file.getUuid() + "_" + file.getFileName());
	                if (thumb.exists() && !thumb.delete()) {
	                    log.warn("썸네일 삭제 실패: " + thumb.getPath());
	                }
	            }

	            // DB 첨부파일 삭제 (항상 실행)
	            service.deleteAttachByUuid(file.getUuid());
	        }

	        if (service.harddel(id)) {
	            rttr.addFlashAttribute("result", "success");
	        } else {
	            rttr.addFlashAttribute("error", "게시글 삭제 실패");
	        }

	    } catch (Exception e) {
	        log.error("하드삭제 중 예외 발생", e);
	        rttr.addFlashAttribute("error", "서버 오류로 삭제하지 못했습니다.");
	    }

	    // redirect paging params
	    rttr.addAttribute("pageNum", cri.getPageNum());
	    rttr.addAttribute("amount", cri.getAmount());
	    rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());

	    return "redirect:/product/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("product softdelete..." + id);
		if(service.softdel(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}

	@PreAuthorize("hasAuthority('ADMIN') or principal.username == #customerId")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String customerId) {
		log.info("product restore..." + id);
		if(service.restore(id)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}
	
}
