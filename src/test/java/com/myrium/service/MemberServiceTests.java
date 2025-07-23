package com.myrium.service;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.Date;

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
public class MemberServiceTests {

	@Autowired
    private MemberService memberService;

    @Test
    public void testRegister() {
        MemberVO member = new MemberVO();
        member.setId(7); // 실제 존재하지 않는 PK값
        member.setCustomerId("user7");
        member.setPassword("test12345!");
        member.setCustomerName("김나라");
        member.setAddress("서울시 중구");
        member.setPhoneNumber("010-1111-2222");
        member.setEmail("user100@example.com");
        member.setGender("M");
        member.setBirthdate(new Date());
        member.setRole("MEMBER");
        member.setAgreeTerms(1);
        member.setAgreePrivacy(1);
        member.setAgreeThirdParty(1);
        member.setAgreeDelegate(1);
        member.setAgreeSms(1);
        member.setIsDeleted(0);
        member.setCreatedBy("admin");

        memberService.register(member);
        log.info("✅ INSERT 완료");
    }

    @Test
    public void testGetMember() {
        MemberVO member = memberService.getMemberById(1);
        log.info("조회 결과: " + member);
    }

    @Test
    public void testUpdate() {
        MemberVO member = memberService.getMemberById(1);
        if (member == null) return;

        member.setEmail("newemail@example.com");
        member.setUpdatedBy("admin");
        boolean result = memberService.update(member);
        log.info("업데이트 결과: " + result);
    }

    @Test
    public void testDelete() {
        boolean result = memberService.delete(1);
        log.info("삭제 결과: " + result);
    }
}
