<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리움</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/categoryPage.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/main/header.jsp"%>

	<div class="categorywrap">
		<!-- 상단 카테고리 선택 시작 -->
		<div class="categorySelectBoxWrapper">
			<h2 class="categoryTitle">원예용품</h2>
		</div>

		<!-- 카테고리 버튼 시작 -->
		<form></form>
		<div class="categoryButtonWrap">
			<button class="categoryButton select">전체</button>
			<button class="categoryButton">원예용품</button>
			<button class="categoryButton">식물키트모음</button>
			<button class="categoryButton">허브키우기</button>
			<button class="categoryButton">채소키우기</button>
			<button class="categoryButton">꽃씨키우기</button>
			<button class="categoryButton">기타키우기</button>
		</div>
		<!-- 카테고리 버튼 끝 -->
		<!-- 상단 카테고리 선택 끝 -->
		<!-- 하단 상품 카운트 및 정렬 시작 -->
		<div class="searchResultWrap">
			<p class="countItems">
				<span style="font-weight: 500;">8</span> items
			</p>
			<select class="orderBy">
				<option>::: 기준선택 :::</option>
				<option>신상품</option>
				<option>상품명</option>
				<option>낮은가격</option>
				<option>높은가격</option>
				<option>사용후기</option>
			</select>
		</div>
		<!-- 하단 상품 카운트 및 정렬 끝 -->
		<!-- 상품 목록 시작 -->
		<div class="categoryResultWrap">
			<c:forEach begin="0" end="12">
				<div class="categoryResult">
					<div class="categoryResultProduct" onclick="location.href='sub?id=${item.product.id}'">
						<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1IkKprzgGrvEA-K8FzOc0rv70rdR4re_AyPa1nmVFmkWNuq605A92tw5k4vzNbjgvjKU&usqp=CAU" alt="임시" style="margin-bottom: 12px;" />
						<h4>이름</h4>
						<p class="mainProductContent">설명</p>

						<!-- 할인중인 가격이 null 값일 때 판매가만 출력 -->
						<c:if test="${item.product.total_discountrate == 0}">
							<p class="salePrice" style="margin-top: 8px">
								<fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />
								원가 원
							</p>
						</c:if>

						<!-- 할인중일때 원가, 할인율, 할인가 출력 -->
						<c:if test="${item.product.total_discountrate != 0}">
							<p class="originalPrice">
								<s> <fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />할인 원
								</s>
							</p>
							<p class="salePrice">
								<span style="color: #e32e15; margin-right: 5px; font-size: 15px;">토탈 할인율 %</span>
								<fmt:formatNumber value="${item.product.discount_price}" type="number" groupingUsed="true" />
								최종 가격 원
							</p>
						</c:if>
						<!-- 타임세일 중일 경우 하단에 출력 -->
						<c:if test="${item.product.is_timesales == 1}">
							<p class="timesaleOntext">🕙타임세일중인 상품입니다 지금 쟁여두세요!</p>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
		<!-- 더보기 버튼 -->
		<button id="moreBtn" class="categoryMore" onclick="loadMore()">상품 더보기</button>
		<!-- 상품 목록 끝 -->
	</div>
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
</body>
<script>
		let visibleCount = 4;

		function loadMore() {
			const products = document.querySelectorAll(".categoryResult");
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
			const products = document.querySelectorAll(".categoryResult");
			products.forEach((p, i) => {
				if (i >= 8) p.style.display = "none";
			});
		}
		
		  document.querySelectorAll('.categoryButton').forEach(button => {
			    button.addEventListener('click', function() {
			      // 모든 버튼에서 select 제거
			      document.querySelectorAll('.categoryButton').forEach(btn => {
			        btn.classList.remove('select');
			      });
			      // 클릭한 버튼에 select 추가
			      this.classList.add('select');
			    });
			  });
	</script>

</html>