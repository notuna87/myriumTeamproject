package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/") 
public class FindidController {

    @GetMapping("/find_id")
    public String showFindIdForm() {
        return "login/find_id"; 
    }
}
