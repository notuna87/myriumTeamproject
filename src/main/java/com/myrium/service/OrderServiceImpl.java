package com.myrium.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myrium.domain.OrderDTO;
import com.myrium.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
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
	public void insertOrdersProduct(int productid, Long orderId, Long userId, int quantity, String customerName, int payment) {
		
		orderMapper.insertOrdersProduct(productid, orderId, userId, quantity, customerName, payment);
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
        List<OrderDTO> list = orderMapper.findOrderDetailById(orderId);
        return (list != null) ? list : java.util.Collections.emptyList();
    }
    
    @Override
    public int getValidOrderTotalAmount(Long orderId) {
        return orderMapper.getValidOrderTotalAmount(orderId);
    }
    
    //교환,환불버튼처리
    @Transactional
    @Override
    public void updateOrderStatus(Long orderId, int productId, int orderStatus) {
        // 1) 라인 변경
        if (productId > 0) {
            // 부분 취소/환불: 해당 상품 라인만
            orderMapper.updateOrderStatus(orderId, productId, orderStatus);

            // 2) 헤더는 '모든 라인'이 같은 상태일 때만 변경
            int total = orderMapper.countOrderLines(orderId);
            int same  = orderMapper.countOrderLinesWithStatus(orderId, orderStatus);
            if (total > 0 && same == total) {
                orderMapper.updateOrdersStatus(orderId, orderStatus);
            }

        } else {
            // 전체 취소/환불: 모든 라인 + 헤더 동시 변경
            orderMapper.updateAllOrderLines(orderId, orderStatus);
            orderMapper.updateOrdersStatus(orderId, orderStatus);
        }

        // 3) 플래그(주문 단위)
        if (orderStatus == 4) {           // 교환 신청
            orderMapper.updateExchangeFlag(orderId);
        } else if (orderStatus == 6) {    // 환불 신청
            orderMapper.updateRefundFlag(orderId);
        }

        log.info(String.format("updateOrderStatus: orderId=%d, productId=%d, status=%d",
                orderId, productId, orderStatus));
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

	//상품리뷰
	@Override
	public OrderDTO getOrderProduct(Long orderId, int productId) {
	    return orderMapper.findProductInOrder(orderId, productId);
	}
	
	//주문상태변경
	@Override
	public List<OrderDTO> getOrdersToAutoUpdate() {
		 log.info(">>>> OrderService: getOrdersToAutoUpdate() 호출됨");
	    return orderMapper.findOrdersForStatusUpdate();
	}
	
	 @Override
	    public int autoConfirmAfter1Day() {
	        int a = orderMapper.autoConfirmOrders();
	        int b = orderMapper.autoConfirmOrderProducts();
	        return a + b; // 합계 로그 확인용
	    }


	
}