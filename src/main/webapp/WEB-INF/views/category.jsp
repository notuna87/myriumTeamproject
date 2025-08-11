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
		<form id="categoryForm" action="/category" method="get">
			<input type="hidden" value="${sort}" name="sort">
			<div class="categoryButtonWrap">
				<button class="categoryButton" name="category" value="all">전체</button>
				<button class="categoryButton" name="category" value="gardening">원예용품</button>
				<button class="categoryButton" name="category" value="plantKit">식물키트모음</button>
				<button class="categoryButton" name="category" value="hurb">허브키우기</button>
				<button class="categoryButton" name="category" value="vegetable">채소키우기</button>
				<button class="categoryButton" name="category" value="flower">꽃씨키우기</button>
				<button class="categoryButton" name="category" value="etc">기타키우기</button>
			</div>
		</form>
		<!-- 카테고리 버튼 끝 -->
		<!-- 상단 카테고리 선택 끝 -->
		<!-- 하단 상품 카운트 및 정렬 시작 -->
		<div class="searchResultWrap">
			<p class="countItems" style="font-size: 13px;">
				<span style="font-weight: 500;">${count}</span> items
			</p>
			<form id="sortForm" action="/category" method="get">
				<input type="hidden" value="${category}" name="category">
				<select name="sort" class="orderBy" onchange="document.getElementById('sortForm').submit();">
					<option value="" <c:if test="${sort == null || sort == ''}">selected</c:if>>::: 기준선택 :::</option>
					<option value="new" <c:if test="${sort == 'new'}">selected</c:if>>신상품</option>
					<option value="name" <c:if test="${sort == 'name'}">selected</c:if>>상품명</option>
					<option value="lowPrice" <c:if test="${sort == 'lowPrice'}">selected</c:if>>낮은가격</option>
					<option value="highPrice" <c:if test="${sort == 'highPrice'}">selected</c:if>>높은가격</option>
					<option value="review" <c:if test="${sort == 'review'}">selected</c:if>>사용후기</option>

				</select>
			</form>
		</div>
		<!-- 하단 상품 카운트 및 정렬 끝 -->
		<!-- 상품 목록 시작 -->
		<div class="categoryResultWrap">
			<c:forEach var="item" items="${product}">
				<div class="categoryResult">
					<div class="categoryResultProduct" onclick="location.href='sub?id=${item.product.id}'">
						<img src="${pageContext.request.contextPath}/upload/${item.thumbnail.img_path}" alt="${item.product.product_name}_img" style="margin-bottom: 12px;" />
						<h4>${item.product.product_name}</h4>
						<p class="mainProductContent">${item.product.product_content}</p>

						<!-- 할인중인 가격이 null 값일 때 판매가만 출력 -->
						<c:if test="${item.product.total_discountrate == 0}">
							<p class="salePrice" style="margin-top: 8px">
								<fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />
								원
							</p>
						</c:if>

						<!-- 할인중일때 원가, 할인율, 할인가 출력 -->
						<c:if test="${item.product.total_discountrate != 0}">
							<p class="originalPrice">
								<s> <fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />원</s>
							</p>
							<p class="salePrice">
								<span style="color: #e32e15; margin-right: 5px; font-size: 15px;">${item.product.total_discountrate}%</span>
								<fmt:formatNumber value="${item.product.discount_price}" type="number" groupingUsed="true" />
								원
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
		let visibleCount = 8;

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

		// 고른 버튼에 따라 select 클래스 추가
		document.addEventListener("DOMContentLoaded", function () {
		    const params = new URLSearchParams(window.location.search);
		    const categoryValue = params.get("category");

		    const buttons = document.querySelectorAll(".categoryButton");

		    buttons.forEach(btn => btn.classList.remove("select"));

		    buttons.forEach(btn => {
		        if (btn.value === (categoryValue ?? "all")) {
		            btn.classList.add("select");
		        }
		    });
		});
		
	</script>
</html>