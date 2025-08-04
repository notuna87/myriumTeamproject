package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AttachFileDTO {
	private Long id;
	private Long userId;
	private Long noticeId;
	private String fileName;
	private String uploadPath;
	private String uuid;
	private int image;
	private int isThumbnail;
	private int isThumbnailMain;
	private int isDetail;
	private String customerId;
	private Date uploadDate;
	private Date createdAt;
	private String createdBy;
	private Date updatedAt;
	private String updatedBy;
}
