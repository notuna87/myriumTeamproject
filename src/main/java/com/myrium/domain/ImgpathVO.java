package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ImgpathVO {
	private int id;
	private int product_id;
	private String img_path;  // 원본이미지 경로
	private Date created_at;
	private String created_by;
	private Date updated_at;
	private String updated_by;
	private int is_deleted;
	private int is_thumbnail;
	private int is_thumbnail_main; //대표 이미지 여부
	private int is_detail;
	private String uuid;  // 서버 식별용
	private String img_path_thumb;  // 썸네일 경로
}
