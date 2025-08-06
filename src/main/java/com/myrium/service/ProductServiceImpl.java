package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.CartVO;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;
import com.myrium.mapper.ProductMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper productmapper;
	

	// controller에서 지정한 카테고리에 해당하는 목록 불러오기
	@Override
	public List<ProductDTO> getProductWithThumbnailList(String category) {
		List<ProductVO> products = productmapper.getproductList(category);
		List<ProductDTO> productDTOs = new ArrayList<>();

		for (ProductVO product : products) {
			ImgpathVO thumbnail = productmapper.getThumbnail(product.getId());
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(thumbnail);
			productDTOs.add(dto);
		}
		return productDTOs;
	}

	@Override
	public List<ProductDTO> getTimesaleWithThumbnailList() {
		List<ProductVO> products = productmapper.gettimesaleList();
		List<ProductDTO> productDTOs = new ArrayList<>();

		for (ProductVO product : products) {
			ImgpathVO thumbnail = productmapper.getThumbnail(product.getId());
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(thumbnail);
			productDTOs.add(dto);
		}
		return productDTOs;
	}

	@Override
	public ProductDTO productInfoget(int id) {
		ProductVO vo = productmapper.getproductInfo(id); //

		ProductDTO dto = new ProductDTO(); // DTO로 감싸기
		dto.setProduct(vo);
		return dto;
	}

	@Override
	public ProductDTO productInfothumbnail(int id) {
		ImgpathVO thumbnail = productmapper.productInfothumbnail(id);

		ProductDTO dto = new ProductDTO();
		dto.setThumbnail(thumbnail);
		return dto;
	}

	@Override
	public ProductDTO productSliderImg(int id) {
		List<ImgpathVO> sliderImg = productmapper.productSliderImg(id);

		ProductDTO dto = new ProductDTO();
		dto.setSliderImg(sliderImg);

		return dto;
	}

	@Override
	public ProductDTO productDetailImg(int id) {
		ImgpathVO productDetailImg = productmapper.productDetailImg(id);
		ProductDTO dto = new ProductDTO();

		dto.setProductDetailImg(productDetailImg);
		return dto;
	}

	@Override
	public List<ProductDTO> getPopularProduct() {
		List<ProductVO> products = productmapper.getPopularProduct();
		List<ProductDTO> productDTOs = new ArrayList<>();

		for (ProductVO product : products) {
			ImgpathVO thumbnail = productmapper.getThumbnail(product.getId());
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(thumbnail);
			productDTOs.add(dto);
		}
		return productDTOs;
	}

	// 장바구니에 담기
	@Override
	public ProductDTO inCart(int quantity, int productId, Long userId, String customerId) {
		
		CartVO vo;
		
		CartVO existingCart = productmapper.findCartItem(productId, userId);
		
		// 중복된 제품을 담을 시 +1 
		if (existingCart != null) {
			int newQuantity = existingCart.getQuantity() + quantity;
			vo = productmapper.addQuantity(productId, userId, newQuantity);
		} else {
			vo = productmapper.inCart(quantity, productId, userId, customerId);
		}

		ProductDTO dto = new ProductDTO();
		dto.setInCart(vo);
		return dto;
	}

	@Override
	public List<ProductDTO> CartList(Long userId) {
		List<ProductVO> products = productmapper.CartList(userId);
		List<ProductDTO> productDTOs = new ArrayList<>();

		for (ProductVO product : products) {
			// 썸네일 가져오기
			ImgpathVO thumbnail = productmapper.getThumbnail(product.getId());
			CartVO quantity = productmapper.getCartInfo(product.getId(), userId);
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(thumbnail);
			dto.setInCart(quantity);
			productDTOs.add(dto);
		}


		return productDTOs;
	}

	@Override
	public void updateQuantity(Long productId, Integer newQuantity, Long userId) {
	    int updated = productmapper.updateQuantity(productId, userId, newQuantity);
	}

	@Override
	public void deleteCart(Long productId, Long userId) {
		int deleted = productmapper.deleteCart(productId, userId);
	}

	@Override
	public int getStock(int productid) {
		
		return productmapper.getStock(productid);
	}

	@Override
	public void decreaseStock(int decreaseStock, int productid) {
		productmapper.decreaseStock(decreaseStock, productid);
	}

	@Override
	public int getSalesCount(int productid) {
		return productmapper.getSalesCount(productid);
	}

	@Override
	public void increaseSalesCount(int increaseSalesCount, int productid) {
		productmapper.increaseSalesCount(increaseSalesCount, productid);
	}

	@Override
	public List<ProductDTO> getSearchProductList(String searchKeyword) {
		List<ProductVO> products = productmapper.getSearchProductList(searchKeyword);
		List<ProductDTO> productDTOs = new ArrayList<>();

		for (ProductVO product : products) {
			ImgpathVO thumbnail = productmapper.getThumbnail(product.getId());
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(thumbnail);
			productDTOs.add(dto);
		}
		return productDTOs;
	}
	
	//상품리뷰
	@Override
	public ProductDTO getProductById(Long id) {
		return productmapper.findById(id); 
	}

}
