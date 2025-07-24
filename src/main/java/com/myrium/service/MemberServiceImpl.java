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

//	    @Override
//	    public void register(MemberVO member) {
//	        memberMapper.insertMember(member);
//	    }
	    
	    @Override
	    @Transactional
	    public void register(MemberVO memberVO) {
	        // 비밀번호 암호화
	        String encodedPassword = passwordEncoder.encode(memberVO.getPassword());
	        memberVO.setPassword(encodedPassword);

	        // 회원 정보 insert
	        memberMapper.insertMember(memberVO);

	        // 권한 정보 insert
	        if (memberVO.getAuthList() != null) {
	            for (AuthVO auth : memberVO.getAuthList()) {
	                auth.setCustomerId(memberVO.getCustomerId());
	                memberMapper.insertAuth(auth);
	            }
	        }
	    }

	    @Override
	    public MemberVO getMemberById(int id) {
	        return memberMapper.getMemberById(id);
	    }

	    @Override
	    public List<MemberVO> getAllMembers() {
	        return memberMapper.getAllMembers();
	    }

	    @Override
	    public boolean update(MemberVO member) {
	        return memberMapper.updateMember(member) == 1;
	    }

	    @Override
	    public boolean delete(int id) {
	        return memberMapper.deleteMember(id) == 1;
	    }
	    
}
