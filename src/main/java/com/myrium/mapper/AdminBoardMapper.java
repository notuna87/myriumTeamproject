package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.myrium.domain.BoardVO;
import com.myrium.domain.Criteria;

public interface AdminBoardMapper {
	
	public List<BoardVO> getList();	
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(Long id);
	public int harddel(Long id); //하드(영구) 삭제
	public int softdel(Long id); //소프트 삭제
	public int restore(Long id); //복구
	public int update(BoardVO board);
	
	public List<BoardVO> getListWithPaging(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	
	public List<BoardVO> searchTest(Map<String, Map<String, String>> map);
	
	public void updateReplyCnt(@Param("id") Long id, @Param("amount") int amount);

}
