package com.myrium.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
    private Long id;
    private Long userId;
    private String title;
    private String content;
    private String customerId;
    private Date writeDate;
    private String createdBy;
    private Date createdAt;
    private String updatedBy;
    private Date updatedAt;
    private Integer readCnt;
    private boolean hasFiles;
    private boolean isDeleted;
    private MultipartFile[] files;
}