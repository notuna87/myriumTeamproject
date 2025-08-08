package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.myrium.domain.ReviewDTO;

@Mapper
public interface ReviewMapper {
    void insertReview(ReviewDTO review);
    
    List<ReviewDTO> getReviewsByProductId(Long productId);
    
    void incrementViewCount(Long reviewId);
    
    ReviewDTO getReviewById(Long reviewId);
    
    void incrementViewCountByProductId(Long productId);
    
    Double getAverageRatingByProductId(Long productId);
    
    int countReviewsByProductId(Long productId);
    
    List<ReviewDTO> getPagedReviewsByProductId(Map<String, Object> paramMap);
}
