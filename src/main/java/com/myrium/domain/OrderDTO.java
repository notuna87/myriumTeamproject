package com.myrium.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
    private Long id;
    private String customerId;
    private String receiver;
    private String phoneNumber;
    private String address;
    private String ordersId;
    private String orderDate;
    private String productName;
    private int productPrice;
    private int quantity;
    private String orderStatus;
    private String paymentMethod;
    private String zipcode;
    private String deliveryMsg;
    private int productId;
    private String orderDisplayId;

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
        setOrderDisplayId(); // orderDate가 바뀌면 다시 계산
    }

    public void setOrdersId(String ordersId) {
        this.ordersId = ordersId;
        setOrderDisplayId(); // ordersId가 바뀌면 다시 계산
    }
    
    public String getOrderDisplayId() {
        return orderDisplayId;
    }

    public void setOrderDisplayId() {
        if (orderDate != null && ordersId != null) {
            try {
                // String -> Date 변환
                SimpleDateFormat parser = new SimpleDateFormat("yyyy-MM-dd"); // 문자열 형식에 맞게 수정
                Date date = parser.parse(orderDate);

                // 날짜 형식 변경
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                String datePart = sdf.format(date);

                String idPart = String.format("%08d", Integer.parseInt(ordersId));
                this.orderDisplayId = datePart + "-" + idPart;
            } catch (Exception e) {
                this.orderDisplayId = "";
            }
        } else {
            this.orderDisplayId = "";
        }
    }
}
