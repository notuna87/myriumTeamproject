package com.myrium.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myrium.domain.AuthVO;
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
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(memberVO.getPassword());
        memberVO.setPassword(encodedPassword);


        // 회원 정보 insert
        memberMapper.insertMember(memberVO);

        // 권한 정보 insert
        AuthVO authVO = new AuthVO();
        authVO.setUserId(memberVO.getId());  // 시퀀스로 생성된 ID
        authVO.setRole("MEMBER");            // 기본 권한
        memberMapper.insertAuth(authVO);
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
}
