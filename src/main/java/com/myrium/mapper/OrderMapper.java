package com.myrium.mapper;

import java.util.List;

import com.myrium.domain.OrderDTO;

public interface OrderMapper {
	 List<OrderDTO> findOrdersByCustomerId(String customerId);
	 
	 List<OrderDTO> selectCanceledOrdersByCustomerId(String customerId);
}
