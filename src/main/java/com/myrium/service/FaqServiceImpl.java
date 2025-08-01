package com.myrium.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.Criteria;
import com.myrium.domain.FaqVO;
import com.myrium.mapper.FaqMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FaqServiceImpl implements FaqService{
	
	@Autowired
	private FaqMapper mapper;


	@Override
	public FaqVO get(Long id) {
	      log.info("get....." + id);
	      return mapper.read(id);
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
	public List<FaqVO> getList(boolean isAdmin) {
		log.info("FAQ getList.....");
		return mapper.getList(isAdmin);
	}


	@Override
	public void register(FaqVO faq) {
		log.info("FAQ register....." + faq);
		mapper.insertSelectKey(faq);
	}
	
//	@Override
//	public List<FaqVO> getList(Criteria cri, boolean isAdmin){
//		log.info("getList...(Criteria cri)");
//		//return mapper.getList();
//		return mapper.getListWithPaging(cri, isAdmin);
//	}
	
//	@Override
//	public int getTotal(Criteria cri, boolean isAdmin) {
//		log.info(mapper.getTotalCount(cri, isAdmin));
//		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(Long id) {
		log.info("restore...." + id);
		return mapper.restore(id)==1;
	}
}
