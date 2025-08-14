package com.myrium.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;
import com.myrium.mapper.AdminOrderMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService{
	
	private final AdminOrderMapper mapper;

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
		}

	public List<OrderDTO> getOrderList(Criteria cri) {
	    // 1) 주문 ID 리스트 페이징 쿼리 호출
	    List<Integer> orderIds = mapper.getPagedOrderIds(cri);

	    if (orderIds == null || orderIds.isEmpty()) {
	        return Collections.emptyList();
	    }

	    // 2) 주문 ID 리스트로 주문 + 상품 상세 조회
	    List<OrderDTO> orders = mapper.getOrdersWithProducts(orderIds);

	    return orders;
	}
	
	@Override
	public void updateOrderStatus(String ordersId, int ordersProductId, int orderStatus) {
		
		mapper.updateOrderProductStatus(ordersProductId, orderStatus);
		
		mapper.updateOrderStatus(ordersId, orderStatus);		
	}



	
}
