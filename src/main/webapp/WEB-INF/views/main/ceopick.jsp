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
				<c:forEach var="i" begin="0" end="11">

				<div class="ceopickProduct">
					<img src="resources/img/flower/babysbreath/babysbreath_01.jpg" alt="임시" />
					<h4>임시</h4>
					<p class="ceopickConten">임시</p>
					<p class="originalPric">
						임시 원</s>
					</p>
					<p class="ceosalePrice">
						<span style="color: #e32e15; margin-right: 5px;">임시 %</span>
					</p>
				</div>
				</c:forEach>
			</div>

			<!-- 더보기 버튼 -->
			<button id="moreBtn" class="ceoMore" onclick="loadMore()">상품 더보기</button>
		</div>
	</div>
</body>
</html>
