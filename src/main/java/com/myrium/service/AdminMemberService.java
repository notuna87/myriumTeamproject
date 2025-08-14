package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface AdminMemberService {
	
	   public boolean modify(MemberVO vo);
	   
	   public boolean harddel(int id);
	
	   public boolean softdel(int id);
	     
	   public List<MemberVO> getMemberListWithAuth(Criteria cri);
	   
	   public int getTotal(Criteria cri);

	   public boolean restore(int id);
  
	   public MemberVO get(int id);
	   
}
