package com.myrium.service;

import java.util.List;
import java.util.Map;

import com.myrium.domain.ReviewDTO;

public interface ReviewService {
    void insertReview(ReviewDTO review);
    
    List<ReviewDTO> getReviewsByProductId(Long productId);
    
    void incrementViewCount(Long reviewId);
    
    ReviewDTO getReviewById(Long reviewId);
    
    public void incrementViewCountByProductId(Long productId);
    
    Double getAverageRatingByProductId(Long productId);
    
    int countReviewsByProductId(Long productId);
    
    List<ReviewDTO> getPagedReviewsByProductId(Map<String, Object> paramMap);
    
    int countReviews(String q);
    List<ReviewDTO> findReviews(String q, int offset, int limit);
}
