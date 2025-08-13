package com.myrium.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.PageDTO;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;
import com.myrium.mapper.AdminReviewMapper;
import com.myrium.service.AdminReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/adminreview/*")
@RequiredArgsConstructor()
public class AdminReviewController {

	private final AdminReviewService service;
	
	private final AdminReviewMapper mapper;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
	    log.info("list__________");
	    log.info(cri);
	    
	    //List<ReviewDTO> list = service.getReviewList(cri, isAdmin);
	    //log.info("getReviewList: " + list);
	    
	    List<ReviewsummaryVO> productReviewSummary = mapper.getPagedProductIds(cri);
	    
	    log.info("productIds:" + productReviewSummary);
	    model.addAttribute("productReviewSummary", productReviewSummary);
	    // 주문번호별 그룹핑
	    //Map<Long, List<ReviewDTO>> groupedReviews = productIds.stream()
	    //    .collect(Collectors.groupingBy(ReviewDTO::getProductId));
	    
	    //model.addAttribute("groupedReviews", groupedReviews);
	    
	    //int total = groupedReviews.size();
	    //System.out.println("productId 개수: " + total);
	    //model.addAttribute("pageMaker", new PageDTO(cri, total));

	    // 원본 리스트도 JSON 문자열로 변환 후 JSP에 전달
	    //ObjectMapper mapper = new ObjectMapper();
	    //try {
	    //    String ReviewsJson = mapper.writeValueAsString(list);
	    //    model.addAttribute("ReviewsJson", ReviewsJson);
	    //    log.info("groupedReviews: " + ReviewsJson);
	        
	    //} catch (JsonProcessingException e) {
	    //    log.error("JSON 변환 실패", e);
	    //    model.addAttribute("ReviewsJson", "[]");
	    //}

	    int total = service.getDistinctProductCount(cri);
 	    log.info("getDistinctProductCount: " + total);
	    model.addAttribute("pageMaker", new PageDTO(cri, total));

	    log.info("---------------------------------------------------");
	    //log.info(groupedReviews);
	    //log.info(authentication);
	}
//	@GetMapping("/productreviewlist")
//	@ResponseBody
//	public void reviewlist(Criteria cri, int productId, Model model) {
//		log.info("reviewlist__________");
//		log.info(cri);
//
//		
//		//List<ReviewDTO> list = service.getReviewList(cri, isAdmin);
//		//log.info("getReviewList: " + list);
//		
//		// 주문번호별 그룹핑
//		//Map<Long, List<ReviewDTO>> groupedReviews = list.stream()
//		//		.collect(Collectors.groupingBy(ReviewDTO::getProductId));
//		
//		//model.addAttribute("groupedReviews", groupedReviews);
//		
//		// 원본 리스트도 JSON 문자열로 변환 후 JSP에 전달
//		//ObjectMapper mapper = new ObjectMapper();
//		//try {
//		//	String ReviewsJson = mapper.writeValueAsString(list);
//		//	model.addAttribute("ReviewsJson", ReviewsJson);
//		//	log.info("groupedReviews: " + ReviewsJson);
//			
//		//} catch (JsonProcessingException e) {
//		//	log.error("JSON 변환 실패", e);
//		//	model.addAttribute("ReviewsJson", "[]");
//		//}
//	    List<ReviewDTO> list = service.getReviewListByproduct(cri, productId);
//	    log.info("getReviewListByproduct: " + list);	    
//	    //int total = list.size();
//	    //log.info("리뷰 리스트 갯수: " + total);
//	    model.addAttribute("list", list);
//		int total = service.getTotalOfReviewByProductId(cri, productId);
//		log.info("getTotalOfReviewByProductId: " + total);
//		model.addAttribute("pageMaker", new PageDTO(cri, total));
//		
//		log.info("---------------------------------------------------");
//		//log.info(groupedReviews);
//		//log.info(authentication);
//	}
	@GetMapping("/productreviewlist")
	@ResponseBody
	public Map<String, Object> reviewlist(Criteria cri, int productId) {
	    log.info("reviewlist__________");
	    log.info(cri);

	    List<ReviewDTO> list = service.getReviewListByproduct(cri, productId);
	    int total = service.getTotalOfReviewByProductId(cri, productId);

	    Map<String, Object> result = new HashMap<>();
	    result.put("list", list);
	    log.info("list: " + list);

	    result.put("pagination", new PageDTO(cri, total));
	    log.info("pagination: " + result);
	    return result;
	}
	
	@ResponseBody
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/updateStatus")
	public Map<String, Object> updateReviewStatus(
	        @RequestParam("ReviewsId") String reviewsId,
	        @RequestParam("reviews_product_id") int reviewsProductId,
	        @RequestParam("ReviewStatus") int reviewStatus) {
		log.info("reviewsId: " + reviewsId);
		log.info("reviews_product_id: " + reviewsProductId);
		log.info("reviewStatus: " + reviewStatus);
	    Map<String, Object> result = new HashMap<>();
	    try {
	    	
	        service.updateReviewStatus(reviewsId, reviewsProductId, reviewStatus);
	        
	        result.put("status", "success");
	        result.put("message", "상태가 변경되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", "상태 변경 중 오류가 발생했습니다.");
	    }
	    return result;
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
	public String register(ReviewDTO dto,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(admin-Review) register......." + dto);

		log.info("(admin-Review) register......." + attachListJson);

	    // 1. JSON 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    List<AttachFileDTO> attachList = new ArrayList<>();
	    try {
	        attachList = mapper.readValue(attachListJson, new TypeReference<List<AttachFileDTO>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    
	    // 2. 상품 등록
	    service.register(dto);
	    
	    return "redirect:/adminreview/list";
	    
   
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) throws JacksonException {
		//service.incrementReadCnt(id);  // 조회수 증가 로직 (추가)
		ReviewDTO reviewInfo = service.get(id);
		model.addAttribute("review", reviewInfo);
		System.out.println("review: " + reviewInfo); // 디버깅
		//CategoryVO categoryList = adminmembermapper.getCategoryList(id);
		//System.out.println("categoryList: " + categoryList); // 디버깅
		//model.addAttribute("category", categoryList);
		//model.addAttribute("attachFiles", service.findByProductId(id));
		//List<ImgpathVO> attachImgs = service.findByMemberId(id);
		//System.out.println("attachImgs: " + attachImgs); // 디버깅
		//System.out.println("attachImgs cnt: " + attachImgs.size()); // 디버깅
		//model.addAttribute("attachImgs", attachImgs);
		//model.addAttribute("attachImgsJson", new ObjectMapper().writeValueAsString(attachImgs));
		//System.out.println("attachImgsJson: " + new ObjectMapper().writeValueAsString(attachImgs)); // 디버깅
		
	}
	
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			ReviewDTO dto,
			@RequestParam("role") String role,
			@ModelAttribute("cri") Criteria cri,
			Model model,
			RedirectAttributes rttr) {
		
		log.info("(Review) modify..." + dto);

		log.info("(Review) modify role..." + role);
		
//		Long id = dto.getId();
		
	    // 1. 비밀번호 확인
//	    String passwordConfirm = request.getParameter("passwordConfirm");
//	    if (!dto.getPassword().equals(passwordConfirm)) {
//	    	log.info("(Review) modify...비밀번호" + dto);
//	        model.addAttribute("pwMatchError", "비밀번호가 일치하지 않습니다.");
//	        return "redirect:/adminreview/modify?id=" + id;
//	    }
//		
//	    // 2. 휴대폰 번호 조합
//	    String phone1 = request.getParameter("phone1");
//	    String phone2 = request.getParameter("phone2");
//	    String phone3 = request.getParameter("phone3");
//	    String fullPhone = phone1 + "-" + phone2 + "-" + phone3;
//	    dto.setPhoneNumber(fullPhone);
//	    log.info("(Review) modify...휴대폰" + fullPhone);
//
//	    // 3. 주소 조합 + null 체크
//	    String postcode = request.getParameter("zipcode");
//	    String roadAddress = request.getParameter("addr1");
//	    String detailAddress = request.getParameter("addr2");
//
//	    if (postcode == null || roadAddress == null || detailAddress == null ||
//	        postcode.trim().isEmpty() || roadAddress.trim().isEmpty() || detailAddress.trim().isEmpty()) {
//	        model.addAttribute("addressError", "주소를 모두 입력해 주세요.");
//	        return "redirect:/adminreview/modify?id=" + id;
//	    }	    
//
//	    dto.setZipcode(postcode);
//	    dto.setAddr1(roadAddress);
//	    dto.setAddr2(detailAddress);
//
//	    // 필요하다면 기존 address 필드도 함께 구성
//	    dto.setAddress("(" + postcode + ") " + roadAddress + " " + detailAddress);  // 선택
//	    log.info("(Review) modify...주소" + vo.getAddress());
//	    // 4. 생년월일 조합
//	    String birthYear = request.getParameter("birthYear");
//	    String birthMonth = request.getParameter("birthMonth");
//	    String birthDay = request.getParameter("birthDay");
//	    log.info("(Review) modify...생일0" + dto);
//	    try {
//	        String birthString = birthYear + "-" + birthMonth + "-" + birthDay;
//	        log.info("(Review) modify...생일1" + birthString);
//	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//	        Date birthDate = sdf.parse(birthString);
//	        dto.setBirthdate(birthDate);
//	        log.info("(Review) modify...생일2" + dto);
//	    } catch (ParseException e) {
//	        model.addAttribute("birthError", "생년월일 형식이 올바르지 않습니다.");
//	        log.info("(Review) modify...생일-error");
//	        return "redirect:/adminreview/modify?id=" + id;
//	    }
//
//	    service.modify(dto);
//	    log.info("(Review) modify...ID" + id);
//	    
//        if ("ADMIN".equals(role)) {
//        	Integer count = mapper.countAdminRole(id);
//        	if (count == null) {
//        	    count = 0;  // 기본값 처리
//        	}
//        	if (count == 0) {
//        	    mapper.insertAdminRole(id);
//        	}
//        } else {        	
//        	Integer count = mapper.countAdminRole(id);
//        	log.info("(Review) modify...role" + role + count);
//        	if (count == null) {
//        	    count = 0;  // 기본값 처리
//        	}
//        	if (count > 0) {
//        		log.info("(Review) modify...deleteAdminRole" + role + count);
//        		mapper.deleteAdminRole(id);
//        	}
//        }	    
//        
	    return "redirect:/adminreview/list";	    
	}
	
	
//	@Transactional
//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/harddel")
//	public String harddel(@RequestParam("id") int reviewId,
//	                      @ModelAttribute("cri") Criteria cri,
//	                      RedirectAttributes rttr
//	                      ) {
//
//	    log.info("review harddelete..." + reviewId);
//
//		log.info("harddelete..." + reviewId);
//		if(service.harddel(reviewId)) {
//			rttr.addFlashAttribute("result","success");
//		}
//		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//	    return "redirect:/adminreview/list";
//	}	
	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/harddel")
	public Map<String, Object> harddel(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.harddel(reviewId);
	    log.info("success:" + success);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 삭제되었습니다." : "삭제 실패했습니다.");
	    return result;
	}

//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/softdel")
//	public String softdel(@RequestParam("id") int reviewId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
//			) {
//		log.info("review softdelete..." + reviewId);
//		if(service.softdel(reviewId)) {
//			rttr.addFlashAttribute("result","success");
//		}
//		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/adminreview/list";
//	}
	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/softdel")
	public Map<String, Object> softdel(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.softdel(reviewId);
	    log.info("success:" + success);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 숨김되었습니다." : "숨김 실패했습니다.");
	    return result;
	}

//	@PreAuthorize("hasAuthority('ADMIN')")
//	@PostMapping("/restore")
//	public String restore(@RequestParam("id") int reviewId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
//			) {
//		log.info("review restore..." + reviewId);
//		if(service.restore(reviewId)) {
//			rttr.addFlashAttribute("result","success");
//		}
//		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/adminreview/list";
//	}
	@PreAuthorize("hasAuthority('ADMIN')")
	@ResponseBody 
	@PostMapping("/restore")
	public Map<String, Object> restore(@RequestParam("id") int reviewId) {
	    Map<String, Object> result = new HashMap<>();
	    boolean success = service.restore(reviewId);
	    log.info("success:" + success);
	    result.put("success", success);
	    result.put("message", success ? "리뷰가 복구되었습니다." : "복구 실패했습니다.");
	    return result;
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
