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
    
    // ✅ 교환/환불 데이터 조회 구현
    @Override
    public List<OrderDTO> getCanceledOrdersByCustomerId(String customerId) {
        return orderMapper.selectCanceledOrdersByCustomerId(customerId);
    }
    
    @Override
    public List<Map<String, Object>> countOrdersByStatus(String customerId) {
        return orderMapper.countOrdersByStatus(customerId);
    }
}