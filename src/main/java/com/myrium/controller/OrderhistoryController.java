package com.myrium.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.myrium.domain.OrderDTO;
import com.myrium.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class OrderhistoryController {
	
//	@GetMapping("/order_history")
//	public String showJoinform() {
//		return "mypage/order_history";
//	}
	
	@Autowired
	private OrderService orderService;
	
//	@GetMapping("/mypage/order_detail")
//	public String showOrderDetail() {
//	    return "mypage/order_detail"; 
//	}
	

}
