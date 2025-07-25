package com.myrium.domain;

import lombok.Data;

@Data
public class ProductDTO {
    private ProductVO product;
    private ImgpathVO thumbnail;
    private ImgpathVO sliderImg;
}
