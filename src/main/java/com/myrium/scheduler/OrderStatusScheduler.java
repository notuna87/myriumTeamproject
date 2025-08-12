package com.myrium.scheduler;


import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.myrium.domain.OrderDTO;
import com.myrium.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class OrderStatusScheduler {

    @Autowired
    private OrderService orderService;

    @Scheduled(fixedRate = 10000)
    public void updateOrderStatusByTime() {
    	
        List<OrderDTO> orders = orderService.getOrdersToAutoUpdate(); // 배송준비중, 배송중인 주문들
        
        Date now = new Date();

        for (OrderDTO order : orders) {
            int status = order.getOrderStatus();
            Date orderDate = order.getOrderDateAsDate();

            if (orderDate == null) continue;

            long diffMillis = now.getTime() - orderDate.getTime();
            long diffHours = diffMillis / (1000 * 60 * 60);
            long diffDays = diffMillis / (1000 * 60 * 60 * 24);

            if (status == 1 && diffHours >= 1) {
                orderService.updateOrderStatus(order.getId(), order.getProductId(), 2); // 배송중

            } else if (status == 2 && diffDays >= 1) {
                orderService.updateOrderStatus(order.getId(), order.getProductId(), 3); // 배송완료
            }
        }

    }
    
    @Scheduled(cron = "0 0 2 * * *", zone = "Asia/Seoul")
    public void autoConfirmPurchaseDaily() {
        int lines = orderService.autoConfirmAfter1Day();
        log.info("[AutoConfirm] now=" + new Date() + ", lines=" + lines);
    }
    
    @PostConstruct
    public void init() {
        log.info("✅ OrderStatusScheduler Bean 등록됨");
    }
    
}