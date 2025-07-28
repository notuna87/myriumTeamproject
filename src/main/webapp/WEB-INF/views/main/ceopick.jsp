<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>사장님's PICK</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css" />
<style>
/* 기본 스타일은 필요한 만큼 추가 가능 */
.ceopickProduct {
	cursor: pointer;
}

.ceoMore {
	margin-top: 20px;
}

.timesaleOntext {
	color: #555;
	font-size: 13px;
}
</style>
<script>
		let visibleCount = 4;

		function loadMore() {
			const products = document.querySelectorAll(".ceopickProduct");
			const total = products.length;

			for (let i = visibleCount; i < visibleCount + 4 && i < total; i++) {
				products[i].style.display = "block";
			}

			visibleCount += 4;
			const btn = document.getElementById("moreBtn");
			if (visibleCount >= total) {
				btn.style.display = "none";
			}

		}

		window.onload = function () {
			const products = document.querySelectorAll(".ceopickProduct");
			products.forEach((p, i) => {
				if (i >= 4) p.style.display = "none";
			});
		}
	</script>
</head>
<body>
	<div class="ceopickWrap">
		<div class="ceopick">
			<h2>👩‍🌾사장님's PICK</h2>
			<p>놓치면 후회!</p>
			<div class="ceopickProductwrap">
				<c:forEach var="item" items="${ceopickList}">
					<div class="ceopickProduct" onclick="location.href='sub?id=${item.product.id}'">
						<img src="resources/img/${item.thumbnail.img_path}" alt="임시" style="margin-bottom: 12px;" />
						<h4>${item.product.product_name}</h4>
						<p class="mainProductContent">${item.product.product_content}</p>
						
						<!-- 할인중인 가격이 null 값일 때 판매가만 출력 -->
						<c:if test="${item.product.discount_price == 0}">
							<p class="ceosalePrice" style="margin-top:8px"><fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />원</p>		
						</c:if>
						
						<!-- 할인중일때 원가, 할인율, 할인가 출력 -->
						<c:if test="${item.product.discount_price != 0}">
							<p class="originalPrice">
								<s><fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />원</s>
							</p>
							<p class="ceosalePrice">
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

			<!-- 더보기 버튼 -->
			<button id="moreBtn" class="ceoMore" onclick="loadMore()">상품 더보기</button>
		</div>
	</div>
</body>
</html>
