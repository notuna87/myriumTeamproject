package com.myrium.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.myrium.domain.OrderDTO;
import com.myrium.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final OrderMapper orderMapper;

	@Override
	public List<OrderDTO> getOrderListByCustomerId(String customerId) {
		return orderMapper.findOrdersByCustomerId(customerId);
	}

	@Override
	public int insertOrders(OrderDTO orders) {

		return orderMapper.insertOrders(orders);
	}

	@Override
	public void insertOrdersProduct(int productid, Long orderId, Long userId, int quantity, String customerName) {

		orderMapper.insertOrdersProduct(productid, orderId, userId, quantity, customerName);
	}

	@Override
	public void deletePurchaseCart(Long userId, int productid) {

		orderMapper.deletePurchaseCart(userId, productid);
	}
    
    // 교환/환불 데이터 조회 구현
    @Override
    public List<OrderDTO> getCanceledOrdersByCustomerId(String customerId) {
        return orderMapper.selectCanceledOrdersByCustomerId(customerId);
    }
    
    @Override
    public List<Map<String, Object>> countOrdersByStatus(String customerId) {
        return orderMapper.countOrdersByStatus(customerId);
    }
    
    @Override
    public int getTotalPaidOrderAmount(String customerId) {
        return orderMapper.getTotalPaidOrderAmount(customerId);
    }
    
    @Override
    public List<OrderDTO> getOrderDetail(Long orderId) {
        return orderMapper.findOrderDetailById(orderId);
    }
    
    @Override
    public int getValidOrderTotalAmount(Long orderId) {
        return orderMapper.getValidOrderTotalAmount(orderId);
    }
    
    //환불버튼처리
    @Override
    public boolean applyRefund(Long orderId, Long productId) {
        int updated = orderMapper.updateRefundStatus(orderId, productId);
        return updated > 0;
    }
    //교환버튼처리
    @Override
    public boolean applyExchange(Long orderId, Long productId) {
        int updated = orderMapper.updateExchangeStatus(orderId, productId);
        return updated > 0;
    }
  
  	@Override
	public int countOrdersToday(String today) {
		return orderMapper.countOrdersToday(today);
	}
  
	@Override
	public List<OrderDTO> productList(Long orderId) {
		
		return orderMapper.productList(orderId);
	}

	@Override
	public void decreaseStock(int productid, int quantity) {
		orderMapper.decreaseStock(productid, quantity);
	}
}