package com.myrium.domain;

import lombok.Data;

@Data
public class AuthVO {

	private Long userId;
	private String role;
	private String customerId;
}
