package com.myrium.service;

import java.util.List;

import com.myrium.domain.BoardVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ReplyPageDTO;

public interface BoardService {
	
	   public void register(BoardVO board);
	   
	   public BoardVO get(Long bno);
	   
	   public boolean modify(BoardVO board);
	   
	   public boolean remove(Long bno);
	   
	   public List<BoardVO> getList();
	   
	   public List<BoardVO> getList(Criteria cri);
	   
	   public int getTotal(Criteria cri);
	  

}
