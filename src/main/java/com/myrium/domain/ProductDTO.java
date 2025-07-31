package com.myrium.domain;


import java.util.List;

import lombok.Data;

@Data
public class ProductDTO {
    private ProductVO product;
    private ImgpathVO thumbnail;
	private List<ImgpathVO> sliderImg;
	private ImgpathVO productDetailImg;
	private List<ProductVO> popularProduct;
	private CartVO inCart;
}
