package com.myrium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")  // °øÅë URI prefix
public class FindpwController {

    @GetMapping("/find_pw")
    public String showFindIdForm() {
        return "login/find_pw"; 
}
}