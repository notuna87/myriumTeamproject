package com.myrium.service;

import java.util.List;

import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface ProductService {
	// product_id와 일치하는 썸네일 불러오기 is_thumbnail이 1일때만
	public List<ProductDTO> getProductWithThumbnailList(String category);

	public List<ProductDTO> getTimesaleWithThumbnailList();
	
	public ProductDTO productInfoget(int id);
	
	public ProductDTO productInfothumbnail(int id);
	
	public ProductDTO productSliderImg(int id);
	
	public ProductDTO productDetailImg(int id);
	
	// 판매량 순 10개까지 리스트 불러오기
	public List<ProductDTO> getPopularProduct();
}
