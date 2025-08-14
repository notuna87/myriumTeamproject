package com.myrium.service;

import java.util.List;

import com.myrium.domain.FaqVO;

public interface AdminFaqService {
	
	   public void register(FaqVO faq);
	   
	   public FaqVO get(Long id);
	   
	   public List<FaqVO> getList(boolean isAdmin);
	   
	   public boolean modify(FaqVO faq);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public boolean restore(Long id);

}
