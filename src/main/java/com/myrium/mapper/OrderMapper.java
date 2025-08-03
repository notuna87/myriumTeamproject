package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import com.myrium.domain.OrderDTO;

public interface OrderMapper {
	 List<OrderDTO> findOrdersByCustomerId(String customerId);
	 
	 List<OrderDTO> selectCanceledOrdersByCustomerId(String customerId);
	 
	 List<Map<String, Object>> countOrdersByStatus(String customerId);
	 
	 int getTotalPaidOrderAmount(String customerId);
}
