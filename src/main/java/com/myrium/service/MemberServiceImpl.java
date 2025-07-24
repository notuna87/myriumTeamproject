package com.myrium.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myrium.domain.MemberVO;
import com.myrium.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {
	 private final MemberMapper memberMapper;

	    @Override
	    public void register(MemberVO member) {
	        memberMapper.insertMember(member);
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
