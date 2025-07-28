package com.myrium.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.Criteria;
import com.myrium.domain.NoticeVO;
import com.myrium.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeMapper mapper;


	@Override
	public NoticeVO get(Long id) {
	      log.info("notice get....." + id);
	      return mapper.read(id);
	}


	@Override
	public boolean modify(NoticeVO notice) {
	     log.info("notice modify.... " + notice);
	     return mapper.update(notice)==1;
	}

	@Override
	public boolean harddel(Long id) {
	     log.info("notice harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(Long id) {
		log.info("notice softdel...." + id);
		return mapper.softdel(id)==1;
	}

	@Override
	public List<NoticeVO> getList() {
		log.info("notice getList.....");
		return mapper.getList();
	}


	@Override
	public void register(NoticeVO notice) {
		log.info("notice register....." + notice);
		mapper.insertSelectKey(notice);
	}
	
	@Override
	public List<NoticeVO> getList(Criteria cri, boolean isAdmin){
		log.info("notice getList...(Criteria cri)");
		//return mapper.getList();
		return mapper.getListWithPaging(cri, isAdmin);
	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		log.info(mapper.getTotalCount(cri, isAdmin));
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(Long id) {
		log.info("restore...." + id);
		return mapper.restore(id)==1;
	}
}
