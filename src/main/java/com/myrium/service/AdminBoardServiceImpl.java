package com.myrium.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.myrium.domain.BoardVO;
import com.myrium.domain.Criteria;
import com.myrium.mapper.AdminBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminBoardServiceImpl implements AdminBoardService{
	
	@Autowired
	private AdminBoardMapper mapper;

	@Override
	public BoardVO get(Long id) {
	      return mapper.read(id);
	}

	@Override
	public boolean modify(BoardVO board) {
	     return mapper.update(board) == 1;
	}

	@Override
	public boolean harddel(Long id) {
	     return mapper.harddel(id) == 1;
	}

	@Override
	public boolean softdel(Long id) {
		return mapper.softdel(id) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		return mapper.getList();
	}

	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri, boolean isAdmin){
		return mapper.getListWithPaging(cri, isAdmin);
	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(Long id) {
		return mapper.restore(id) == 1;
	}

	@Override
	public List<BoardVO> getBoardList(Long productId) {		
		return mapper.getBoardList(productId);
	}
}
