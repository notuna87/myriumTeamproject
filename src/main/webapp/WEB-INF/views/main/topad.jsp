<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />

</head>
<body>
	<!-- 상단 광고 배너 Swiper -->
	<div class="topAdSwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide" style="width: 100%">
				<a href="#">📸 사진리뷰 쓰고, 1,000원 받아가세요!</a>
			</div>
			<div class="swiper-slide" style="width: 100%">
				<a href="#">🎉 회원 가입하고 30,000원 쿠폰팩 즉시 받기 ✨</a>
			</div>
		</div>
	</div>
	<!-- 상단 광고 Swiper 인스턴스 초기화 -->
	<script>
		new Swiper('.topAdSwiper', {
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