package com.myrium.mapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

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
public class MemberMapperTests {
	
	@Autowired // PasswordEncoder 주입
	private PasswordEncoder passwordEncoder;
	
	@Autowired // DataSource 주입
	private DataSource ds;
	
	@Test
	public void testInsertMember() {
	    String sql = "INSERT INTO member(" +
	            "id, customer_id, password, customer_name, address, phone_number, email, gender, birthdate, role, " +
	            "agree_terms, agree_privacy, agree_third_party, agree_delegate, agree_sms, is_deleted, " +
	            "created_at, created_by" +
	            ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    for (int i = 0; i < 100; i++) {
	        Connection con = null;
	        PreparedStatement pstmt = null;

	        try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);

	            int idx = 1;

	            pstmt.setInt(idx++, i + 1);                                // id
	            pstmt.setString(idx++, getCustomerId(i));                 // customer_id
	            pstmt.setString(idx++, passwordEncoder.encode("pw" + i)); // password
	            pstmt.setString(idx++, getCustomerName(i));               // customer_name
	            pstmt.setString(idx++, "서울시 테스트로 " + i);              // address
	            pstmt.setString(idx++, "010-0000-00" + String.format("%02d", i)); // phone_number
	            pstmt.setString(idx++, getCustomerId(i) + "@test.com");   // email
	            pstmt.setString(idx++, (i % 2 == 0) ? "M" : "F");          // gender
	            pstmt.setDate(idx++, java.sql.Date.valueOf("1990-01-01")); // birthdate
	            pstmt.setString(idx++, "MEMBER");                         // role
	            pstmt.setInt(idx++, 1);                                    // agree_terms
	            pstmt.setInt(idx++, 1);                                    // agree_privacy
	            pstmt.setInt(idx++, 1);                                    // agree_third_party
	            pstmt.setInt(idx++, 1);                                    // agree_delegate
	            pstmt.setInt(idx++, 1);                                    // agree_sms
	            pstmt.setInt(idx++, 0);                                    // is_deleted
	            pstmt.setTimestamp(idx++, new Timestamp(System.currentTimeMillis())); // created_at
	            pstmt.setString(idx++, "test");                            // created_by

	            pstmt.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	            if (con != null) try { con.close(); } catch (Exception e) {}
	        }
	    }
	}

	private String getCustomerId(int i) {
	    if (i < 80) return "user" + i;
	    else if (i < 90) return "manager" + i;
	    else return "admin" + i;
	}

	private String getCustomerName(int i) {
	    if (i < 80) return "일반사용자" + i;
	    else if (i < 90) return "운영자" + i;
	    else return "관리자" + i;
	}
}


