package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;

public interface AdminOrderService {
	
	   public List<OrderDTO> getOrderList(Criteria cri);
	   
	   public int getTotal(Criteria cri);

	   public void updateOrderStatus(String ordersId, int ordersProductId, int orderStatus);
	   
}
