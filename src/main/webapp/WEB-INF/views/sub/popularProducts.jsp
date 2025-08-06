<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>다른 고객이 함께 본 상품</title>

<!-- Swiper CSS CDN -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />

<style>
.anotherCustomerWrap {
	padding: 30px;
}

.timesaleSliderIn {
	text-align: center;
	cursor: pointer;
}

.timesaleSliderIn img {
	width: 100%;
	height: auto;
	border-radius: 10px;
}

.originalPrice {
	color: #888;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="anotherCustomerWrap">
		<h3>인기가 많은 상품</h3>

		<!-- Swiper -->
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<c:forEach var="item" items="${popularProduct}">
					<div class="swiper-slide">
						<a href="sub?id=${item.product.id}">
							<div class="timesaleSliderIn">
								<img src="/resources/img/${item.thumbnail.img_path}" alt="${item.product.product_name}" />
								<h6 style="font-size: 13px;">${item.product.product_name}</h6>
								<p class="originalPrice">
									<fmt:formatNumber value="${item.product.discount_price}" type="number" groupingUsed="true" />
									원
								</p>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- Swiper JS CDN -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

	<!-- JSTL Format taglib for comma formatting -->
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<script>
		const swiper = new Swiper(".mySwiper", {
			slidesPerView : 5,
			spaceBetween : 10,
			loop : true,
			pagination : {
				el : ".swiper-pagination",
				clickable : true,
			},
		});

		function navigateToDetail(id) {
			window.location.href = '/detail/kit/' + id;
			window.scrollTo({
				top : 0,
				behavior : 'smooth'
			});
		}
	</script>
</body>
</html>
