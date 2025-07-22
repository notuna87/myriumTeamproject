package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/") 
public class FindpwresultController {

    @GetMapping("/find_pw_result")
    public String showResultPage(@RequestParam String method, @RequestParam String target, Model model) {
        model.addAttribute("method", method);
        model.addAttribute("targetValue", target);
        return "login/find_pw_result"; 
    }
}
