package com.myrium.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.ReviewDTO;
import com.myrium.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;

    @Override
    public void insertReview(ReviewDTO review) {
        reviewMapper.insertReview(review);
    }
}