<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
<title></title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<!-- reset css  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>

<body>
	<div class="detailWrap">
		<!-- 썸네일 Swiper -->
		<div class="swiper gallery-thumbs">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img class="miniSlider" src="${pageContext.request.contextPath}/upload/${thumbnail.img_path}" alt="title" style="width: 100%; height: 97px; border-radius: 10px;" />
				</div>
				<c:forEach var="item" items="${productSliderImg}">
					<div class="swiper-slide">
						<img class="miniSlider" src="${pageContext.request.contextPath}/upload/${item.img_path}" alt="title" style="width: 100%; height: 97px; border-radius: 10px;" />
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- 메인 Swiper -->
		<div class="swiper gallery-top">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img src="${pageContext.request.contextPath}/upload/${thumbnail.img_path}" alt="title" style="width: 100%; border-radius: 10px;" />
				</div>
				<c:forEach var="item" items="${productSliderImg}">
					<div class="swiper-slide">
						<img src="${pageContext.request.contextPath}/upload/${item.img_path}" alt="title" style="width: 100%; border-radius: 10px;" />
					</div>
				</c:forEach>
			</div>

			<!-- 네비게이션 -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>

		<!-- 상품 설명 -->
		<div class="productDescription">
			<h3>${product.product_name}</h3>
			<p class="detailContent">${product.product_content}</p>
			<c:if test="${product.total_discountrate != 0}">
				<p>
					<s><fmt:formatNumber value="${product.product_price}" type="number" />원</s>
				</p>
				<h2>
					<span style="color: red; margin-right: 10px;">${product.total_discountrate}%</span>
					<fmt:formatNumber value="${product.discount_price}" type="number" />
					원
				</h2>
			</c:if>
			<c:if test="${product.total_discountrate == 0}">
				<h2>
					<fmt:formatNumber value="${product.product_price}" type="number" />
					원
				</h2>
			</c:if>
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
				<div class="creaseButtonWrap">
					<p style="width: 100%;">${product.product_name}</p>
					<div class="creaseButton">
						<button type="button" onclick="decreaseQty()">-</button>
						<input type="number" name="quantity" id="quantity" value="1" min="1" readonly />
						<button type="button" onclick="increaseQty()">+</button>
					</div>
				</div>

				<p style="margin-bottom: 20px;">
					총 구매 금액 <span id="totalPrice" style="float: right; font-size: 22px; font-weight: bold; color: #e32e15;"> 원 </span>
				</p>
			<c:if test="${product.product_stock <= 0}">
				<button class="purchase OutOfStock">품절된 상품입니다.</button>
			</c:if>
			<c:if test="${product.product_stock > 0}">
				<sec:authorize access="!isAuthenticated()">
					<button type="button" class="inCart" id="cartLinkNotLoggedInSub">장바구니</button>
					<button type="button" class="purchase" id="purchaseLinkNotLogged">구매하기</button>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form action="/cart" method="post">
						<input type="hidden" name="quantityCartHidden" id="quantityCartHidden" value="1" min="1" readonly />
						<input type="hidden" id="productIdHidden" name="productId" value="${product.id}">
						<input type="hidden" name="productStock" value="${product.product_stock}">
						<button type="submit" class="inCart">장바구니</button>
					</form>
					<form action="/purchasedirect" method="post">
						<input type="hidden" id="productIdHiddenpruchase" name="productId" value="${product.id}">
						<input type="hidden" name="quantityPurchaseHidden" id="quantityPurchaseHidden" value="1" min="1" readonly />
						<button type="submit" class="purchase">구매하기</button>
					</form>
				</sec:authorize>
			</c:if>

		</div>
	</div>


	<!-- Swiper JS -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
	<script>
		// swiper JS
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

		// 서버에서 넘어온 할인 가격을 JS에서 사용
		const discountPrice = ${product.discount_price};
		const productPrice = ${product.product_price};
		const qtyInput = document.getElementById("quantity");
		const totalPriceSpan = document.getElementById("totalPrice");
	    const productStock = ${product.product_stock};


		function updateNotSaleTotalPrice() {
			const qty = parseInt(qtyInput.value);
			const total = productPrice * qty;
			totalPriceSpan.textContent = total.toLocaleString() + " 원";
		}

		function updateTotalPrice() {
			const qty = parseInt(qtyInput.value);
			const total = discountPrice * qty;
			totalPriceSpan.textContent = total.toLocaleString() + " 원";
		}

		if (discountPrice == 0) {
			document.addEventListener("DOMContentLoaded",
					updateNotSaleTotalPrice);
		} else {
			document.addEventListener("DOMContentLoaded", updateTotalPrice);
		}

		// 장바구니 담기용 증감 버튼
		function increaseQty() {
			const qtyInput = document.getElementById("quantity");
			const qtycartHidden = document.getElementById("quantityCartHidden");
			const qtypurchaseHidden = document.getElementById("quantityPurchaseHidden");
			
	        if (parseInt(qtyInput.value) < productStock) {
				qtyInput.value = parseInt(qtyInput.value) + 1;
				if (qtycartHidden)
					qtycartHidden.value = qtyInput.value;
				if (qtypurchaseHidden)
					qtypurchaseHidden.value = qtyInput.value;

				// 총 구매 금액 업데이트
				if (discountPrice == 0) {
					updateNotSaleTotalPrice();
				} else {
					updateTotalPrice();
				}
	        } else {
	        	alert("재고가 부족합니다.");
	        }
		}

		function decreaseQty() {
			const qtyInput = document.getElementById("quantity");
			const qtycartHidden = document.getElementById("quantityCartHidden");
			const qtypurchaseHidden = document
					.getElementById("quantityPurchaseHidden");
			if (parseInt(qtyInput.value) > 1) {
				qtyInput.value = parseInt(qtyInput.value) - 1;
				if (qtycartHidden)
					qtycartHidden.value = qtyInput.value;
				if (qtypurchaseHidden)
					qtypurchaseHidden.value = qtyInput.value;

				// 총 구매 금액 업데이트
				if (discountPrice == 0) {
					updateNotSaleTotalPrice();
				} else {
					updateTotalPrice();
				}
			}
		}

		// 로그인 확인
		document.addEventListener("DOMContentLoaded", function() {
			const cartLink = document.getElementById('cartLinkNotLoggedInSub');
			const purchaseLink = document
					.getElementById('purchaseLinkNotLogged');

			if (cartLink) {
				cartLink.addEventListener('click', function(e) {
					e.preventDefault();
					console.log("카트 로그인");
					alert("로그인 후 이용해주세요.");
					location.href = "${pageContext.request.contextPath}/login";

				});
			}
			if (purchaseLink) {
				purchaseLink.addEventListener('click', function(e) {
					e.preventDefault();
					console.log("구매 로그인");
					alert("로그인 후 이용해주세요.");

					location.href = "${pageContext.request.contextPath}/login";
				});
			}

		});
	</script>
</body>
</html>
