package com.myrium.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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
	    // 1) 요청/컨텍스트 경로
	    final String requestUri  = request.getRequestURI();        // 예: /myrium/upload/2025/08/11/a.jpg
	    final String contextPath = request.getContextPath();       // 예: /myrium (루트면 "")

	    // 2) /upload/ 이후의 상대 경로만 추출
	    final String prefix = contextPath + "/upload/";
	    final int idx = requestUri.indexOf(prefix);
	    if (idx < 0) {
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid upload path");
	        return;
	    }
	    String relative = requestUri.substring(idx + prefix.length());  // 예: 2025/08/11/a.jpg

	    if (relative.isEmpty()) { // /upload 만 들어온 경우
	        response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return;
	    }

	    // 3) 물리 루트와 안전 결합 + 경로 이탈 방지
	    Path base = Paths.get("C:/upload").toAbsolutePath().normalize();
	    Path file = base.resolve(relative).normalize();

	    if (!file.startsWith(base)) { // ../ 등 이탈 차단
	        response.sendError(HttpServletResponse.SC_FORBIDDEN);
	        return;
	    }

	    // 4) 존재/파일 여부 검증
	    if (!Files.exists(file) || !Files.isRegularFile(file)) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return;
	    }

	    // 5) Content-Type 설정
	    String contentType = Files.probeContentType(file);
	    if (contentType == null) contentType = "application/octet-stream";
	    response.setContentType(contentType);
	    response.setContentLengthLong(Files.size(file));

	    // 6) 스트리밍
	    try (InputStream in = Files.newInputStream(file);
	         OutputStream out = response.getOutputStream()) {
	        byte[] buffer = new byte[8192];
	        int len;
	        while ((len = in.read(buffer)) != -1) {
	            out.write(buffer, 0, len);
	        }
	    }
	}
}


