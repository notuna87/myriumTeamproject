<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리움</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/purchaseComplete.css" />

</head>
<body>
	<div class="purchaseCompleteWrap">
		<!-- 헤더 시작 -->
		<header>
			<div class="header">
				<a class="beforeButton" href="${pageContext.request.contextPath}/cart"><img src="${pageContext.request.contextPath}/resources/img/button/sfix_header.png" alt="afterButton"></a>마이리움
			</div>
			<div class="headerPurchase">주문완료</div>
		</header>
		<!-- 헤더 끝 -->
		<section>
			<!-- 주문이 완료되었습니다 시작 -->
			<div class="orderSuccessWrap">
				<p>고객님의 주문이</p>
				<p>정상적으로 완료되었습니다.</p>
			</div>
			<div class="orderNumberPrice">
				<table>
					<tr>
						<th>주문번호</th>
						<td><span>${orders.ordersId}</span></td>
					</tr>
					<tr>
						<th>결제금액</th>
						<td><span><fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />원</span></td>
					</tr>
				</table>
			</div>
			<!-- 주문이 완료되었습니다 끝 -->
			<!-- 결제수단 시작 -->
			<div class="paymentMethodTitle title">결제수단</div>
			<div class="paymentMethodWrap">
				<table>
					<tr>
						<th>결제수단</th>
						<td><span>${orders.paymentMethod}</span></td>
					</tr>
				</table>
			</div>
			<!-- 결제수단 끝 -->
			<!-- 배송지 시작 -->
			<div class="DeliveryDestinationTitle title">배송지</div>
			<div class="DeliveryDestinationContent">
				<table>
					<tr>
						<th>받는사람</th>
						<td><span>${orders.customerId}</span></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><span>(${orders.zipcode}) ${orders.address}</span></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><span>${orders.phoneNumber}</span></td>
					</tr>
					<tr>
						<th>배송요청</th>
						<td><span>${orders.deliveryMsg}</span></td>
					</tr>
				</table>
			</div>
			<!-- 배송지 끝 -->
			<!-- 주문 상품 시작 -->
			<div class="orderProductWrap">
				<div class="orderProductTitle title">주문상품</div>
				<div class="orderProduct">
					<c:forEach var="item" items="${productList}">
						<table style="border-bottom: 1px dashed #E9E9E9; width: 100%;">
							<tr>
								<th><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgcKJBzVf6xWEHZX3rvDJU-W8IQ1O45zsU_g&s" alt="test" class="orderProductThumbnail"></th>
								<td>
									<p style="margin-bottom: 10px;">${item.product_name}</p>
									<p style="color: #888">${item.product_content }</p>
									<p style="color: #888; margin-bottom: 10px;">수량 : ${item.quantity}개</p> 
									<c:if test="${item.discount_price != 0}">
										<p style="margin-bottom: 10px;">
											<fmt:formatNumber value="${item.discount_price * item.quantity}" type="number" groupingUsed="true" />원
										</p>
									</c:if> 
									<c:if test="${item.discount_price == 0}">
										<p style="margin-bottom: 10px;">
											<fmt:formatNumber value="${item.product_price * item.quantity}" type="number" groupingUsed="true" />원
										</p>
									</c:if>
								</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
			<!-- 주문 상품 끝 -->
			<!-- 결제 정보 시작 -->
			<div class="paymentInfoWrap">
				<div class="paymentInfoTitle title">결제정보</div>
				<div class="paymentInfo">
					<table>
						<tr>
							<th>주문상품</th>
							<td><span class="formattedTotal" style="float: right;" data-price="${formattedTotal}"><fmt:formatNumber value="${formattedTotal}" type="number" groupingUsed="true" />원</span></td>
						</tr>
						<tr class="deliveryCharge">

						</tr>
					</table>
				</div>
				<div class="finalPaymentAmount">
					<table>
						<tr>
							<th>결제 금액</th>
							<td><span style="float: right;"><fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />원</span></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 결제 정보 끝-->
			<!-- 버튼 시작 -->
			<div class="buttonWrap">
				<input type="button" class="orderCheck" value="주문확인하기">
				<input type="button" class="moreShopping" value="쇼핑계속하기">
			</div>
			<!-- 버튼 끝 -->
		</section>
	</div>
</body>
<script>
	document.addEventListener("DOMContentLoaded", showDeliveryCharge);

	function showDeliveryCharge() {
		
		const formattedTotalE1 = document.querySelector('.formattedTotal');
		const formattedTotal = parseInt(formattedTotalE1.getAttribute('data-price'))
		
		if(formattedTotal < 49900){
			  document.querySelector('.deliveryCharge').innerHTML = `
				  <th>배송비</th>
				  <td><span style="float: right;">+3,000원</span></td>
			  `;
		}
	}
</script>
</html>