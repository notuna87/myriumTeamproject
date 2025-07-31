package com.myrium.domain;

import lombok.Data;

@Data
public class OrderDTO {
		private Long id;
	    private String customerId;
	    private String receiver;
	    private String phoneNumber;
	    private String address;
	    private String orderId;
	    private String orderDate;
	    private String productName;
	    private int productPrice;
	    private int quantity;
	    private String orderStatus;
	}
