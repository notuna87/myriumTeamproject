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
    
    //교환,환불버튼처리
    @Override
    public void updateOrderStatus(Long orderId, int productId, int orderStatus) {
        // 1. 상품 상태 업데이트
        orderMapper.updateOrderStatus(orderId, productId, orderStatus);

        // 2. 주문 상태 업데이트
        orderMapper.updateOrdersStatus(orderId, orderStatus);

        // 3. 환불/교환 신청 여부 업데이트
        if (orderStatus == 4) { // 교환 신청
            orderMapper.updateExchangeFlag(orderId);
        } else if (orderStatus == 6) { // 환불 신청
            orderMapper.updateRefundFlag(orderId);
        }
    }
    
    //교환,환불 완료처리 주문상태변경
    @Override
    public void checkAndCompleteStatus(Long orderId) {
        // orders 테이블에서 현재 환불/교환 플래그 조회
        OrderDTO order = orderMapper.findOrderById(orderId);
        
        if (order.getIsRefundable() == 1) {
            orderMapper.completeRefundStatus(orderId);
        }
        if (order.getIsExchanged() == 1) {
            orderMapper.completeExchangeStatus(orderId);
        }
    }
  
  	@Override
	public int countOrdersToday(String today) {
		return orderMapper.countOrdersToday(today);
	}
  
	@Override
	public List<OrderDTO> productList(Long orderId) {
		return orderMapper.productList(orderId);
	}


}