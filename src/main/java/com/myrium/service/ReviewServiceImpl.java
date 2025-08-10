package com.myrium.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myrium.domain.ReviewDTO;
import com.myrium.mapper.ReviewMapper;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;

    @Override
    public void insertReview(ReviewDTO review) {
        reviewMapper.insertReview(review);
    }
    
    @Override
    public List<ReviewDTO> getReviewsByProductId(Long productId) {
        return reviewMapper.getReviewsByProductId(productId);
    }
    
    @Override
    public void incrementViewCount(Long reviewId) {
        reviewMapper.incrementViewCount(reviewId);
    }
    
    @Override
    public ReviewDTO getReviewById(Long reviewId) {
        return reviewMapper.getReviewById(reviewId);
    }
    
    @Override
    public void incrementViewCountByProductId(Long productId) {
        reviewMapper.incrementViewCountByProductId(productId);
    }
    
    @Override
    public Double getAverageRatingByProductId(Long productId) {
        return reviewMapper.getAverageRatingByProductId(productId);
    }
    
    @Override
    public int countReviewsByProductId(Long productId) {
        return reviewMapper.countReviewsByProductId(productId);
    }
    
    @Override
    public List<ReviewDTO> getPagedReviewsByProductId(Map<String, Object> paramMap) {
        return reviewMapper.getPagedReviewsByProductId(paramMap);
    }
    
    @Override
    public int countReviews(String q) {
        return reviewMapper.countReviews(q);
    }

    @Override
    public List<ReviewDTO> findReviews(String q, int offset, int limit) {
        return reviewMapper.findReviews(q, offset, limit);
    }
    
}