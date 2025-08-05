package com.myrium.service;

import java.util.List;
import java.util.Map;

import com.myrium.domain.OrderDTO;

public interface OrderService {

	int insertOrders(OrderDTO orders);

	void insertOrdersProduct(int productid, Long orderId, Long userId, int quantity, String customerName);

	void deletePurchaseCart(Long userId, int productid);

	List<OrderDTO> getOrderListByCustomerId(String customerId);

	List<OrderDTO> getCanceledOrdersByCustomerId(String customerId);

	List<Map<String, Object>> countOrdersByStatus(String customerId);

	int getTotalPaidOrderAmount(String customerId);

	List<OrderDTO> getOrderDetail(Long orderId);

	int getValidOrderTotalAmount(Long orderId);

	int countOrdersToday(String today);

}
