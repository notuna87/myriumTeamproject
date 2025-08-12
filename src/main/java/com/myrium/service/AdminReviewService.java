package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;

public interface AdminReviewService {
	
	   public void register(ReviewDTO dto);	   
	   
	   public boolean modify(ReviewDTO dto);
	   
	   public boolean harddel(int id);
	
	   public boolean softdel(int id);
	   
	   public List<ReviewDTO> getList();
	   
	   //public List<ReviewDTO> getReviewListWithProduct(Criteria cri, boolean isAdmin);
	   public List<ReviewsummaryVO> getReviewList(Criteria cri);
	   
	   public int getDistinctProductCount(Criteria cri);
	   
	   public int getTotalOfReviewByProductId(Criteria cri, int productId);

	   public boolean restore(int id);
  
	   public ReviewDTO get(int id);

	   public void updateReviewStatus(String reviewsId, int reviewsProductId, int reviewStatus);

	   public List<ReviewDTO> getReviewListByproduct(Criteria cri, int productId);
	   
}
