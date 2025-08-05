package com.myrium.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myrium.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class OrderhistoryController {
	
	@Autowired
	private OrderService orderService;
	

}
