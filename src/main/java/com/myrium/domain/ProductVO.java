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
	private int is_timesales;
	private int is_discount;
	private int discount_rate;
	private int timesalediscount_rate;
	private int total_discountrate;
	private int discount_price;
}
