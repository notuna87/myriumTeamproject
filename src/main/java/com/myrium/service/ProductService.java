package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;
import com.myrium.domain.ProductDTO;

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
	
	// 장바구니 담기
	public ProductDTO inCart(int quantity, int productId, Long userId, String customerId);
	
	// 장바구니 리스트 불러오기
	public List<ProductDTO> CartList(Long userId);

	void updateQuantity(Long productId, Integer newQuantity, Long userId);

	void deleteCart(Long productId, Long userId);

	public int getStock(int productid);

	public void decreaseStock(int decreaseStock, int productid);

	public int getSalesCount(int productid);

	public void increaseSalesCount(int increaseSalesCount, int productid);

}
