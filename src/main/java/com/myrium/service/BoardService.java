package com.myrium.service;

import java.util.List;

import com.myrium.domain.BoardVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ReplyPageDTO;

public interface BoardService {
	
	   public void register(BoardVO board);
	   
	   public BoardVO get(Long id);
	   
	   public boolean modify(BoardVO board);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public List<BoardVO> getList();
	   
	   public List<BoardVO> getList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(Long id);
	  

}
