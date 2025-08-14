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
	    // 주문 ID 리스트 페이징 쿼리 호출
	    List<Integer> orderIds = mapper.getPagedOrderIds(cri);

	    if (orderIds == null || orderIds.isEmpty()) {
	        return Collections.emptyList();
	    }

	    // 주문 ID 리스트로 주문 + 상품 상세 조회
	    List<OrderDTO> orders = mapper.getOrdersWithProducts(orderIds);

	    return orders;
	}
	
	@Override
	public void updateOrderStatus(String ordersId, int ordersProductId, int orderStatus) {
		
	    // 1. 개별 상품 상태 업데이트
	    mapper.updateOrderProductStatus(ordersProductId, orderStatus);
	    
	    // 2. 주문에 속한 모든 상품 상태 조회
	    List<Integer> statuses = mapper.getStatusByOrdersId(ordersId);
	    
	    // 3. 주문 상품이 2개 이상인지 확인
	    if (statuses.size() > 1) {
	        // 4. [4, 6, 8] 상태가 있는지 확인
	        boolean hasSpecialStatus = statuses.stream().anyMatch(s -> s == 4 || s == 6 || s == 8);
	        
	        if (hasSpecialStatus) {
	            // 5. 주문 상태를 99로 변경
	            mapper.updateOrderStatus(ordersId, 99);
	            return;
	        }
	    }
	    
	    // 6. 조건에 맞지 않으면 원래 주문 상태 업데이트
	    mapper.updateOrderStatus(ordersId, orderStatus);   	
	}



	
}
