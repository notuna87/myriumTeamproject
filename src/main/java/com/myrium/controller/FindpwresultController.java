package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/") // ← 이거 있음에 주의!
public class FindpwresultController {

    @GetMapping("/find_pw_result")
    public String showResultPage(@RequestParam String method, @RequestParam String target, Model model) {
        model.addAttribute("method", method);
        model.addAttribute("targetValue", target);
        return "login/find_pw_result"; // 실제 JSP 경로: /WEB-INF/views/login/find_pw_result.jsp
    }
}
