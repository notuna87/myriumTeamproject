package com.myrium.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 브라우저에서 이미지 접근 가능하도록 경로 매핑
        registry.addResourceHandler("/upload/review/**")
                .addResourceLocations("file:///C:/upload/review/"); // 윈도우 기준
    }
}