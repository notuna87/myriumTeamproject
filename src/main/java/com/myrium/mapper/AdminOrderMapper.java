package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;

public interface AdminOrderMapper {
	
	public int getTotalCount(@Param("cri") Criteria cri);	
	
    int updateOrderProductStatus(@Param("ordersProductId") int ordersProductId, @Param("orderStatus") int orderStatus);

	int updateOrderStatus(@Param("ordersId") String ordersId, @Param("orderStatus") int orderStatus);
	
	public List<Integer> getPagedOrderIds(@Param("cri") Criteria cri);
	
	public List<OrderDTO> getOrdersWithProducts(List<Integer> orderIds);

	public List<Integer> getStatusByOrdersId(String ordersId);
	
}