<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<!-- Swiper CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

	<style>
.topAdSwiper {
	width: 100%;
	height: 40px;
	font-size: 14px;
	text-align: center;
	background-color: #56b770;
	overflow: hidden;
}

.topAdSwiper .swiper-slide a {
	color: #fff;
	font-weight: bold;
	text-decoration: none;
}
</style>

	<!-- HTML -->
	<div class="swiper topAdSwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a href="#">📸 사진리뷰 쓰고, 1,000원 받아가세요!</a>
			</div>
			<div class="swiper-slide">
				<a href="#">123</a>
			</div>
		</div>
	</div>

	<!-- Swiper JS -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
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
