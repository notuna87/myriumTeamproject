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
	
	//테스트 회원 추가 및 권한 부여
	@Test
	public void testInsertMemberWithRole() {
	    String sql = "INSERT INTO member(customer_id, password, customer_name, address, phone_number, email, gender, birthdate, role, agree_terms, agree_privacy, is_deleted, created_at, created_by) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    for (int i = 0; i < 100; i++) {
	        Connection con = null;
	        PreparedStatement pstmt = null;

	        try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);

	            String customerId;
	            String customerName;
	            String role;

	            if (i < 80) {
	                customerId = "user" + i;
	                customerName = "일반사용자" + i;
	                role = "MEMBER";
	            } else if (i < 90) {
	                customerId = "manager" + i;
	                customerName = "운영자" + i;
	                role = "MANAGER";
	            } else {
	                customerId = "admin" + i;
	                customerName = "관리자" + i;
	                role = "ADMIN";
	            }

	            pstmt.setString(1, customerId);                                      // customer_id
	            pstmt.setString(2, passwordEncoder.encode("pw" + i));                // password
	            pstmt.setString(3, customerName);                                    // customer_name
	            pstmt.setString(4, "서울시 테스트구 테스트로 123");                      // address
	            pstmt.setString(5, "010-1234-56" + String.format("%02d", i));        // phone_number
	            pstmt.setString(6, customerId + "@test.com");                        // email
	            pstmt.setString(7, "M");                                             // gender
	            pstmt.setDate(8, java.sql.Date.valueOf("1990-01-01"));               // birthdate
	            pstmt.setString(9, role);                                            // role
	            pstmt.setInt(10, 1);                                                 // agree_terms
	            pstmt.setInt(11, 1);                                                 // agree_privacy
	            pstmt.setInt(12, 0);                                                 // is_deleted
	            pstmt.setTimestamp(13, new java.sql.Timestamp(System.currentTimeMillis())); // created_at
	            pstmt.setString(14, customerId);                                     // created_by

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
