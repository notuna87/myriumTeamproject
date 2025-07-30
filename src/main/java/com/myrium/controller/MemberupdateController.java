package com.myrium.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myrium.domain.MemberVO;
import com.myrium.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberupdateController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
	
	@GetMapping("/member_update")
	public String showmemberupdateform() {
		return "mypage/member_update";
	}
	

	// 회원정보수정
	@PostMapping("/mypage/member_update")
	public String updateMemberinfo(HttpServletRequest request, MemberVO member, HttpSession session, RedirectAttributes rttr) {
	    log.info("수정할 회원정보: " + member);

	    try {
	        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	        member.setId(loginUser.getId());

	        // 전화번호 조합
	        String phone1 = request.getParameter("phone1");
	        String phone2 = request.getParameter("phone2");
	        String phone3 = request.getParameter("phone3");

	        if (phone1 != null && phone2 != null && phone3 != null) {
	            member.setPhoneNumber(phone1 + "-" + phone2 + "-" + phone3);
	        }

	        // 회원 정보 수정
	        memberService.updateMemberInfo(member);

	        // 로그아웃 처리
	        SecurityContextHolder.clearContext(); // Spring Security 인증 제거
	        session.invalidate(); // 세션 만료

	        rttr.addFlashAttribute("msg", "회원 정보가 수정되었습니다. 다시 로그인해 주세요.");
	        return "redirect:/login";

	    } catch (Exception e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("error", "회원 정보 수정에 실패했습니다.");
	        return "redirect:/mypage/member_update";
	    }
	}

	
	// 비밀번호 확인용 (Ajax)
	@PostMapping("/mypage/check-password")
	@ResponseBody
	public String checkPassword(@RequestParam("password") String password, HttpSession session) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (passwordEncoder.matches(password, loginUser.getPassword())) {
	        return "matched";
	    } else {
	        return "not_matched";
	    }
	}
}
