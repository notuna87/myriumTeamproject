package com.myrium.domain;

import lombok.Data;

@Data
public class CategoryVO {
	private Long product_id;
	private int gardening;
	private int plantkit;
	private int hurb;
	private int vegetable;
	private int flower;
	private int etc;
}
