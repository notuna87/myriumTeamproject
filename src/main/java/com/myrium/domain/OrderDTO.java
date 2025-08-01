package com.myrium.domain;

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
	    
	    //주문번호내역 매칭
	    private String orderDisplayId; // 화면 출력용 주문번호 (예: 20250801-0000001)

	    public void setOrderDisplayId() {
	        if (orderDate != null && ordersId != null) {
	            try {
	                String dateOnly = orderDate.replaceAll("-", "").substring(0, 8); // yyyyMMdd
	                int idInt = Integer.parseInt(ordersId); // String -> int 변환
	                String idFormatted = String.format("%07d", idInt);
	                this.orderDisplayId = dateOnly + "-" + idFormatted;
	            } catch (NumberFormatException e) {
	                this.orderDisplayId = "";
	            }
	        } else {
	            this.orderDisplayId = "";
	        }
	    }

}
