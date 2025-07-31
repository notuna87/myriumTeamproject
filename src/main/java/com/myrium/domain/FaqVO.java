package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FaqVO {
    private Long id;
    private Long userId;
    private int section;
    private String question;
    private String answer;
    private String customerId;
    private Date writeDate;
    private int isDeleted;  
    private Date createdAt;
    private String createdBy;
    private Date updatedAt;
    private String updatedBy;
}

