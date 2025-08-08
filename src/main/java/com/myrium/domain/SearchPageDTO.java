package com.myrium.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class SearchPageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;

	private int total; // 전체 데이타 갯수(db저장된)
	private SearchCriteria cri; // 몇페이지, 페이지당 갯수
	
	public SearchPageDTO(SearchCriteria cri, int total) {

	    this.cri = cri;
	    this.total = total;

	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10; 

	    this.startPage = this.endPage - 9;  //시작페이지

	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount())); 

	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;  

	    this.next = this.endPage < realEnd;
	  }
}
