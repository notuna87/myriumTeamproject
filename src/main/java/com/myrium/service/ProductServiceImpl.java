package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
