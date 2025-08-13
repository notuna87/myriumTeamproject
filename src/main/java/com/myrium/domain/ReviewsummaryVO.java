package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewsummaryVO {
	
    private Long productId;
    private String productName; 
    private String imageUrl;
    private Double avgRating;
    private Integer reviewCount;
    private Date lastReviewDate;
}
