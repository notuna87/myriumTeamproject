package com.myrium.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;
import com.myrium.domain.PageDTO;
import com.myrium.mapper.AdminOrderMapper;
import com.myrium.service.AdminOrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@AllArgsConstructor
@RequestMapping("/adminorder/*")
@RequiredArgsConstructor()
public class AdminOrderController {

	private final AdminOrderService service;
	
	private final AdminOrderMapper mapper;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
	    log.info("list__________");
	    log.info(cri);
	    
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    boolean isAdmin = authentication.getAuthorities().stream()
	        .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));
	    
	    List<OrderDTO> list = service.getOrderList(cri, isAdmin);
	    log.info(list);

	    // 주문번호별 그룹핑
	    Map<String, List<OrderDTO>> groupedOrders = list.stream()
	        .collect(Collectors.groupingBy(OrderDTO::getOrdersId));
	    
	    model.addAttribute("groupedOrders", groupedOrders);

	    // 원본 리스트도 JSON 문자열로 변환 후 JSP에 전달
	    ObjectMapper mapper = new ObjectMapper();
	    try {
	        String ordersJson = mapper.writeValueAsString(list);
	        model.addAttribute("ordersJson", ordersJson);
	    } catch (JsonProcessingException e) {
	        log.error("JSON 변환 실패", e);
	        model.addAttribute("ordersJson", "[]");
	    }

	    int total = service.getTotal(cri, isAdmin);
	    model.addAttribute("pageMaker", new PageDTO(cri, total));

	    log.info("---------------------------------------------------");
	    log.info(groupedOrders);
	    log.info(authentication);
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
	public String register(OrderDTO dto,
	                       @RequestParam("attachList") String attachListJson,
	                       RedirectAttributes rttr) {
		log.info("(admin-order) register......." + dto);

		log.info("(admin-order) register......." + attachListJson);

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
	    
	    return "redirect:/adminorder/list";
	    
   
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/register")
	public void register() {
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) throws JacksonException {
		//service.incrementReadCnt(id);  // 조회수 증가 로직 (추가)
		OrderDTO orderInfo = service.get(id);
		model.addAttribute("order", orderInfo);
		System.out.println("order: " + orderInfo); // 디버깅
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
			OrderDTO dto,
			@RequestParam("role") String role,
			@ModelAttribute("cri") Criteria cri,
			Model model,
			RedirectAttributes rttr) {
		
		log.info("(Order) modify..." + dto);

		log.info("(Order) modify role..." + role);
		
//		Long id = dto.getId();
		
	    // 1. 비밀번호 확인
//	    String passwordConfirm = request.getParameter("passwordConfirm");
//	    if (!dto.getPassword().equals(passwordConfirm)) {
//	    	log.info("(Order) modify...비밀번호" + dto);
//	        model.addAttribute("pwMatchError", "비밀번호가 일치하지 않습니다.");
//	        return "redirect:/adminorder/modify?id=" + id;
//	    }
//		
//	    // 2. 휴대폰 번호 조합
//	    String phone1 = request.getParameter("phone1");
//	    String phone2 = request.getParameter("phone2");
//	    String phone3 = request.getParameter("phone3");
//	    String fullPhone = phone1 + "-" + phone2 + "-" + phone3;
//	    dto.setPhoneNumber(fullPhone);
//	    log.info("(Order) modify...휴대폰" + fullPhone);
//
//	    // 3. 주소 조합 + null 체크
//	    String postcode = request.getParameter("zipcode");
//	    String roadAddress = request.getParameter("addr1");
//	    String detailAddress = request.getParameter("addr2");
//
//	    if (postcode == null || roadAddress == null || detailAddress == null ||
//	        postcode.trim().isEmpty() || roadAddress.trim().isEmpty() || detailAddress.trim().isEmpty()) {
//	        model.addAttribute("addressError", "주소를 모두 입력해 주세요.");
//	        return "redirect:/adminorder/modify?id=" + id;
//	    }	    
//
//	    dto.setZipcode(postcode);
//	    dto.setAddr1(roadAddress);
//	    dto.setAddr2(detailAddress);
//
//	    // 필요하다면 기존 address 필드도 함께 구성
//	    dto.setAddress("(" + postcode + ") " + roadAddress + " " + detailAddress);  // 선택
//	    log.info("(Order) modify...주소" + vo.getAddress());
//	    // 4. 생년월일 조합
//	    String birthYear = request.getParameter("birthYear");
//	    String birthMonth = request.getParameter("birthMonth");
//	    String birthDay = request.getParameter("birthDay");
//	    log.info("(Order) modify...생일0" + dto);
//	    try {
//	        String birthString = birthYear + "-" + birthMonth + "-" + birthDay;
//	        log.info("(Order) modify...생일1" + birthString);
//	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//	        Date birthDate = sdf.parse(birthString);
//	        dto.setBirthdate(birthDate);
//	        log.info("(Order) modify...생일2" + dto);
//	    } catch (ParseException e) {
//	        model.addAttribute("birthError", "생년월일 형식이 올바르지 않습니다.");
//	        log.info("(Order) modify...생일-error");
//	        return "redirect:/adminorder/modify?id=" + id;
//	    }
//
//	    service.modify(dto);
//	    log.info("(Order) modify...ID" + id);
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
//        	log.info("(Order) modify...role" + role + count);
//        	if (count == null) {
//        	    count = 0;  // 기본값 처리
//        	}
//        	if (count > 0) {
//        		log.info("(Order) modify...deleteAdminRole" + role + count);
//        		mapper.deleteAdminRole(id);
//        	}
//        }	    
//        
	    return "redirect:/adminorder/list";	    
	}
	
	
	@Transactional
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") int orderId,
	                      @ModelAttribute("cri") Criteria cri,
	                      RedirectAttributes rttr
	                      ) {

	    log.info("Order harddelete..." + orderId);

		log.info("harddelete..." + orderId);
		if(service.harddel(orderId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
	    return "redirect:/adminorder/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/softdel")
	public String softdel(@RequestParam("id") int orderId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("Order softdelete..." + orderId);
		if(service.softdel(orderId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminorder/list";
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/restore")
	public String restore(@RequestParam("id") int orderId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			) {
		log.info("Order restore..." + orderId);
		if(service.restore(orderId)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminorder/list";
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
