package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

// 작성자 : 노기원
// 작성일 : 2025.07.23 14:44
// 내용 : 상품 목록 불러오기 및 product_id 일치하는 썸네일 불러오기
@Mapper
public interface ProductMapper {
	
	// 썸네일 불러오기
	public ImgpathVO getThumbnail(int productid);
		
	// 카테고리 목록 불러오기
	public List<ProductVO> getproductList(String category);
	
	// 타임세일 목록 불러오기
	public List<ProductVO> gettimesaleList();
	
	// 상품 상세페이지 정보 불러오기
	public ProductVO getproductInfo(int id);

	// 상품 상세페이지 썸네일
	public ImgpathVO productInfothumbnail(int id);
	
	// 상세페이지 슬라이더 이미지 목록 불러오기
	public List<ImgpathVO> productSliderImg(int id);
	
	// 상세페이지 상품상세정보 이미지 불러오기
	public ImgpathVO productDetailImg(int id);
	
	// 판매량순 상위 10개 상품 가져오기
	public List<ProductVO> getPopularProduct();
}

