package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    
    List<ReviewDTO> findReviews(
            @Param("q") String q,
            @Param("offset") int offset,
            @Param("size") int size
        );

        int countReviews(@Param("q") String q);
}
