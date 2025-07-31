package com.myrium.service;

import java.util.List;

import com.myrium.domain.OrderDTO;

public interface OrderService {

	  List<OrderDTO> getOrderListByCustomerId(String customerId);
}
