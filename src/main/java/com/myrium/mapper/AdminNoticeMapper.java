package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.NoticeVO;

public interface AdminNoticeMapper {
	
	public List<NoticeVO> getList();	
	public void insert(NoticeVO notice);
	public void insertSelectKey(NoticeVO notice);
	public NoticeVO read(Long id);
	public int harddel(Long id); //하드(영구) 삭제
	public int softdel(Long id); //소프트 삭제
	public int restore(Long id); //복구
	public int update(NoticeVO notice);
	
	public List<NoticeVO> getListWithPaging(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	
	public List<NoticeVO> searchTest(Map<String, Map<String, String>> map);
	
	public void updateReadCnt(@Param("id") Long id, @Param("amount") int amount);
	
    // 파일 정보 저장
	public void insertAttach(AttachFileDTO dto);

    // 해당 공지의 파일 목록 조회
	public List<AttachFileDTO> findByNoticeId(Long noticeId);
	
	// 파일 정보 삭제
	public int deleteAttachByUuid(String uuid);
	
	public void updateReadCnt(Long id);


}
