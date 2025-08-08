package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AttachFileDTO {
	private int id;
	private int productId;
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
	private String imgPath;
	private int isDeleted;
	private String imgPathThumb;
	private boolean toDelete;
	private boolean isNew;
}
