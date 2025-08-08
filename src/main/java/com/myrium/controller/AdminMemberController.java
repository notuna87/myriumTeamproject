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

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;
import com.myrium.domain.PageDTO;
import com.myrium.mapper.AdminProductMapper;
import com.myrium.service.AdminMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/adminmember/*")
@RequiredArgsConstructor()
public class AdminMemberController {

	private final AdminMemberService service;
	
	private final AdminProductMapper adminmembermapper;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list__________");
		log.info(cri);
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));		
		
	    List<MemberVO> list = service.getList(cri, isAdmin);
		
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
	public String register(MemberVO vo,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(admin-member) register......." + vo);

		log.info("(admin-member) register......." + attachListJson);

	    // 1. JSON 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    List<AttachFileDTO> attachList = new ArrayList<>();
	    try {
	        attachList = mapper.readValue(attachListJson, new TypeReference<List<AttachFileDTO>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    
	    // 2. 상품 등록
	    service.register(vo);
	    
	    return "redirect:/adminmember/list";
	    
   
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) throws JacksonException {
		//service.incrementReadCnt(id);  // 조회수 증가 로직 (추가)
		MemberVO memberInfo = service.get(id);
		model.addAttribute("member", memberInfo);
		System.out.println("member: " + memberInfo); // 디버깅
		CategoryVO categoryList = adminmembermapper.getCategoryList(id);
		System.out.println("categoryList: " + categoryList); // 디버깅
		model.addAttribute("category", categoryList);
		//model.addAttribute("attachFiles", service.findByProductId(id));
		List<ImgpathVO> attachImgs = service.findByMemberId(id);
		System.out.println("attachImgs: " + attachImgs); // 디버깅
		System.out.println("attachImgs cnt: " + attachImgs.size()); // 디버깅
		//model.addAttribute("attachImgs", attachImgs);
		model.addAttribute("attachImgsJson", new ObjectMapper().writeValueAsString(attachImgs));
		System.out.println("attachImgsJson: " + new ObjectMapper().writeValueAsString(attachImgs)); // 디버깅
		
	}
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modify(MemberVO vo,
				@RequestParam(value = "attachList", required = false) String attachListJson,
				@RequestParam(value = "deleteuuids", required = false) String deleteUuids,
				@ModelAttribute("cri") Criteria cri,
				RedirectAttributes rttr) {
		
		log.info("(member) modify......." + vo);

		log.info("(member) modify......." + attachListJson);
		
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
	    
	    log.info("attachList:" + attachList);
	    log.info("deleteUuids:" + deleteUuids);
	    
	    // 1. 기존 첨부파일 삭제
	    // 삭제 대상 처리
	    if (deleteUuids != null && !deleteUuids.trim().isEmpty()) {
	        String[] uuids = deleteUuids.split(",");

	        for (String uuid : uuids) {
	            // DB 삭제
	            service.deleteImgpathByUuid(uuid);

	            // 저장소 경로
	            String uploadFolder = "C:/upload/";
	            List<ImgpathVO> paths = service.findImgpathByUuid(uuid); // UUID로 기존 경로 찾기

	            for (ImgpathVO pathVO : paths) {
	                // 원본 이미지
	                File file = new File(uploadFolder, pathVO.getImg_path());
	                if (file.exists()) file.delete();

	                // 썸네일 이미지
	                if (pathVO.getImg_path_thumb() != null) {
	                    File thumbFile = new File(uploadFolder, pathVO.getImg_path_thumb());
	                    if (thumbFile.exists()) thumbFile.delete();
	                }
	            }
	        }
	    }

	    // 2. 공지사항 업데이트
	    service.modify(vo);
	    
	    return "redirect:/adminmember/list";
	    
	}
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") int id,
	                      @ModelAttribute("cri") Criteria cri,
	                      RedirectAttributes rttr
	                      ) {

	    log.info("member harddelete..." + id);

	    try {
	    	MemberVO member = service.get(id);
	        if (member == null) {
	            rttr.addFlashAttribute("error", "존재하지 않는 상품입니다.");
	            return "redirect:/admin/member/list";
	        }

	        List<ImgpathVO> imgpathList = service.findByMemberId(id);

	        for (ImgpathVO file : imgpathList) {
	            String baseDir = "C:/upload/";
	            String exist_thumb = file.getImg_path_thumb();
	            String filePath_original = baseDir + file.getImg_path();
	            String filePath_thumb = baseDir + file.getImg_path_thumb();
	            
	            File target_original = new File(filePath_original);
	            File target_thumb = new File(filePath_thumb);

	            if (target_original.exists() && !target_original.delete()) {
	                log.warn("원본이미지 파일 삭제 실패: " + filePath_original);
	            }
	            if (exist_thumb != null && !exist_thumb.isEmpty() && target_thumb.exists() && !target_thumb.delete()) {
	                log.warn("썸네일이미지 파일 삭제 실패: " + filePath_thumb);
	            }

	            // DB img_path 삭제 (fk : product_id) 상품삭제 시 연동 삭제
	            //service.deleteImgpathByUuid(file.getUuid());
	        }

	        if (service.harddel(id)) {
	            rttr.addFlashAttribute("result", "success");
	        } else {
	            rttr.addFlashAttribute("error", "상품 삭제 실패");
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

	    return "redirect:/adminmember/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") int memberId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("member softdelete..." + memberId);
		if(service.softdel(memberId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminmember/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") int memberId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("member restore..." + memberId);
		if(service.restore(memberId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminmember/list";
	}
	
//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/updateThumbnailMain")
//	public ResponseEntity<String> updateMainImage(
//	    @RequestParam("productId") int productId,
//	    @RequestParam("uuid") String uuid) {
//	    
//	    try {
//	        mapper.updateThumbnailMain(productId, uuid);
//	        log.info("updateThumbnailMain: " + productId);
//	        log.info("updateThumbnailMain: " + uuid);
//	        return ResponseEntity.ok("Thumbnail_Main: update success");
//	    } catch (Exception e) {
//	        log.error("updateThumbnailMain error", e);
//	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Thumbnail_Main: update error");
//	    }
//	}
	
}
