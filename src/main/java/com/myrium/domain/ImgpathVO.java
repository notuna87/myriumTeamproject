package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ImgpathVO {
	private int id;
	private int product_id;
	private String img_path;
	private Date created_at;
	private String created_by;
	private Date updated_at;
	private String updated_by;
	private int is_deleted;
	private int is_thumbnail;
	private int is_datail;
}
