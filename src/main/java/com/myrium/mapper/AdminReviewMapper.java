package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;

public interface AdminReviewMapper {
	
	public List<ReviewsummaryVO> getPagedProductIds(@Param("cri") Criteria cri);
	
	public int getDistinctProductCount(@Param("cri") Criteria cri);
	
	public List<ReviewDTO> getReviewsWithProducts(@Param("cri") Criteria cri, @Param("productId") int productId);
	
	public int getTotalReviewCount(@Param("cri") Criteria cri, @Param("productId") int productId);		
	
	public int harddel(int id); //하드(영구) 삭제
	
	public int softdel(int id); //소프트 삭제
	
	public int restore(int id); //복구
	
}