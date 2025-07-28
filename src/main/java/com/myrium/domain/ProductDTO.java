package com.myrium.domain;


import java.util.List;

import lombok.Data;

@Data
public class ProductDTO {
    private ProductVO product;
    private ImgpathVO thumbnail;
	private List<ImgpathVO> sliderImg;

}
