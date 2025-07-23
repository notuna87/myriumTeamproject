package com.myrium.service;

import java.util.List;

import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface ProductService {
	// product_id와 일치하는 썸네일 불러오기 is_thumbnail이 1일때만
	public List<ProductDTO> getProductWithThumbnailList(String category);

	public List<ProductDTO> getTimesaleWithThumbnailList();
}
