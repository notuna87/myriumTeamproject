package com.myrium.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;
import com.myrium.mapper.AdminReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminReviewServiceImpl implements AdminReviewService{
	
	@Autowired
	private AdminReviewMapper mapper;




	@Override
	public List<ReviewDTO> getList() {
		log.info("Review getList.....");
		return mapper.getList();
	}


	@Override
	public void register(ReviewDTO review) {
		log.info("Review register....." + review);
		mapper.insertSelectKey(review);
	}
	
//	@Override
//	public List<ReviewDTO> getList(Criteria cri, boolean isAdmin){
//		log.info("Review getList...(Criteria cri)");
//		return mapper.getList(cri, isAdmin);
//		//return mapper.getListWithPaging(cri, isAdmin);
//	}
	
	@Override
	public int getDistinctProductCount(Criteria cri) {
		log.info(mapper.getDistinctProductCount(cri));
		return mapper.getDistinctProductCount(cri);	}
	@Override
	public int getTotalOfReviewByProductId(Criteria cri, int productId) {
		log.info(mapper.getTotalReviewCount(cri, productId));
		return mapper.getTotalReviewCount(cri, productId);	}
	
	@Override
	public boolean restore(int id) {
		log.info("review restore...." + id);
		return mapper.restore(id)==1;
	}
	
	
	// 회줜정보 & 권한 리스트
//	@Override
//	public List<ReviewDTO> getReviewList(Criteria cri, boolean isAdmin) {
//		//List<ReviewDTO> reviewList = mapper.getReviewList(cri, isAdmin);
//		//List<ReviewDTO> reviewDTOList = new ArrayList<>();		
//		//for (ReviewDTO review : reviewList) {
//		//	List<AuthVO> auth = mapper.getAuthList(review.getId());
//		//	log.info("getAuthList:" + auth);
//			//review.setAuthList(auth);
//			//reviewDTOList.add(review);
//		
//		return mapper.getReviewList(cri, isAdmin);
//	}
	
	public List<ReviewsummaryVO> getReviewList(Criteria cri) {
	    // 1) 상품 ID 리스트 페이징 쿼리 호출
	    List<ReviewsummaryVO> productIds = mapper.getPagedProductIds(cri);
	    
	    log.info("productIds:" + productIds);

	    if (productIds == null || productIds.isEmpty()) {
	        return Collections.emptyList();
	    }
	    return productIds;

	    // 2) 주문 ID 리스트로 주문 + 상품 상세 조회
	    //List<ReviewDTO> reviews = mapper.getReviewsWithProducts(cri, productIds, isAdmin);
	    //log.info("productIds - reviews:" + reviews);

	    //return reviews;
	}
	
	@Override
	public List<ReviewDTO> getReviewListByproduct(Criteria cri, int productId) {		
		return mapper.getReviewsWithProducts(cri, productId);
	}

	
	
	@Override
	public ReviewDTO get(int id) {
	      log.info("Review get....." + id);
	      ReviewDTO review = mapper.read(id);
	      List<AuthVO> auth = mapper.getAuthList(review.getId());
	      //review.setAuthList(auth);
	      return review;
	}
	
	@Override
	public boolean modify(ReviewDTO vo) {
	     log.info("Member modify.... " + vo);
	     return mapper.update(vo)==1;
	}

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
	public void updateReviewStatus(String reviewsId, int reviewsProductId, int reviewStatus) {
		mapper.updateReviewProductStatus(reviewsProductId, reviewStatus);		
		mapper.updateReviewStatus(reviewsId, reviewStatus);		
	}





	
}
