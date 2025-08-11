package com.myrium.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private String category; //필터링 카테고리
	private Integer is_discount = -1; //필터링 일반할인, Integer : 빈문자열 예외방지, 초기값 -1
	private Integer is_timesales = -1; //필터링 타임세일, Integer : 빈문자열 예외방지, 초기값 -1
	private Integer is_deleted = -1; //필터링 노출,미노출, Integer : 빈문자열 예외방지, 초기값 -1
	
	private String auth;
	private String gender;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
}
