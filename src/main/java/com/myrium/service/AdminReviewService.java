package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;

public interface AdminReviewService {
	
	   public List<ReviewsummaryVO> getReviewList(Criteria cri);
	   
	   public int getDistinctProductCount(Criteria cri);	   
	   
	   public List<ReviewDTO> getReviewListByproduct(Criteria cri, int productId);
	   
	   public int getReviewCountByProductId(Criteria cri, int productId);
	   
	   public boolean harddel(int id);
		
	   public boolean softdel(int id);

	   public boolean restore(int id);
	   
}
