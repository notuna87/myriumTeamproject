package com.myrium.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.MemberVO;
import com.myrium.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class JoinController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/join")
	public String showJoinform() {
		return "join/join";
	}
	
	@PostMapping("/join")
	public String register(MemberVO member, HttpServletRequest request, Model model, RedirectAttributes rttr) {

	    // 1. 비밀번호 확인
	    String passwordConfirm = request.getParameter("passwordConfirm");
	    if (!member.getPassword().equals(passwordConfirm)) {
	        model.addAttribute("pwMatchError", "비밀번호가 일치하지 않습니다.");
	        return "join/join";

	    }

	    // 2. 휴대폰 번호 조합
	    String phone1 = request.getParameter("phone1");
	    String phone2 = request.getParameter("phone2");
	    String phone3 = request.getParameter("phone3");
	    String fullPhone = phone1 + "-" + phone2 + "-" + phone3;
	    member.setPhoneNumber(fullPhone);

	    // 3. 주소 조합 + null 체크
	    String postcode = request.getParameter("zipcode");
	    String roadAddress = request.getParameter("addr1");
	    String detailAddress = request.getParameter("addr2");

	    if (postcode == null || roadAddress == null || detailAddress == null ||
	        postcode.trim().isEmpty() || roadAddress.trim().isEmpty() || detailAddress.trim().isEmpty()) {
	        model.addAttribute("addressError", "주소를 모두 입력해 주세요.");
	        return "join/join";
	    }

	    member.setZipcode(postcode);
	    member.setAddr1(roadAddress);
	    member.setAddr2(detailAddress);

	    // 필요하다면 기존 address 필드도 함께 구성
	    member.setAddress("(" + postcode + ") " + roadAddress + " " + detailAddress);  // 선택

	    // 4. 생년월일 조합
	    String birthYear = request.getParameter("birthYear");
	    String birthMonth = request.getParameter("birthMonth");
	    String birthDay = request.getParameter("birthDay");

	    try {
	        String birthString = birthYear + "-" + birthMonth + "-" + birthDay;
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Date birthDate = sdf.parse(birthString);
	        member.setBirthdate(birthDate);
	    } catch (ParseException e) {
	        model.addAttribute("birthError", "생년월일 형식이 올바르지 않습니다.");
	        return "join/join";
	    }

	    // 5. 약관 동의 항목 (체크박스 name 속성에 따라 처리)
	    member.setAgreePrivacy(request.getParameter("agreeTerms") != null ? 1 : 0);
	    member.setAgreePrivacy(request.getParameter("agreePrivacy") != null ? 1 : 0);
	    member.setAgreeThirdParty(request.getParameter("agreeThirdParty") != null ? 1 : 0);
	    member.setAgreeDelegate(request.getParameter("agreeDelegate") != null ? 1 : 0);
	    member.setAgreePrivacy(request.getParameter("agreeSms") != null ? 1 : 0);

	    // 6. 시스템 기본값 설정
	    member.setIsDeleted(0);
	    member.setCreatedAt(new Date());
	    member.setCreatedBy(member.getCustomerId()); // 본인이 작성자

	 // 7. 회원 저장
	    memberService.register(member);

	 // 8. 완료 페이지로 이동하면서 회원정보 전달 (FlashAttribute 방식)
	    rttr.addFlashAttribute("customerName", member.getCustomerName());
	    rttr.addFlashAttribute("customerId", member.getCustomerId());
	    rttr.addFlashAttribute("email", member.getEmail());

	    return "redirect:/join/complete";

	}

}
