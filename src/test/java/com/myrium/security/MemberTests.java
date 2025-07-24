package com.myrium.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	
	@Autowired // PasswordEncoder 주입
	private PasswordEncoder passwordEncoder;
	
	@Autowired // DataSource 주입
	private DataSource ds;
	
	@Test
	public void testInsertMember() {
	    String sql = "INSERT INTO member (id, customer_id, password, customer_name, address, phone_number, email, gender, birthdate, role, agree_terms, agree_privacy, is_deleted, created_at, created_by) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    for (int i = 0; i < 100; i++) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);

	            String customerId;
	            String customerName;
	            String role;

	            if (i < 5) {
	                customerId = "user" + i;
	                customerName = "일반사용자" + i;
	                role = "MEMBER";
	            } else if (i < 8) {
	                customerId = "manager" + i;
	                customerName = "운영자" + i;
	                role = "MANAGER";
	            } else {
	                customerId = "admin" + i;
	                customerName = "관리자" + i;
	                role = "ADMIN";
	            }

	            pstmt.setInt(1, i + 1); // id
	            pstmt.setString(2, customerId);
	            pstmt.setString(3, passwordEncoder.encode("pw" + i));
	            pstmt.setString(4, customerName);
	            pstmt.setString(5, "서울시 가상구 테스트로 123");
	            pstmt.setString(6, "010-1234-56" + String.format("%02d", i));
	            pstmt.setString(7, customerId + "@test.com");
	            pstmt.setString(8, "M");
	            pstmt.setDate(9, java.sql.Date.valueOf("1990-01-01"));
	            pstmt.setString(10, role);
	            pstmt.setInt(11, 1); // agree_terms
	            pstmt.setInt(12, 1); // agree_privacy
	            pstmt.setInt(13, 0); // is_deleted
	            pstmt.setTimestamp(14, new java.sql.Timestamp(System.currentTimeMillis()));
	            pstmt.setString(15, customerId);

	            pstmt.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	            if (con != null) try { con.close(); } catch (Exception e) {}
	        }
	    }
	}

}
