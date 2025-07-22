<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>로그인</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" />
</head>
<body>
  <div class="wrap">
    <div class="login_wrap">
      <header class="login_header">
		<div class="icon_row">
		  <!-- 뒤로가기: 브라우저 히스토리 뒤로 이동 -->
		  <button class="back_btn" onclick="history.back();">
		    <img src="${pageContext.request.contextPath}/resources/img/login/icon_back.png" alt="뒤로가기" />
		  </button>
		
		  <!-- 홈으로 이동 -->
		  <button class="home_btn" onclick="location.href='${pageContext.request.contextPath}/home';">
		    <img src="${pageContext.request.contextPath}/resources/img/login/icon_home.png" alt="홈으로" />
		  </button>
		</div>
        <h1 class="login_title">로그인</h1>
      </header>

      <p class="login_intro">
      	로그인하면 주문내역을 확인할 수 있어요.<br />
        더 많은 기능도 함께 이용해보세요!<br />
      </p>

      <div class="coupon_banner">
        <img src="${pageContext.request.contextPath}/resources/img/login/coupon.jpg" alt="쿠폰" />
      </div>

      <div class="divider"><span>또는</span></div>

      <div class="login_tab">
        <button class="active">기존 회원</button>
        <button>비회원 배송조회</button>
      </div>

      <form class="login_form">
        <input type="text" placeholder="아이디" />
        <input type="password" placeholder="비밀번호" />

        <div class="login_option">
            <label><input type="checkbox" /> 아이디 저장</label>
            <span class="secure"><img src="${pageContext.request.contextPath}/resources/img/login/icon_lock.png" alt="보안" />보안접속</span>
          </div>

        <button type="submit" class="login_btn">로그인</button>

        <div class="login_links">
          <a href="${pageContext.request.contextPath}/login/find_id">아이디 찾기</a>
          <span>|</span>
          <a href="${pageContext.request.contextPath}/login/find_pw">비밀번호 찾기</a>
          <span>|</span>
          <a href="join.html">회원가입</a>
        </div>
      </form>

    </div>
  </div>
</body>
</html>

