package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class FindidresultController {

    @GetMapping("/login/find_id_result")
    public String showFindIdResult(Model model) {
    	log.info("test");
        model.addAttribute("name", "고나영");
        model.addAttribute("email", "sks0716ek@naver.com");
        model.addAttribute("userId", "sks0716ek");
        model.addAttribute("joinDate", "2025-07-17");

        return "login/find_id_result";
    }
}
