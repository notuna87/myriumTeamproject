<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<title>${product.title}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<style>
.detailWrap {
	display: flex;
	gap: 20px;
	padding: 40px;
}

.swiper-container {
	border-radius: 10px;
	overflow: hidden;
}

.gallery-thumbs {
	width: 100px;
	height: 520px;
}

.gallery-top {
	width: 520px;
	height: 520px;
}

.gallery-top img, .gallery-thumbs img {
	width: 100%;
	display: block;
}

.productDescription {
	flex: 1;
	padding-left: 40px;
}

.detailKakao, .parcel {
	display: flex;
	align-items: center;
	margin-top: 20px;
}

.detailKakao img, .parcel img {
	margin-right: 10px;
}
</style>
</head>

<body>
	<div class="detailWrap">
		<!-- 썸네일 Swiper -->
		<div class="swiper gallery-thumbs">
			<div class="swiper-wrapper">
				<c:forEach var="i" begin="1" end="6">
					<div class="swiper-slide">
						<img src="/resources/img/flower/cosmos/cosmos_0${i}.jpg" alt="title" />
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- 메인 Swiper -->
		<div class="swiper gallery-top">
			<div class="swiper-wrapper">
				<c:forEach var="i" begin="1" end="6">
					<div class="swiper-slide">
						<img src="/resources/img/flower/cosmos/cosmos_0${i}.jpg" alt="title" />
					</div>
				</c:forEach>
			</div>

			<!-- 네비게이션 -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>

		<!-- 상품 설명 -->
		<div class="productDescription">
			<h3>상품 임시 제목</h3>
			<p>상품 임시 컨텐츠</p>

			<p>
				<s><fmt:formatNumber value="3000" type="number" />원</s>
			</p>
			<h2>
				<span style="color: red; margin-right: 10px;">10%</span>
				<fmt:formatNumber value="3000" type="number" />
				원
			</h2>

			<div class="detailKakao">
				<img src="/resources/img/logo/kakaotalk.png" alt="kakao" />
				<p>
					카카오톡 채널 추가하고 <strong>할인쿠폰</strong> 받기
				</p>
			</div>

			<table style="margin-top: 20px;">
				<tr>
					<td>배송비</td>
					<td>3,000원 (49,900원 이상 무료)</td>
				</tr>
				<tr>
					<td>무이자 할부</td>
					<td>카드 자세히 보기</td>
				</tr>
			</table>

			<div class="parcel">
				<img src="/resources/img/logo/parcel.JPG" alt="parcel" />
				<p>
					오늘출발 상품 <span style="font-weight: normal;">(오후 3시 전 주문 시)</span>
				</p>
			</div>

			<p style="margin-bottom: 20px;">
				총 구매 금액 <span style="float: right; font-size: 22px; font-weight: bold; color: #e32e15;"> <fmt:formatNumber value="${disPrice}" type="number" /> 원
				</span>
			</p>

			<form action="/cart/add" method="post">
				<input type="hidden" name="id" value="${product.id}" />
				<input type="hidden" name="name" value="${product.title}" />
				<input type="hidden" name="price" value="${product.price}" />
				<input type="hidden" name="discount" value="${product.discount}" />
				<input type="hidden" name="imgurl" value="${product.imgUrl[0]}" />
				<input type="hidden" name="kind" value="${product.kind}" />
				<button type="submit" class="inCart">장바구니</button>
			</form>

			<div class="purchase">구매하기</div>
		</div>
	</div>

	<!-- Swiper JS -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
	<script>
		const galleryThumbs = new Swiper('.gallery-thumbs', {
			direction : 'vertical',
			spaceBetween : 10,
			slidesPerView : 5,
			freeMode : true,
			watchSlidesProgress : true,
		});

		const galleryTop = new Swiper('.gallery-top', {
			spaceBetween : 10,
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
			thumbs : {
				swiper : galleryThumbs,
			},
		});
	</script>
</body>
</html>
