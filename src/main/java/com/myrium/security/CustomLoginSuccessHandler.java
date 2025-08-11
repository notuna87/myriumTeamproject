package com.myrium.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.myrium.domain.MemberVO;
import com.myrium.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
	        throws IOException, ServletException {
		
	    //CustomUser에서 로그인한 사용자 정보 꺼내기
	    CustomUser customUser = (CustomUser) authentication.getPrincipal();
	    MemberVO member = customUser.getMember();

	    //세션에 로그인 사용자 저장
	    request.getSession().setAttribute("loginUser", member);

	    //권한 확인
	    List<String> roleNames = new ArrayList<>();

	    authentication.getAuthorities().forEach(authority -> {
	        roleNames.add(authority.getAuthority());
	    });

	    log.warn("ROLE NAMES : " + roleNames);
	 //세션에 사용자 정보 저장
	    request.getSession().setAttribute("loginUser", member);

	    //로그 출력
	    log.warn("세션 loginUser 확인: " + request.getSession().getAttribute("loginUser"));
	    log.warn("세션 ID: " + request.getSession().getId());
	    
	    
	    if (roleNames.contains("ADMIN")) {
	        response.sendRedirect("/admin");
	        return;
	    }

	    if (roleNames.contains("MEMBER")) {
	        response.sendRedirect("/");
	        return;
	    }

	    // 기타 권한이 없을 경우 기본 처리
	    response.sendRedirect("/");
	}

}
