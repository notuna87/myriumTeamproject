package com.myrium.service;

import java.util.List;

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
}