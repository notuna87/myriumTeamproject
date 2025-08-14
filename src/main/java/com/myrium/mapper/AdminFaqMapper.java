package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.Criteria;
import com.myrium.domain.FaqVO;

public interface AdminFaqMapper {
	
	public void insert(FaqVO faq);
	
	public void insertSelectKey(FaqVO faq);
	
	public FaqVO get(Long id);
	
	public List<FaqVO> getList(boolean isAdmin);
	
	public int update(FaqVO faq);
	
	public int harddel(Long id); //하드(영구) 삭제
	
	public int softdel(Long id); //소프트 삭제
	
	public int restore(Long id); //복구

}
