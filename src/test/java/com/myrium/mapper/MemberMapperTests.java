package com.myrium.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myrium.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {
	
	@Autowired
    private MemberMapper memberMapper;

	@Test
	public void testInsertMember() {
	    MemberVO member = new MemberVO();
	    member.setId(101); // 시퀀스를 안 쓴다면 직접 지정
	    member.setCustomerId("user100");
	    member.setPassword("test12345!");
	    member.setCustomerName("테스터");
	    member.setAddress("서울시 종로구 테스트길 100");
	    member.setPhoneNumber("010-9999-0000");
	    member.setEmail("test100@example.com");
	    member.setGender("M");
	    member.setBirthdate(java.sql.Date.valueOf("1990-01-01"));
	    member.setRole("MEMBER");
	    member.setAgreeTerms(1);
	    member.setAgreePrivacy(1);
	    member.setAgreeThirdParty(1);
	    member.setAgreeDelegate(1);
	    member.setAgreeSms(1);
	    member.setIsDeleted(0);
	    member.setCreatedBy("test");

	    try {
	        memberMapper.insertMember(member);
	        System.out.println("✅ insert 완료!");
	    } catch (Exception e) {
	        System.out.println("❌ insert 실패: " + e.getMessage());
	        e.printStackTrace();
	    }
	}



}
