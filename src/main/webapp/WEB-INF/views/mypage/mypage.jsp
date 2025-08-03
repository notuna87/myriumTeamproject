<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>마이 쇼핑</title>
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
	

</head>
<body>


  <%@ include file="../main/header.jsp" %>

  <div class="mypage-container">
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
			  <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;" class="logout-form">
			    <button type="submit" class="logout-btn">로그아웃</button>
			  </form>
			</li>
        </ul>
      </div>
      <button class="inquiry-btn">1:1 문의하기</button>
    </aside>


    <main class="content">
      <div class="top-info">
        <div class="info-box">
          <img src="${pageContext.request.contextPath}/resources/img/mypage/person.png" alt="회원등급 아이콘" class="info-icon"/>
          씨앗친구<br><span>회원등급</span>
        </div>
        <div class="info-box">
          <img src="${pageContext.request.contextPath}/resources/img/mypage/won.png" alt="적립금 아이콘" class="info-icon"/>
          2,000원<br><span>총적립금</span>
        </div>
        <div class="info-box">
          <img src="${pageContext.request.contextPath}/resources/img/mypage/coupon.png" alt="쿠폰 아이콘" class="info-icon"/>
          4개<br><span>쿠폰</span>
        </div>
        <div class="info-box">
        <img src="${pageContext.request.contextPath}/resources/img/mypage/check.png" alt="총주문 아이콘" class="info-icon"/>
         <fmt:formatNumber value="${totalPaidAmount}" type="number" />원<span>총주문</span>
        </div>
      </div>
      
      <c:set var="statusMap" value="${orderStatusMap}" />
<section class="order-status-section">
  <h3 class="order-status-title">
    나의 주문처리 현황 <span class="subtitle">(최근 3개월 기준)</span>
  </h3>

					<div class="status-grid">
						<div class="status-step">
							<div class="count">
								<c:out value="${statusMap['입금전']}" default="0" />
							</div>
							<div class="label">입금전</div>
						</div>
						<div class="arrow">&gt;</div>
						<div class="status-step">
							<div class="count">
								<c:out value="${statusMap['배송준비중']}" default="0" />
							</div>
							<div class="label">배송준비중</div>
						</div>
						<div class="arrow">&gt;</div>
						<div class="status-step">
							<div class="count">
								<c:out value="${statusMap['배송중']}" default="0" />
							</div>
							<div class="label">배송중</div>
						</div>
						<div class="arrow">&gt;</div>
						<div class="status-step">
							<div class="count">
								<c:out value="${statusMap['배송완료']}" default="0" />
							</div>
							<div class="label">배송완료</div>
						</div>
					</div>
				</section>

   <section class="order-history">
  <h3>주문내역 조회</h3>

  <c:choose>
    <c:when test="${not empty groupedOrders}">
      <c:forEach var="entry" items="${groupedOrders}">
        <c:set var="ordersId" value="${entry.key}" />
        <c:set var="orders" value="${entry.value}" />
        <c:set var="firstOrder" value="${orders[0]}" />

        <div class="order-box">
          <!-- 주문 헤더 -->
          <div class="order-header">
  <div class="order-date">
    <strong>${firstOrder.orderDate}</strong>
    <span>(${firstOrder.orderDisplayId})</span>
  </div>
  <a href="${pageContext.request.contextPath}/mypage/order_detail?orderId=${ordersId}" class="detail-link">상세보기 &gt;</a>
</div>

          <!-- 주문 상품들 -->
          <c:forEach var="order" items="${orders}">
            <div class="order-content">
              <img src="${pageContext.request.contextPath}/resources/img/mypage/eco-cup.jpg" alt="상품 이미지" class="product-img">
              <div class="product-info">
                <p class="product-title">${order.productName}</p>
                <p class="product-price">
                  <fmt:formatNumber value="${order.productPrice}" pattern="#,###" />원 (${order.quantity}개)
                </p>
              </div>
            </div>
          </c:forEach>

          <!--주문 상태 바-->
          <div class="order-status-bar">
            <div class="status-text">${orders[0].orderStatus}</div>
            <div class="status-buttons">
              <button class="order-btn">배송조회</button>
              <button class="order-btn">구매후기</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </c:when>

    <c:otherwise>
      <p>주문 내역이 없습니다.</p>
    </c:otherwise>
  </c:choose>
</section>

    </main>
  </div>
   <%@ include file="/WEB-INF/views/main/footer.jsp" %>
</body>
</html>
