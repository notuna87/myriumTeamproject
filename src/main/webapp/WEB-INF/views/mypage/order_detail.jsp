<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/order_detail.css" />


</head>
<body>
	<%@ include file="../main/header.jsp"%>

	<div class="mypage-container">
		<!-- 사이드바 -->
		<aside class="sidebar">
			<h2>My Account</h2>
			<div class="sidebar-section">
				<p>쇼핑 정보</p>
				<ul>
					<li><a href="${pageContext.request.contextPath}/mypage/order-history">주문내역 조회</a></li>
				</ul>
			</div>
			<div class="sidebar-section">
				<p>활동 정보</p>
				<ul>
					<li>나의 게시글</li>
				</ul>
			</div>
			<div class="sidebar-section">
				<p>나의 정보</p>
				<ul>
					<li><a href="${pageContext.request.contextPath}/mypage/member_update">회원 정보 수정</a></li>
					<li><a href="${pageContext.request.contextPath}/mypage/change_password">비밀번호 변경</a></li>
					<li>
						<form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;" class="logout-form">
							<button type="submit" class="logout-btn">로그아웃</button>
						</form>
					</li>
				</ul>
			</div>
			<button class="inquiry-btn">1:1 문의하기</button>
		</aside>

		<div class="order-detail-wrap">
			<h2 class="page-title">주문상세조회</h2>


			<!-- 주문정보 -->
			<section class="section-box">
				<h3 class="section-title">주문정보</h3>
				<table class="info-table">
					<tr>
						<th>주문번호</th>
						<td>${firstOrder.ordersIdfull}</td>
					</tr>
					<tr>
						<th>주문일자</th>
						<td><c:out value="${firstOrder.orderDate}" default="날짜 없음" /></td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>${customerName}</td>
					</tr>
					<tr>
						<th>주문처리상태</th>
						<td>${orders[0].orderStatusText}</td>
					</tr>
				</table>
			</section>

			<!-- 결제정보 -->
			<section class="section-box">
				<h3 class="section-title">결제정보</h3>
				<table class="info-table">
					<tr>
						<th>총 주문금액</th>
						<td><fmt:formatNumber value="${totalAmount}" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><fmt:formatNumber value="${shippingFee}" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th>총 결제금액</th>
						<td><strong><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</strong></td>
					</tr>
					<tr>
						<th>결제수단</th>
						<td>${firstOrder.payment}<br />명세서에 이니시스(으)로 표기됩니다
						</td>
					</tr>
				</table>
			</section>

			<c:forEach var="order" items="${orders}">
				<c:if test="${order.orderStatus != '4' 
				          && order.orderStatus != '5'
				          && order.orderStatus != '6' 
				          && order.orderStatus != '7'}">
					<div class="product-box">
						<div class="product-img">
							<img src="${pageContext.request.contextPath}/upload/${order.img_path}" alt="상품 이미지" />
						</div>
						<div class="product-info">
							<p class="product-name">${order.productName}</p>
							<p class="product-price">
								<c:if test="${order.discount_price != 0}">
									<fmt:formatNumber value="${order.discount_price * order.quantity}" pattern="#,###" /> 원 (${order.quantity}개)
			        </c:if>
								<c:if test="${order.discount_price == 0}">
									<fmt:formatNumber value="${order.productPrice * order.quantity}" pattern="#,###" /> 원 (${order.quantity}개)
			        </c:if>
							</p>
							<p class="product-seller">
								한진택배<br />[123456789] / 배송: 기본배송
							</p>
						</div>
					</div>

				</c:if>
			</c:forEach>

			<!-- 구매확정 -->
			<section class="section-box">
				<div class="confirm-box">
					<p class="confirm-text">
						<strong>[기본배송]</strong><br /> 상품구매금액
						<fmt:formatNumber value="${totalAmount}" pattern="#,###" />
						원 + 배송비
						<fmt:formatNumber value="${shippingFee}" pattern="#,###" />
						원 <br /> <strong>합계 : <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
						</strong>
					</p>
				</div>
			</section>

			<!-- 배송지 정보 -->
			<section class="section-box">
				<h3 class="section-title">배송지정보</h3>
				<table class="info-table">
					<tr>
						<th>받으시는분</th>
						<td>${firstOrder.receiver}</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td>${firstOrder.zipcode}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${firstOrder.address}</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>${firstOrder.phoneNumber}</td>
					</tr>
					<tr>
						<th>배송메시지</th>
						<td>${firstOrder.deliveryMsg}</td>
					</tr>
				</table>
			</section>

			<!-- 하단 버튼 -->
			<div class="bottom-btns">
				<div class="btn-group-left">
					<button class="btn-print">거래명세서 인쇄</button>
					<button class="btn-print">카드매출전표 인쇄</button>
				</div>
				<div class="btn-group-right">
					<button class="btn-order-list" onclick="location.href='${pageContext.request.contextPath}/mypage/order-history'">주문목록보기</button>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
</body>
</html>