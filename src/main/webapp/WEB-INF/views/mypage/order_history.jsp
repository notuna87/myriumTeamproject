<%@ page contentType="text/html; charset=UTF-8" %>

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
			  <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;" class="logout-form">
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
        <button class="tab active" data-tab="order">주문내역조회 (1)</button>
        <button class="tab" data-tab="cancel">취소/반품/교환 내역 (0)</button>
      </div>

      <!-- 주문내역 탭 -->
      <div class="tab-content active" id="order">
        <div class="order-guide-text">
          <p>- 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 주문처리완료 후 36개월 이내의 주문내역을 조회하실 수 있습니다.</p>
          <p>- 취소/교환/반품 신청은 배송완료일 기준 7일까지 가능합니다.</p>
        </div>

        <div class="order-box">
          <div class="order-header">
            <div class="order-date">
              <strong>2025-07-17</strong> <span>(20250717-0000041)</span>
            </div>
          </div>

          <div class="order-content">
            <img src="${pageContext.request.contextPath}/resources/img/mypage/eco-cup.jpg" alt="상품 이미지" class="product-img">
            <div class="product-info">
              <p class="product-title">집에서 스위트바질 식용바질 씨앗 키우기 에코컵</p>
              <p class="product-price">4,800원 (1개)</p>
              <small class="product-option">[옵션: 1. 에코_스위트바질]</small>
            </div>
          </div>

          <div class="order-status">
            <p class="status">배송완료</p>
            <div class="status-buttons">
              <button>배송조회</button>
              <button>구매후기</button>
              <button class="confirm-btn">구매확정</button>
            </div>
          </div>

          <div class="exchange-buttons">
            <button>교환신청</button>
            <button>반품신청</button>
          </div>
        </div>

        <div class="pagination">
          <button>&lt;</button>
          <button class="active">1</button>
          <button>&gt;</button>
        </div>
      </div>

      <!-- 취소/반품/교환 탭 -->
      <div class="tab-content" id="cancel">
        <div class="order-guide-text">
          <p>- 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 주문처리완료 후 36개월 이내의 주문내역을 조회하실 수 있습니다.</p>
          <p>- 취소/교환/반품 신청은 배송완료일 기준 7일까지 가능합니다.</p>
        </div>

        <div class="order-box">
          <div class="order-header">
            <div class="order-date">
              <strong>2025-07-17</strong> <span>(20250717-0000041)</span>
            </div>
            <a href="#" class="detail-link">상세보기 &gt;</a>
          </div>

          <div class="order-content">
            <img src="${pageContext.request.contextPath}/resources/img/mypage/eco-cup.jpg" alt="상품 이미지" class="product-img">
            <div class="product-info">
              <p class="product-title">집에서 스위트바질 식용바질 씨앗 키우기 에코컵</p>
              <p class="product-price">4,800원 (1개)</p>
              <small class="product-option">[옵션: 1. 에코_스위트바질]</small>
            </div>
          </div>

          <div class="order-status">
            <p class="status">환불완료</p>
            <div class="status-buttons">
              <button>환불영수증</button>
              <button class="confirm-btn">환불확인</button>
            </div>
          </div>
        </div>

        <div class="pagination">
          <button>&lt;</button>
          <button class="active">1</button>
          <button>&gt;</button>
        </div>
      </div>
    </div> <!-- /order-container -->
  </div> <!-- /mypage-layout -->
 <%@ include file="/WEB-INF/views/main/footer.jsp" %>


  <script> const ctx = "${pageContext.request.contextPath}"; </script>
  <script src="${pageContext.request.contextPath}/resources/js/order_history.js"></script>

</body>
</html>
