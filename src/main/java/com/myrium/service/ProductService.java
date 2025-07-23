package com.myrium.service;

import java.util.List;

import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductVO;


public interface ProductService {
	
	public List<ProductVO> getProductList();
	
	public ImgpathVO getThumbnail(int productid);
}
