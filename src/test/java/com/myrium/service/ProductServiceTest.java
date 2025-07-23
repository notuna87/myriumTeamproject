package com.myrium.service;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.myrium.domain.ImgpathVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
@WebAppConfiguration
public class ProductServiceTest {
    @Autowired
    private ProductService productservice;
    
    @Test
    public void testgetProductList() {
    	productservice.getProductList().forEach(product ->log.info(product));
    }
    
    @Test
    public void testgetThumbnail() {
    	ImgpathVO imgpath = productservice.getThumbnail(5);
    	log.info("imgpath : " + imgpath.getImg_path());
    }
}
