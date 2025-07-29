package com.myrium.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myrium.domain.MemberVO;
import com.myrium.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member")
public class MemberController {
	

	
	@Autowired
    private MemberService memberService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    // 전체 회원 목록
    @GetMapping("/list")
    public String list(Model model) {
        List<MemberVO> members = memberService.getAllMembers();
        model.addAttribute("members", members);
        
        return "join/member_list"; // => /WEB-INF/views/member/member_list.jsp
    }
    
    //비밀번호 변경
    @PostMapping("/changePassword")
    public String changePassword(HttpSession session, HttpServletRequest request, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            model.addAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        String customerId = loginUser.getCustomerId();
        String currentPassword = request.getParameter("current-password");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        MemberVO dbMember = memberService.getMemberByCustomerId(customerId);
        if (dbMember == null) {
            model.addAttribute("msg", "회원 정보가 존재하지 않습니다.");
            return "mypage/change_password";  //잘못된 경우에도 동일 화면
        }

        if (!passwordEncoder.matches(currentPassword, dbMember.getPassword())) {
            model.addAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
            return "mypage/change_password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("msg", "새 비밀번호가 일치하지 않습니다.");
            return "mypage/change_password";
        }

        String encodedPassword = passwordEncoder.encode(newPassword);
        memberService.updatePassword(customerId, encodedPassword);

        model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
        return "mypage/change_password";  //성공해도 다시 같은 페이지로
    }

    @GetMapping("/change_password")
    public String showChangePassword(HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        log.warn(">>>> [change_password GET] 세션 loginUser: " + loginUser);
        return "mypage/change_password";
    }
}
    

