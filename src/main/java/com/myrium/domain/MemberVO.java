package com.myrium.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private Long id;
	private String customerId;
	private String password;
	private String customerName;
	private String address;
	private String zipcode; // 우편번호
	private String addr1;   // 기본주소
	private String addr2; //나머지주소 
	private String phoneNumber;
	private String email;
	private String gender;
	private Date birthdate;
	private String role;
	private int agreeTerms;
	private int agreePrivacy;
	private Integer agreeThirdParty;
	private Integer agreeDelegate;
	private Integer agreeSms;
	private int isDeleted;
	private Date createdAt;
	private String createdBy;
	private Date updatedAt;
	private String updatedBy;

    private List<AuthVO> authList;
}
