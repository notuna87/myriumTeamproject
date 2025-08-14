package com.myrium.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;
import com.myrium.domain.PageDTO;
import com.myrium.service.AdminOrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/adminorder/*")
public class AdminOrderController {

	private final AdminOrderService service;	

	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
log.info("cri:" + cri);
	    List<OrderDTO> list = service.getOrderList(cri);

	    // 주문번호별 그룹핑
	    Map<String, List<OrderDTO>> groupedOrders = list.stream()
	        .collect(Collectors.groupingBy(OrderDTO::getOrdersId));
	    
	    model.addAttribute("groupedOrders", groupedOrders);

	    // 원본 리스트도 JSON 문자열로 변환 후 JSP에 전달
	    ObjectMapper mapper = new ObjectMapper();
	    try {
	        String ordersJson = mapper.writeValueAsString(list);
	        model.addAttribute("ordersJson", ordersJson);
	    } catch (JsonProcessingException e) {
	        log.error("JSON 변환 실패", e);
	        model.addAttribute("ordersJson", "[]");
	    }

	    int total = service.getTotal(cri);
	    model.addAttribute("pageMaker", new PageDTO(cri, total));

	}
	
	@ResponseBody
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/updateStatus")
	public Map<String, Object> updateOrderStatus(
	        @RequestParam("ordersId") String ordersId,
	        @RequestParam("orders_product_id") int ordersProductId,
	        @RequestParam("orderStatus") int orderStatus) {

	    Map<String, Object> result = new HashMap<>();
	    try {
	    	
	        service.updateOrderStatus(ordersId, ordersProductId, orderStatus);
	        
	        result.put("status", "success");
	        result.put("message", "상태가 변경되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", "상태 변경 중 오류가 발생했습니다.");
	    }
	    return result;
	}

}
