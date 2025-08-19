package com.myrium.service;

import java.util.Date;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myrium.domain.AuthVO;
import com.myrium.domain.MemberDTO;
import com.myrium.domain.MemberVO;
import com.myrium.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder passwordEncoder;

    // 회원 등록
    @Override
    @Transactional
    public void register(MemberVO memberVO) {

        try {
            // 비밀번호 암호화
            String encodedPassword = passwordEncoder.encode(memberVO.getPassword());
            memberVO.setPassword(encodedPassword);

            // 회원 정보 insert
            memberMapper.insertMember(memberVO);
 
            // 권한 정보 insert
            AuthVO authVO = new AuthVO();
            authVO.setUserId(memberVO.getId());
            authVO.setRole("MEMBER");

            memberMapper.insertAuth(authVO);

        } catch (Exception e) {
            throw e; 
        }
    }


    // 회원 단건 조회
    @Override
    public MemberVO getMemberById(int id) {
        return memberMapper.getMemberById(id);
    }

    // 전체 회원 조회
    @Override
    public List<MemberVO> getAllMembers() {
        return memberMapper.getAllMembers();
    }

    // 회원 정보 수정
    @Override
    public boolean update(MemberVO member) {
        return memberMapper.updateMember(member) == 1;
    }

    // 회원 삭제 처리
    @Override
    public boolean delete(int id) {
        return memberMapper.deleteMember(id) == 1;
    }
    
    @Override
    public boolean isCustomerIdDuplicate(String customerId) {
        MemberVO vo = memberMapper.selectByCustomerId(customerId);
        System.out.println("중복 확인 결과: " + (vo != null ? "중복됨" : "사용 가능"));
        return vo != null;
    }
    
	@Override
	public boolean isCustomerEmailDuplicate(String email) {
        MemberVO vo = memberMapper.selectByEmail(email);
        System.out.println("중복 확인 결과: " + (vo != null ? "중복됨" : "사용 가능"));
        return vo != null;
	}
    
    //패스워드 찾기, 임시 패스워드 생성 
    @Override
    @Transactional
    public String findPasswordByEmail(String customerId, String customerName, String email) {
        MemberVO member = memberMapper.findByNameAndEmail(customerName, email);
        if (member != null && member.getCustomerId().equals(customerId)) {
            String tempPassword = generateTempPassword(); // 임시 비번 생성
            String encodedPassword = passwordEncoder.encode(tempPassword); // 암호화
            member.setPassword(encodedPassword);
            member.setUpdatedAt(new Date());               // 현재 시간으로 설정
            member.setUpdatedBy("find_password");           // 또는 customerId 등
            
            memberMapper.updateMember(member);             // DB update 호출
            return tempPassword;
        }
        return null;
    }
    @Override
    @Transactional
    public String findPasswordByPhone(String customerId, String customerName, String phoneNumber) {
        MemberVO member = memberMapper.findByNameAndPhone(customerName, phoneNumber);

        if (member != null && member.getCustomerId().equals(customerId)) {
            String tempPassword = generateTempPassword();

            String encodedPassword = passwordEncoder.encode(tempPassword);

            // 비밀번호 및 수정 정보 업데이트
            member.setPassword(encodedPassword);
            member.setUpdatedAt(new Date());
            member.setUpdatedBy("find_password");

            memberMapper.updateMember(member);

            return tempPassword;
        }

        return null;
    }

    // 임시 비밀번호 생성기
    private String generateTempPassword() {
        int length = 10;
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int rand = (int)(Math.random() * chars.length());
            sb.append(chars.charAt(rand));
        }
        return sb.toString();
    }
    
    //비밀번호 변경
    @Override
    public void updatePassword(String customerId, String encodedPassword) {
        memberMapper.updatePassword(customerId, encodedPassword);
    }
    @Override
    public MemberVO getMemberByCustomerId(String customerId) {
        return memberMapper.readByCustomerId(customerId);
    }
    
    //회원정보수정
    @Override
    public void updateMemberInfo(MemberVO member) {
        memberMapper.updateMemberInfo(member);  // 여기 중요
    }
    
    @Override
    public MemberVO readById(long id) {
        return memberMapper.readById(id);
    }




}
