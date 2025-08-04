package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.OrderDTO;

public interface OrderMapper {

	int insertOrders(OrderDTO orders);

	void insertOrdersProduct(@Param("productid") int productid, @Param("orderId") Long orderId,
			@Param("userId") Long userId, @Param("quantity") int quantity, @Param("customerName") String customerName);

	void deletePurchaseCart(@Param("userId") Long userId, @Param("productid") int productid);

	 List<OrderDTO> findOrdersByCustomerId(String customerId);
	 
	 List<OrderDTO> selectCanceledOrdersByCustomerId(String customerId);
	 
	 List<Map<String, Object>> countOrdersByStatus(String customerId);
	 
	 int getTotalPaidOrderAmount(String customerId);
	 
	 List<OrderDTO> findOrderDetailById(Long orderId);
	 
	 int getValidOrderTotalAmount(Long orderId);

}
