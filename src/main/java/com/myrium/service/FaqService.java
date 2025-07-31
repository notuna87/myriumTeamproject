package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.FaqVO;

public interface FaqService {
	
	   public void register(FaqVO faq);
	   
	   public FaqVO get(Long id);
	   
	   public boolean modify(FaqVO faq);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public List<FaqVO> getList(boolean isAdmin);
	   
	   //public List<FaqVO> getList(Criteria cri, boolean isAdmin);
	   
	   //public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(Long id);
	  

}
