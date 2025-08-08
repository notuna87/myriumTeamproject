package com.myrium.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	 // 접근 거부 페이지 핸들러
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}

    @GetMapping("/customLogin")
    public String loginInput(@RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "logout", required = false) String logout,
                             Model model) {
        if (error != null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        if (logout != null) {
            model.addAttribute("logout", "정상적으로 로그아웃되었습니다.");
        }
        return "login/login"; 
    }
    
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
//	@RequestMapping("/upload/**")
//	@ResponseBody
//	public void checkUpload(HttpServletRequest req) {
//	    System.out.println("접근된 URL: " + req.getRequestURI());
//	    File file = new File("C:/upload/test.jpg");
//	    System.out.println(file.exists()); // true이면 OK
//	    System.out.println(file.length()); // 0이면 문제 있음
//	}
	
	
	// 콘트롤러가 이미지를 브라우져에 전송
	@GetMapping("/upload/**")
	public void serveImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("접근된 URL: " + request.getRequestURI());
	    String uri = request.getRequestURI(); // /resorces/product/img/...jpg
	    String filePath = "C:" + uri.replace("/", File.separator);

	    File file = new File(filePath);
	    if (!file.exists()) {
	        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	        return;
	    }

	    response.setContentType(Files.probeContentType(file.toPath()));
	    response.setContentLengthLong(file.length());

	    try (InputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
	        byte[] buffer = new byte[8192];
	        int len;
	        while ((len = in.read(buffer)) != -1) {
	            out.write(buffer, 0, len);
	        }
	    }
	}
}


