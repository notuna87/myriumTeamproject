package com.myrium.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.myrium.domain.MemberVO;
import com.myrium.domain.PageDTO;
import com.myrium.mapper.AdminMemberMapper;
import com.myrium.service.AdminMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/adminmember/*")
public class AdminMemberController {

	private final AdminMemberService service;	
	private final AdminMemberMapper mapper;

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
	    List<MemberVO> list = service.getMemberListWithAuth(cri);
		model.addAttribute("list", list);

		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/modify")
	public void get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) throws JacksonException {

		MemberVO memberInfo = service.get(id);
		model.addAttribute("member", memberInfo);
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			MemberVO vo,
			@RequestParam("role") String role,
			@ModelAttribute("cri") Criteria cri,
			Model model,
			RedirectAttributes rttr) {
		
		Long id = vo.getId();
		
	    // 1. 비밀번호 확인
	    //String passwordConfirm = request.getParameter("passwordConfirm");
	    //if (!vo.getPassword().equals(passwordConfirm)) {
	    //	log.info("(member) modify...비밀번호" + vo);
	    //    model.addAttribute("pwMatchError", "비밀번호가 일치하지 않습니다.");
	    //    return "redirect:/adminmember/modify?id=" + id;
	    //}
		
	    // 2. 휴대폰 번호 조합
	    String phone1 = request.getParameter("phone1");
	    String phone2 = request.getParameter("phone2");
	    String phone3 = request.getParameter("phone3");
	    String fullPhone = phone1 + "-" + phone2 + "-" + phone3;
	    vo.setPhoneNumber(fullPhone);

	    // 3. 주소 조합 + null 체크
	    String postcode = request.getParameter("zipcode");
	    String roadAddress = request.getParameter("addr1");
	    String detailAddress = request.getParameter("addr2");

	    if (postcode == null || roadAddress == null || detailAddress == null ||
	        postcode.trim().isEmpty() || roadAddress.trim().isEmpty() || detailAddress.trim().isEmpty()) {
	        model.addAttribute("addressError", "주소를 모두 입력해 주세요.");
	        return "redirect:/adminmember/modify?id=" + id;
	    }	    

	    vo.setZipcode(postcode);
	    vo.setAddr1(roadAddress);
	    vo.setAddr2(detailAddress);	    
	    vo.setAddress("(" + postcode + ") " + roadAddress + " " + detailAddress);
	    
	    // 4. 생년월일 조합
	    String birthYear = request.getParameter("birthYear");
	    String birthMonth = request.getParameter("birthMonth");
	    String birthDay = request.getParameter("birthDay");

	    try {
	        String birthString = birthYear + "-" + birthMonth + "-" + birthDay;

	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Date birthDate = sdf.parse(birthString);
	        vo.setBirthdate(birthDate);

	    } catch (ParseException e) {
	        model.addAttribute("birthError", "생년월일 형식이 올바르지 않습니다.");

	        return "redirect:/adminmember/modify?id=" + id;
	    }

	    service.modify(vo);
	    
        if ("ADMIN".equals(role)) {
        	Integer count = mapper.countAdminRole(id);
        	if (count == null) {
        	    count = 0;  // 기본값 처리
        	}
        	if (count == 0) {
        	    mapper.insertAdminRole(id);
        	}
        } else {        	
        	Integer count = mapper.countAdminRole(id);

        	if (count == null) {
        	    count = 0;  // 기본값 처리
        	}
        	if (count > 0) {
        		mapper.deleteAdminRole(id);
        	}
        }	    
        
	    return "redirect:/adminmember/list";	    
	}
	
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/harddel")
	public String harddel(@RequestParam("id") int memberId,
	                      @ModelAttribute("cri") Criteria cri,
	                      RedirectAttributes rttr
	                      ) {

		if(service.harddel(memberId)) {
			rttr.addFlashAttribute("result","success");
		}		
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

		if(service.restore(memberId)) {
			rttr.addFlashAttribute("result","success");
		}		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/adminmember/list";
	}
	
}
