package com.myrium.service;

import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.NoticeVO;

public interface NoticeService {
	
	   public void register(NoticeVO notice);
	   
	   public NoticeVO get(Long id);
	   
	   public boolean modify(NoticeVO notice);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public List<NoticeVO> getList();
	   
	   public List<NoticeVO> getList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(Long id);

	   public void insertAttach(AttachFileDTO dto);
	   
	   public List<AttachFileDTO> findByNoticeId(Long noticeId);

	   public int deleteAttachByUuid(String uuid);

	   public void incrementReadCnt(Long id);
	  

}
