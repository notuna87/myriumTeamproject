package com.myrium.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import com.myrium.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class OrderhistoryController {
	
	@Autowired
	private OrderService orderService;
	

}
