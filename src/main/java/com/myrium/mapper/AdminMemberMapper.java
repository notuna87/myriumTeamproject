package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;

public interface AdminMemberMapper {
	
	public List<MemberVO> getList();	
	public void insert(MemberVO member);
	public void insertSelectKey(MemberVO member);
	public MemberVO read(int id);
	public int harddel(int id); //하드(영구) 삭제
	public int softdel(int id); //소프트 삭제
	public int restore(int id); //복구
	public int update(MemberVO member);	
	public List<MemberVO> getListWithPaging(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);	
	public List<MemberVO> searchTest(Map<String, Map<String, String>> map);	
	public void updateReadCnt(@Param("id") int id, @Param("amount") int amount);	
    // 파일 정보 저장
	public void insertAttach(AttachFileDTO dto);
    // 해당 공지의 파일 목록 조회
	public List<ImgpathVO> findByMemberId(int id);	
	// 파일 정보 삭제
	public int deleteImgpathByUuid(@Param("uuid") String uuid);	
	public void updateReadCnt(int id);	
	public List<MemberVO> getMemberList(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	public CategoryVO getCategoryList(int id);
	public ImgpathVO getImgPathList(int id);
	public void insertCategory(CategoryVO cat);
	public void updateCategory(CategoryVO cat);
	public void insertImgpath(ImgpathVO imgVO);
	//public void updateThumbnailMain(@Param("Member_id") int Member_id, @Param("uuid") String uuid);
	public void updateThumbnailMain(@Param("id") int id, @Param("is_thumbnail_main") int is_thumbnail_main);
	public List<ImgpathVO> findImgpathByUuid(String uuid);
	public void updateImgpath(int id);



}