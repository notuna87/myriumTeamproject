package com.myrium.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class OrderDTO {

		private Long id; // 시퀀스 아이디
	    private String customerId; // 고객 아이디
	    private String receiver; // 성함
	    private String phoneNumber; // 핸드폰 번호
	    private String address; // 주소
	    private String ordersId; // 주문번호 (20250804-00000001)
	    private String orderDate; // 주문한 날짜
	    private String productName; // 상품 이름
	    private int productPrice; // 상품 가격
	    private int quantity; // 상품 수량
	    private int orderStatus; // 주문 상태
	    private String zipcode; // 우편 주소
	    private Long userId; // 유저 아이디 
	    private String title; // 제목
	    private String content; // 내용
	    private String deliveryMsg; // 상품요청사항
	    private int paymentMethod; // 결제
	    private int productId;
	    private String orderDisplayId;
	    private String ordersIdfull;
	    
	    private int isApprefund;   //환불신청여부
	    private int isAppexchanged;  //교환신청여부
	    
	    private int isRefundable; //환불완료
	    private int isExchanged;	//교환완료

	  private String product_name;
		private int discount_price;
		private int product_price;
		private String product_content;
		private int orders_product_id;
		
		private String img_path;


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
    
    public OrderDTO(int orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public OrderDTO() {
	}

	public String getOrderStatusText() {
        switch (this.orderStatus) {
            case 0: return "입금전";
            case 1: return "배송준비중";
            case 2: return "배송중";
            case 3: return "배송완료";
            case 4: return "교환신청중";
            case 5: return "교환완료";
            case 6: return "환불신청중";
            case 7: return "환불완료";
            //case 8: return "주문취소중";
            //case 9: return "취소완료";
        }
        return null;
    }
	
	public String getPayment() {
        switch (this.paymentMethod) {
            case 0: return "무통장입금";
            case 1: return "신용카드";
            case 2: return "가상계좌";
            case 3: return "실시간 계좌이체";
        }
        return null;
    }
	
	//주문상태변경
	public Date getOrderDateAsDate() {
	    try {
	        // 날짜에 시간이 없을 경우 대비해서 00:00:00을 붙여줌
	        String dateStr = this.orderDate;

	        if (dateStr.length() <= 10) {
	            // yyyy-MM-dd → yyyy-MM-dd 00:00:00 으로 변환
	            dateStr = dateStr + " 00:00:00";
	        }

	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        return sdf.parse(dateStr);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

    }



