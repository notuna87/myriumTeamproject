package com.myrium.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myrium.domain.MemberVO;
import com.myrium.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
    private MemberService memberService;

    // 전체 회원 목록
    @GetMapping("/list")
    public String list(Model model) {
        List<MemberVO> members = memberService.getAllMembers();
        model.addAttribute("members", members);
        
        return "join/member_list"; // => /WEB-INF/views/member/member_list.jsp
    }

}
