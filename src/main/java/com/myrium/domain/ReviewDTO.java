package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	
	private Long id;
    private Long userId;
    private Long productId;
    private Long reviewId;
    private String customerId;
    private String reviewTitle;
    private String reviewContent;
    private String imageUrl;
    private int rating;
    private int viewCount;
    private Date reviewDate;
    private int isDeleted;
    private Date createdAt;
    private String createdBy;
}
