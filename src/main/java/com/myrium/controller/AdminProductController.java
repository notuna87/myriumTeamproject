package com.myrium.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.myrium.domain.PageDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;
import com.myrium.mapper.AdminProductMapper;
import com.myrium.service.AdminProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/adminproduct/*")
@RequiredArgsConstructor()
public class AdminProductController {

	private final AdminProductService service;
	
	private final AdminProductMapper adminproductmapper;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list__________");
		log.info(cri);
		
	    // 현재 로그인 사용자 권한 조회
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));		
		
		List<ProductDTO> list = service.getProductListWithCategory(cri, isAdmin);
		
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
						   CategoryVO cat,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(product) register......." + vo);
		log.info("(product) register......." + cat);
		log.info("(product) register......." + attachListJson);

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
	    
	    // 3. 카테고리 등록
	    cat.setProduct_id(vo.getId());
	    service.insertCategory(cat);
	    
	    // 3. 이미지 경로(첨부파일) 등록
	    if (attachList != null && !attachList.isEmpty()) {
	        for (AttachFileDTO dto : attachList) {
	            ImgpathVO imgVO = new ImgpathVO();

	            imgVO.setProduct_id(vo.getId());
	            imgVO.setImg_path(dto.getUploadPath() + "/" + dto.getUuid() + "_" + dto.getFileName());	            
	            imgVO.setUuid(dto.getUuid());
	            imgVO.setCreated_by(vo.getCreated_by());
	            imgVO.setCreated_at(vo.getCreated_at());
	            imgVO.setUpdated_by(vo.getUpdated_by());
	            imgVO.setUpdated_at(vo.getUpdated_at());
	            imgVO.setIs_thumbnail(dto.getIsThumbnail());
	            imgVO.setIs_thumbnail_main(dto.getIsThumbnailMain());
	            imgVO.setIs_detail(dto.getIsDetail());
	            imgVO.setIs_deleted(0);
	            
	            if(dto.getIsThumbnail() == 1) {
	            	imgVO.setImg_path_thumb(dto.getUploadPath() + "/" + "s_" + dto.getUuid() + "_" + dto.getFileName());
	            }

	            log.info("Saving ImgpathVO: " + imgVO);
	            service.insertImgpath(imgVO);
	        }
	    }

	    return "redirect:/adminproduct/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) throws JacksonException {
		//service.incrementReadCnt(id);  // 조회수 증가 로직 (추가)
		ProductVO productInfo = service.get(id);
		model.addAttribute("product", productInfo);
		System.out.println("product: " + productInfo); // 디버깅
		CategoryVO categoryList = adminproductmapper.getCategoryList(id);
		System.out.println("categoryList: " + categoryList); // 디버깅
		model.addAttribute("category", categoryList);
		//model.addAttribute("attachFiles", service.findByProductId(id));
		List<ImgpathVO> attachImgs = service.findByProductId(id);
		System.out.println("attachImgs: " + attachImgs); // 디버깅
		System.out.println("attachImgs cnt: " + attachImgs.size()); // 디버깅
		//model.addAttribute("attachImgs", attachImgs);
		model.addAttribute("attachImgsJson", new ObjectMapper().writeValueAsString(attachImgs));
		System.out.println("attachImgsJson: " + new ObjectMapper().writeValueAsString(attachImgs)); // 디버깅
		
	}
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modify(ProductVO vo,
				CategoryVO cat,
				@RequestParam(value = "attachList", required = false) String attachListJson,
				@RequestParam(value = "deleteuuids", required = false) String deleteUuids,
				@ModelAttribute("cri") Criteria cri,
				RedirectAttributes rttr) {
		
		log.info("(product) modify......." + vo);
		log.info("(product) modify......." + cat);
		log.info("(product) modify......." + attachListJson);
		
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
	    
	    // 3. 카테고리 등록
	    cat.setProduct_id(vo.getId());
	    service.updateCategory(cat);
	    
	    // 4. 이미지 경로(첨부파일) 등록
	    if (attachList != null && !attachList.isEmpty()) {
	        for (AttachFileDTO dto : attachList) {
	            ImgpathVO imgVO = new ImgpathVO();

	            imgVO.setId(dto.getId());
	            imgVO.setProduct_id(dto.getProductId());
	            imgVO.setImg_path(dto.getUploadPath() + "/" + dto.getUuid() + "_" + dto.getFileName());	            
	            imgVO.setUuid(dto.getUuid());
	            imgVO.setCreated_by(vo.getCreated_by());
	            imgVO.setCreated_at(vo.getCreated_at());
	            imgVO.setUpdated_by(vo.getUpdated_by());
	            imgVO.setUpdated_at(vo.getUpdated_at());
	            imgVO.setIs_thumbnail(dto.getIsThumbnail());
	            imgVO.setIs_thumbnail_main(dto.getIsThumbnailMain());
	            imgVO.setIs_detail(dto.getIsDetail());
	            imgVO.setIs_deleted(0);
	            
	            if(dto.getIsThumbnail() == 1) {
	            	imgVO.setImg_path_thumb(dto.getUploadPath() + "/" + "s_" + dto.getUuid() + "_" + dto.getFileName());
	            }
	            int id = imgVO.getId();
	            int product_id = imgVO.getProduct_id();
	            int is_thumbnail_main = imgVO.getIs_thumbnail_main();
	            String uuid = imgVO.getUuid();
        		if(id != 0) {
    	            log.info("dto.getProduct_id: " + imgVO.getProduct_id());
    	            log.info("dto.getImg_path: " + imgVO.getImg_path());
    	            log.info("update ImgpathVO: " + imgVO);
        			//service.updateImgpath(id);
    	            adminproductmapper.updateThumbnailMain(id, is_thumbnail_main);
        		} else {
    	            log.info("insert ImgpathVO: " + imgVO);
    	            service.insertImgpath(imgVO);
        		}
	        }
	    }

	    return "redirect:/adminproduct/list";
	}
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") int id,
	                      @ModelAttribute("cri") Criteria cri,
	                      RedirectAttributes rttr
	                      ) {

	    log.info("product harddelete..." + id);

	    try {
	    	ProductVO product = service.get(id);
	        if (product == null) {
	            rttr.addFlashAttribute("error", "존재하지 않는 상품입니다.");
	            return "redirect:/adminproduct/list";
	        }

	        List<ImgpathVO> imgpathList = service.findByProductId(id);

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

	    return "redirect:/adminproduct/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") int productId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("product softdelete..." + productId);
		if(service.softdel(productId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminproduct/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") int productId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("product restore..." + productId);
		if(service.restore(productId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminproduct/list";
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
