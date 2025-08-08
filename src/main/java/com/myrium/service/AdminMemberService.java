package com.myrium.service;

import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;

public interface AdminMemberService {
	
	   public void register(MemberVO vo);	   
	   
	   public boolean modify(MemberVO vo);
	   
	   public boolean harddel(int id);
	
	   public boolean softdel(int id);
	   
	   public List<MemberVO> getList();
	   
	   public List<MemberVO> getList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(int id);

	   public void insertAttach(AttachFileDTO dto);
	   
	   public List<ImgpathVO> findByMemberId(int id);

	   public int deleteImgpathByUuid(String uuid);

	   public void incrementReadCnt(int id);

	   public MemberVO get(int id);

	   public void insertCategory(CategoryVO cat);
	
	   public void updateCategory(CategoryVO cat);
	   
	   public void insertImgpath(ImgpathVO imgVO);

	   public List<ImgpathVO> findImgpathByUuid(String uuid);

	   public void updateImgpath(int id);


}
