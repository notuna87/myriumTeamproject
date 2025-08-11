package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.OrderDTO;

public interface OrderMapper {

	int insertOrders(OrderDTO orders);

	void insertOrdersProduct(@Param("productId") int productid, @Param("orderId") Long orderId,
			@Param("userId") Long userId, @Param("quantity") int quantity, @Param("customerName") String customerName,@Param("payment") int payment);

	void deletePurchaseCart(@Param("userId") Long userId, @Param("productid") int productid);

	List<OrderDTO> findOrdersByCustomerId(String customerId);

	List<OrderDTO> selectCanceledOrdersByCustomerId(String customerId);

	List<Map<String, Object>> countOrdersByStatus(String customerId);

	int getTotalPaidOrderAmount(String customerId);

	List<OrderDTO> findOrderDetailById(Long orderId);

	int getValidOrderTotalAmount(Long orderId);

	// 교환,환불 버튼처리
	void updateOrderStatus(@Param("orderId") Long orderId, @Param("productId") int productId,
			@Param("orderStatus") int orderStatus);

	void updateOrdersStatus(@Param("orderId") Long orderId, @Param("orderStatus") int orderStatus);

	// 교환,환불 신청여부
	void updateRefundFlag(@Param("orderId") Long orderId);

	void updateExchangeFlag(@Param("orderId") Long orderId);

	// 교환,환불 완료
	void completeRefundStatus(@Param("orderId") Long orderId);

	void completeExchangeStatus(@Param("orderId") Long orderId);

	OrderDTO findOrderById(@Param("orderId") Long orderId);

	int countOrdersToday(String today);

	List<OrderDTO> productList(Long orderId);
	
	//상품리뷰
	OrderDTO findProductInOrder(@Param("orderId") Long orderId, @Param("productId") int productId);

	//주문상태변경
	List<OrderDTO> findOrdersForStatusUpdate();
}
