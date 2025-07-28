<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>미리 만나는 봄</title>
<style>
.springWrap {
	padding: 40px;
}

.springProductwrap {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.originalPrice s {
	color: gray;
}

.more {
	margin-top: 20px;
	padding: 10px 20px;
}
</style>
</head>
<body>
	<div class="springWrap">
		<div class="spring">
			<h2>미리 만나는 봄 🌱</h2>
			<p>마이리움 식물키트</p>
			<div class="springProductwrap" id="springProductwrap">
				<c:forEach var="item" items="${springList}">
					<div class="springProduct" onclick="location.href='sub?id=${item.product.id}'">
						<img src="resources/img/${item.thumbnail.img_path}" alt="1" style="width: 100%; height: auto; margin-bottom:12px;" />
						<h4>${item.product.product_name}</h4>
          
						<p class="mainProductContent">${item.product.product_content}</p>
						
						<!-- 할인중인 가격이 null 값일 때 판매가만 출력 -->
						<c:if test="${item.product.discount_price == 0}">
							<p class="salePrice" style="margin-top:5px;">
								<fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />원
							</p>
						</c:if>
						
						<!-- 할인중일때 원가, 할인율, 할인가 출력 -->
						<c:if test="${item.product.discount_price != 0}">
							<p class="originalPrice">
								<s><fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />원</s>
							</p>
							<p class="salePrice">
								<span style="color: #e32e15; margin-right: 5px;">${item.product.total_discountrate}%</span>
								<fmt:formatNumber value="${item.product.discount_price}" type="number" groupingUsed="true" />원
							</p>
						</c:if>

						<!-- 타임세일 중일 경우 하단에 출력 -->
						<c:if test="${item.product.is_timesales == 1}">
							<p class="timesaleOntext">🕙타임세일중인 상품입니다 지금 쟁여두세요!</p>
						</c:if>
					</div>
				</c:forEach>
			</div>
			<button class="more" id="springLoadMoreBtn">상품 더보기</button>
		</div>
	</div>

	<script>
		(function () {
			let springVisibleCount = 3;

			function springLoadMore() {
				const springProducts = document.querySelectorAll(".springProduct");
				const total = springProducts.length;

				for (let i = springVisibleCount; i < springVisibleCount + 3 && i < total; i++) {
					springProducts[i].style.display = "block";
				}

				springVisibleCount += 3;

				if (springVisibleCount >= total) {
					document.getElementById("springLoadMoreBtn").style.display = "none";
				}
			}

			window.addEventListener("DOMContentLoaded", function () {
				const springProducts = document.querySelectorAll(".springProduct");

				// 초기 상태: 3개만 보이게 설정
				springProducts.forEach((product, index) => {
					if (index >= 3) product.style.display = "none";
				});

				document.getElementById("springLoadMoreBtn").addEventListener("click", springLoadMore);
			});
		})();
	</script>
</body>
</html>
