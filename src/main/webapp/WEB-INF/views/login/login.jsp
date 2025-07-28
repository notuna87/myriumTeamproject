<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/login.css" />
</head>
<body>
	<div class="wrap">
		<div class="login_wrap">
			<header class="login_header">
				<div class="icon_row">
					<button class="back_btn" onclick="history.back();">
						<img
							src="${pageContext.request.contextPath}/resources/img/login/icon_back.png"
							alt="뒤로가기" />
					</button>
					<button class="home_btn"
						onclick="location.href='${pageContext.request.contextPath}/home';">
						<img
							src="${pageContext.request.contextPath}/resources/img/login/icon_home.png"
							alt="홈으로" />
					</button>
				</div>
				<h1 class="login_title">로그인</h1>
			</header>

			<p class="login_intro">
				로그인하면 주문내역을 확인할 수 있어요.<br /> 더 많은 기능도 함께 이용해보세요!<br />
			</p>

			<div class="coupon_banner">
				<img
					src="${pageContext.request.contextPath}/resources/img/login/coupon.jpg"
					alt="쿠폰" />
			</div>

			<div class="divider">
				<span>또는</span>
			</div>

			<div class="login_tab">
				<button class="active">기존 회원</button>
				<button>비회원 배송조회</button>
			</div>

			<!-- Spring Security 로그인 폼 -->
			<form class="login_form" method="post"
				action="${pageContext.request.contextPath}/login">

				<input type="text" name="username" placeholder="아이디" /> <input
					type="password" name="password" placeholder="비밀번호" />

				<!-- 로그인 실패 시 메시지 표시 -->
				<c:if test="${not empty error}">
					<p class="error_msg"
						style="color: red; margin-bottom: 10px; font-size: 13px;">${error}</p>
				</c:if>
				<c:if test="${not empty logout}">
					<p class="success_msg"
						style="color: blue; margin-bottom: 10px; font-size: 13px;">${logout}</p>
				</c:if>

				<div class="login_option">
					<label><input type="checkbox" name="remember-me" /> 아이디 저장</label>
					<span class="secure"> <img
						src="${pageContext.request.contextPath}/resources/img/login/icon_lock.png"
						alt="보안" /> 보안접속
					</span>
				</div>

				<button type="submit" class="login_btn">로그인</button>

				<div class="login_links">
					<a href="${pageContext.request.contextPath}/login/find_id">아이디
						찾기</a> <span>|</span> <a
						href="${pageContext.request.contextPath}/login/find_pw">비밀번호
						찾기</a> <span>|</span> <a
						href="${pageContext.request.contextPath}/join">회원가입</a>
				</div>

				<!-- CSRF 토큰 삽입 -->
				<sec:csrfInput />
			</form>

		</div>
	</div>

	<c:if test="${not empty msg}">
		<script>
    alert("${msg}");
  </script>
	</c:if>

</body>
</html>
