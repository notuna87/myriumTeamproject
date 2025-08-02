package com.myrium.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class CategoryVO {
	private Long product_id;
	private int gardening;
	private int plantkit;
	private int hurb;
	private int vegetable;
	private int flower;
	private int etc;
	
    public List<String> getCategoryTags() {
        List<String> tags = new ArrayList<>();
        if (gardening == 1) tags.add("원예용품모음");
        if (plantkit == 1) tags.add("식물키트");
        if (hurb == 1) tags.add("허브키우기");
        if (vegetable == 1) tags.add("채소키우기");
        if (flower == 1) tags.add("꽃씨키우기");
        if (etc == 1) tags.add("기타키우기키트");
        return tags;
    }
}
