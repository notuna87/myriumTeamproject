package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/") 
public class ChangepasswordController {

    @GetMapping("/change_password")
    public String showFindIdForm() {
        return "mypage/change_password"; 
    }
    
}
