package com.myrium.service;

import java.util.List;

import com.myrium.domain.MemberVO;

public interface MemberService {
	
    void register(MemberVO member);               // 회원 등록

    MemberVO getMemberById(int id);              // ID로 회원 조회

    List<MemberVO> getAllMembers();              // 모든 회원 조회

    boolean update(MemberVO member);             // 회원 정보 수정

    boolean delete(int id);                      // 회원 삭제

//	MemberVO getMemberByCustomerId(String customerId);
    
    boolean isCustomerIdDuplicate(String customerId); // 아이디 중복체크
    
    String findPasswordByEmail(String customerId, String customerName, String email);

    String findPasswordByPhone(String customerId, String customerName, String phoneNumber);
    
}
