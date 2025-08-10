package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.AuthVO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;
import com.myrium.domain.ProductDTO;
import com.myrium.mapper.AdminMemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Autowired
	private AdminMemberMapper mapper;




	@Override
	public List<MemberVO> getList() {
		log.info("Member getList.....");
		return mapper.getList();
	}


	@Override
	public void register(MemberVO member) {
		log.info("Member register....." + member);
		mapper.insertSelectKey(member);
	}
	
//	@Override
//	public List<MemberVO> getList(Criteria cri, boolean isAdmin){
//		log.info("Member getList...(Criteria cri)");
//		return mapper.getList(cri, isAdmin);
//		//return mapper.getListWithPaging(cri, isAdmin);
//	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		log.info(mapper.getTotalCount(cri, isAdmin));
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(int id) {
		log.info("Member restore...." + id);
		return mapper.restore(id)==1;
	}
	
	
	// 회줜정보 & 권한 리스트
	@Override
	public List<MemberVO> getMemberListWithAuth(Criteria cri, boolean isAdmin) {
		List<MemberVO> memberList = mapper.getMemberList(cri, isAdmin);
		List<MemberVO> memberVoList = new ArrayList<>();		
		for (MemberVO member : memberList) {
			List<AuthVO> auth = mapper.getAuthList(member.getId());
			log.info("getAuthList:" + auth);
			member.setAuthList(auth);
			memberVoList.add(member);
		}
		return memberVoList;
	}
	
	@Override
	public MemberVO get(int id) {
	      log.info("Member get....." + id);
	      MemberVO member = mapper.read(id);
	      List<AuthVO> auth = mapper.getAuthList(member.getId());
	      member.setAuthList(auth);
	      return member;
	}
	
	@Override
	public boolean modify(MemberVO vo) {
	     log.info("Member modify.... " + vo);
	     return mapper.update(vo)==1;
	}

	@Override
	public boolean harddel(int id) {
	     log.info("Member harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		log.info("Member softdel...." + id);
		return mapper.softdel(id)==1;
	}


	
}
