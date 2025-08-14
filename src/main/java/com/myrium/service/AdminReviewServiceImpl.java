package com.myrium.service;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;
import com.myrium.mapper.AdminReviewMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class AdminReviewServiceImpl implements AdminReviewService{
	
	private final AdminReviewMapper mapper;
	
	public List<ReviewsummaryVO> getReviewList(Criteria cri) {

	    List<ReviewsummaryVO> productIds = mapper.getPagedProductIds(cri);	    
	    log.info("productIds:" + productIds);
	    if (productIds == null || productIds.isEmpty()) {
	        return Collections.emptyList();
	    }
	    return productIds;
	}

	@Override
	public int getDistinctProductCount(Criteria cri) {
		log.info(mapper.getDistinctProductCount(cri));
		return mapper.getDistinctProductCount(cri);	}
	
	@Override
	public List<ReviewDTO> getReviewListByproduct(Criteria cri, int productId) {		
		return mapper.getReviewsWithProducts(cri, productId);
	}

	@Override
	public int getReviewCountByProductId(Criteria cri, int productId) {
		log.info(mapper.getTotalReviewCount(cri, productId));
		return mapper.getTotalReviewCount(cri, productId);	}
	
	@Override
	public boolean harddel(int id) {
	     log.info("Review harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		log.info("Member softdel...." + id);
		return mapper.softdel(id)==1;
	}
	
	@Override
	public boolean restore(int id) {
		log.info("review restore...." + id);
		return mapper.restore(id)==1;
	}

	
}
