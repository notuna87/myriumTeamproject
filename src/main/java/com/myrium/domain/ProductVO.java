package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	private int id;
	private String product_name;
	private String category;
	private String product_content;
	private Integer product_stock;
	private int product_price;
	private int is_deleted;
	private Date created_at;
	private String created_by;
	private Date updated_at;
	private String updated_by;
}
