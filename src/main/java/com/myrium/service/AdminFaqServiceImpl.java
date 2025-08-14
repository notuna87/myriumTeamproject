package com.myrium.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myrium.domain.FaqVO;
import com.myrium.mapper.AdminFaqMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class AdminFaqServiceImpl implements AdminFaqService{
	
	private final AdminFaqMapper mapper;
	
	@Override
	public void register(FaqVO faq) {
		mapper.insertSelectKey(faq);
	}

	@Override
	public FaqVO get(Long id) {
	      return mapper.get(id);
	}
	
	@Override
	public List<FaqVO> getList(boolean isAdmin) {
		log.info("FAQ getList.....");
		return mapper.getList(isAdmin);
	}

	@Override
	public boolean modify(FaqVO faq) {
	     log.info("FAQ modify.... " + faq);
	     return mapper.update(faq)==1;
	}

	@Override
	public boolean harddel(Long id) {
	     log.info("remove...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(Long id) {
		log.info("remove...." + id);
		return mapper.softdel(id)==1;
	}
	
	@Override
	public boolean restore(Long id) {
		log.info("restore...." + id);
		return mapper.restore(id)==1;
	}
}
