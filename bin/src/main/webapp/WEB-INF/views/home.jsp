<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<!-- reset css  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<!-- Swiper CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
</head>
<body>
	<!-- HTML -->
	<div class="topAdSwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a href="#">📸 사진리뷰 쓰고, 1,000원 받아가세요</a>
			</div>
			<div class="swiper-slide">
				<a href="#">🎉 회원 가입하고 30,000원 쿠폰팩 즉시 받기 ✨</a>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/main/header.jsp" %>
	<script>
		const swiper = new Swiper('.topAdSwiper', {
			direction : 'vertical',
			slidesPerView : 1,
			spaceBetween : 30,
			loop : true,
			autoplay : {
				delay : 2700,
			},
		});
	</script>
</body>
</html>
