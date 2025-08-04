package com.myrium.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class CategoryVO {
	private int product_id = 0;
	private int gardening = 0;
	private int plantkit = 0;
	private int hurb = 0;
	private int vegetable = 0;
	private int flower = 0;
	private int etc = 0;
	
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
