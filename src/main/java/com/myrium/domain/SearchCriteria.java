package com.myrium.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class SearchCriteria {
	  private int pageNum;    // 페이지 번호
	  private int amount;      // 페이지당 보여줄 개수
	 
	  public SearchCriteria() {
	    this(1, 8);   // 디폴트로 1페이지에 8개씩 보여주도록 설정
	  }

	  public SearchCriteria(int pageNum, int amount) {
	    this.pageNum = pageNum;
	    this.amount = amount;
	  }
}
