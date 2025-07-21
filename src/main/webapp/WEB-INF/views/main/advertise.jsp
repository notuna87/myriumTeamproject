<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css"/>
</head>
<body>
	<div>
		<div class="advertiseWrap">
			<div style="background-image: url('<c:url value="/resources/img/advertise/coupon.jpg"/>');">
				<p>신규회원 가입시,</p>
				<h2>30,000원 쿠폰팩 증정</h2>
			</div>
			<div style="background-image: url('<c:url value="/resources/img/advertise/kakaochanel.png"/>');">
				<p>카카오톡 채널 추가하면</p>
				<h2>3,000원 쿠폰 지급</h2>
			</div>
		</div>
	</div>
</body>
</html>