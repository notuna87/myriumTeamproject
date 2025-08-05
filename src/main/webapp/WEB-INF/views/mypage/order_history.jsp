<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>주문조회</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/order_history.css" />
</head>
<body>

<%@ include file="../main/header.jsp" %>

<div class="mypage-layout">
  <!-- 사이드바 -->
  <aside class="sidebar">
    <h2>My Account</h2>
    <div class="sidebar-section">
      <p>쇼핑 정보</p>
      <ul>
        <li>주문내역 조회</li>
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
          <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
            <button type="submit" class="logout-btn">로그아웃</button>
          </form>
        </li>
      </ul>
    </div>
    <button class="inquiry-btn">1:1 문의하기</button>
  </aside>

  <!-- 주문조회 본문 -->
  <div class="order-container">
    <h2>주문조회</h2>

    <div class="tab-menu">
      <button class="tab active" data-tab="order">주문내역조회 (${orderCount})</button>
		<button class="tab" data-tab="cancel">취소/반품/교환 내역 (${cancelCount})</button>
    </div>

    <!-- 주문내역 탭 -->
    <div class="tab-content active" id="order">
      <div class="order-guide-text">
        <p>- 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 주문처리완료 후 36개월 이내의 주문내역을 조회하실 수 있습니다.</p>
        <p>- 취소/교환/반품 신청은 배송완료일 기준 7일까지 가능합니다.</p>
      </div>
	
	<c:choose>
	  <c:when test="${empty groupedOrders}">
	    <div class="empty-msg">주문 내역이 없습니다.</div>
	  </c:when>
	  <c:otherwise>
	    <c:forEach var="entry" items="${groupedOrders}">
	      <c:set var="ordersId" value="${entry.key}" />
	      <c:set var="orders" value="${entry.value}" />
	
	      <div class="order-box">
	        <!-- 주문 상단 정보 -->
	        <div class="order-header">
	          <div class="order-date">
	            <strong>${orders[0].orderDate}</strong> <span>(${orders[0].ordersIdfull})</span>
	          </div>
	       <a href="${pageContext.request.contextPath}/mypage/order_detail?orderId=${orders[0].id}" class="detail-link">상세보기 &gt;</a>
	        </div>
	
	        <!-- 상품 목록 -->
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
	
	        <!-- 주문 상태 및 버튼 -->
			<div class="order-status">
			  <p class="status">${orders[0].orderStatusText}</p>
			  <div class="status-buttons">
			  	<button>구매후기</button>
			  	<!--  <button class="confirm-btn">구매후기</button>-->
			    <button onclick="submitRequest('exchange', ${order.id}, ${order.productId})">교환신청</button>
			    <button onclick="submitRequest('refund', ${orders[0].id}, ${orders[0].productId})">환불신청</button>
			  </div>
			</div>
	      </div>
	    </c:forEach>
	  </c:otherwise>
	</c:choose>
    </div> <!-- /tab-content#order -->
    
    <!-- 취소/반품/교환 탭 -->
    <div class="tab-content" id="cancel">
      <div class="order-guide-text">
        <p>- 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 주문처리완료 후 36개월 이내의 주문내역을 조회하실 수 있습니다.</p>
        <p>- 취소/교환/반품 신청은 배송완료일 기준 7일까지 가능합니다.</p>
      </div>
	
		<c:choose>
	  <c:when test="${empty cancelGroupedOrders}">
	    <div class="empty-msg">취소/반품/교환 내역이 없습니다.</div>
	  </c:when>
	  <c:otherwise>
	    <c:forEach var="entry" items="${cancelGroupedOrders}">
	      <c:set var="ordersId" value="${entry.key}" />
	      <c:set var="orders" value="${entry.value}" />
	
	      <div class="order-box">
	        <!-- 주문 정보 상단 -->
	        <div class="order-header">
	          <div class="order-date">
	            <strong>${orders[0].orderDate}</strong> <span>(${orders[0].orderDisplayId})</span>
	          </div>
	          <a href="${pageContext.request.contextPath}/mypage/order_detail?orderId=${orders[0].id}&productId=${orders[0].productId}">상세보기 &gt;</a>
	        </div>
	
	        <!-- 상품 목록 -->
	        <c:forEach var="order" items="${orders}">
	          <div class="order-content">
	            <img src="${pageContext.request.contextPath}/resources/img/mypage/eco-cup.jpg" alt="상품 이미지" class="product-img" />
	            <div class="product-info">
	              <p class="product-title">${order.productName}</p>
	              <p class="product-price">
	                <fmt:formatNumber value="${order.productPrice}" pattern="#,###" />원 (${order.quantity}개)
	              </p>
	            </div>
	          </div>
	        </c:forEach>
	
	        <!-- 주문별 상태 및 버튼 -->
	        <div class="order-status">
	          <p class="status">${orders[0].orderStatusText}</p>
	          <div class="status-buttons">
	            <button>환불영수증</button>
	            <button class="confirm-btn">환불확인</button>
	          </div>
	        </div>
	      </div>
	    </c:forEach>
	  </c:otherwise>
	</c:choose>
    </div> <!-- /tab-content#cancel -->

	<div id="pagination-wrapper">
	  <div class="pagination" id="pagination-content">
	    <!-- 기본은 주문 탭용 -->
	    <button>&lt;</button>
	    <button class="active">1</button>
	    <button>&gt;</button>
	  </div>
	</div>
	<c:out value="${orders[0].id}" default="id 없음" />
<c:out value="${orders[0].productId}" default="productId 없음" />
  </div> <!-- /order-container -->
</div> <!-- /mypage-layout -->



<%@ include file="/WEB-INF/views/main/footer.jsp" %>

<script> const ctx = "${pageContext.request.contextPath}"; </script>
<script src="${pageContext.request.contextPath}/resources/js/order_history.js"></script>

<script>
const paginationHTML = {
		  order: `
		    <button>&lt;</button>
		    <button class="active">1</button>
		    <button>&gt;</button>
		  `,
		  cancel: `
		    <button>&lt;</button>
		    <button class="active">1</button>
		    <button>&gt;</button>
		  `
		};

		document.querySelectorAll('.tab').forEach(btn => {
		  btn.addEventListener('click', () => {
		    const targetTab = btn.dataset.tab;

		    // 탭 콘텐츠 전환
		    document.querySelectorAll('.tab-content').forEach(tab => {
		      tab.classList.remove('active');
		    });
		    document.getElementById(targetTab).classList.add('active');

		    // 탭 버튼 전환
		    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
		    btn.classList.add('active');

		    // 페이징 갱신
		    document.getElementById('pagination-content').innerHTML = paginationHTML[targetTab];
		  });
		});
		
		//환불,교환처리
function submitRequest(type, orderId, productId) {
  const url = `${ctx}/mypage/request-${type}`;
  const payload = {
    orderId: orderId,
    productId: productId
  };

  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
  .then(res => res.json())
  .then(data => {
    if (data.success) {
    alert((type === 'refund' ? '환불' : '교환') + ' 신청이 완료되었습니다.');
      location.reload(); // 새로고침으로 상태 갱신
    } else {
      alert(data.message || '처리 중 오류가 발생했습니다.');
    }
  })
  .catch(err => {
    console.error(err);
    alert('요청 처리 중 오류가 발생했습니다.');
  });
}
</script>
</body>
</html>
