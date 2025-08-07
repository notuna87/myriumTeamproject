package com.myrium.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.myrium.domain.ReviewDTO;

@Mapper
public interface ReviewMapper {
    void insertReview(ReviewDTO review);
}
