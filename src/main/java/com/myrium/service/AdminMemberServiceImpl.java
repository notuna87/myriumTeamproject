package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.MemberVO;
import com.myrium.mapper.AdminMemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Autowired
	private final AdminMemberMapper mapper;

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	// 회줜정보 & 권한 리스트
	@Transactional
	@Override
	public List<MemberVO> getMemberListWithAuth(Criteria cri) {
		List<MemberVO> memberList = mapper.getMemberList(cri);
		List<MemberVO> memberVoList = new ArrayList<>();		
		for (MemberVO member : memberList) {
			List<AuthVO> auth = mapper.getAuthList(member.getId());
			member.setAuthList(auth);
			memberVoList.add(member);
		}
		return memberVoList;
	}
	
	@Override
	public MemberVO get(int id) {
	      MemberVO member = mapper.get(id);
	      List<AuthVO> auth = mapper.getAuthList(member.getId());
	      member.setAuthList(auth);
	      return member;
	}
	
	@Override
	public boolean modify(MemberVO vo) {
	     return mapper.update(vo) == 1;
	}

	@Override
	public boolean harddel(int id) {
	     return mapper.harddel(id) == 1;
	}

	@Override
	public boolean softdel(int id) {
		return mapper.softdel(id) == 1;
	}
	
	@Override
	public boolean restore(int id) {
		return mapper.restore(id) == 1;
	}	
	


	
}
