package com.myrium.security;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoderTests {

	// PasswordEncoder 인스턴스를 생성 (BCrypt 방식 사용)
		private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

		@Test
		public void test() {

			String str = "1111";

			// 비밀번호 암호화
			String encodedPassword = passwordEncoder.encode(str);
			log.info("Encoded password: " + encodedPassword);

			// 비밀번호 일치 여부 확인
			boolean match = passwordEncoder.matches("1111", encodedPassword);
			log.info("Password matches: " + match);

		}
}
