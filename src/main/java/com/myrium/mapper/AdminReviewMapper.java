package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ReviewDTO;
import com.myrium.domain.ReviewsummaryVO;

public interface AdminReviewMapper {
	
	public List<ReviewDTO> getList();	
	public void insert(ReviewDTO review);
	public void insertSelectKey(ReviewDTO review);
	public ReviewDTO read(int id);
	public int harddel(int id); //하드(영구) 삭제
	public int softdel(int id); //소프트 삭제
	public int restore(int id); //복구
	public int update(ReviewDTO review);	
	public List<ReviewDTO> getListWithPaging(@Param("cri") Criteria cri);	
	public int getDistinctProductCount(@Param("cri") Criteria cri);	
	public int getTotalReviewCount(@Param("cri") Criteria cri, @Param("productId") int productId);	
	
	public List<ReviewsummaryVO> getReviewList(@Param("cri") Criteria cri);
	
	public List<AuthVO> getAuthList(Long id);
	
	public Integer countAdminRole(Long id);
	
	public void insertAdminRole(Long id);
	
	public void deleteAdminRole(Long id);
	
    int updateReviewProductStatus(@Param("reviewsProductId") int reviewsProductId,
            @Param("reviewStatus") int reviewStatus);

	int updateReviewStatus(@Param("reviewsId") String reviewsId,
	      @Param("reviewStatus") int reviewStatus);
	
	public List<ReviewsummaryVO> getPagedProductIds(
			@Param("cri") Criteria cri);
	
	public List<ReviewDTO> getReviewsWithProducts(
		    @Param("cri") Criteria cri,
		    @Param("productId") int productId
		);




}