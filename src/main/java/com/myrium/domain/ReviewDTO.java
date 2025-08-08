package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	
	private Long id;
    private Long userId;
    private Long productId;
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

    public String getMaskedId() {
        if (customerId == null) return "";

        int len = customerId.length();
        if (len == 1) return "*";
        if (len == 2) return customerId.charAt(0) + "*";
        if (len == 3) return customerId.charAt(0) + "*" + customerId.charAt(2);
        if (len == 4) return customerId.charAt(0) + "**" + customerId.charAt(3);

        return customerId.charAt(0) + "****" + customerId.substring(len - 2);
    }
    

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
}
