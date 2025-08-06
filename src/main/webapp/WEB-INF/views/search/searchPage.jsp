<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리움</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/searchPage.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/main/topad.jsp"%>
	<%@ include file="/WEB-INF/views/main/header.jsp"%>

	<div class="searchWrap">
		<!-- 상단 서치 박스 시작 -->
		<div class="searchPageBoxWrap">
			<div class="titleArea">
				<p class="searchTitle">SEARCH</p>
			</div>
			<div class="searchField">
				<form id="searchForm" action="/search" method="post">
					<div class="searchInput">
						<input type="text" class="searchInputBox" name="productSearch" value="${searchKeyword}">
						<img onclick="document.getElementById('searchForm').submit();" src="${pageContext.request.contextPath}/resources/img/button/ico_search.svg" alt="ico_search">
					</div>
				</form>
			</div>
		</div>
		<!-- 상단 서치 박스 끝 -->
		<!-- 하단 검색 결과 카운트 및 정렬 시작 -->
		<div class="searchResult">
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
		<!-- 하단 검색 결과 카운트 및 정렬 끝 -->
		<!-- 하단 상품 결과 시작 -->
		<div class="productWrap">
			<c:forEach var="item" items="${searchProductList}">
				<div class="searchProduct" onclick="location.href='${pageContext.request.contextPath}/sub?id=${item.product.id}'">
					<img src="${pageContext.request.contextPath}/resources/img/${item.thumbnail.img_path}" alt="${item.product.product_name}" style="margin-bottom: 12px;" />
					<h4>${item.product.product_name}</h4>
					<p class="searchProductContent">${item.product.product_content}</p>
					<c:if test="${item.product.discount_price != 0}">
						<p class="SearchOriginalPrice" style="margin-top: 8px">
							<fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />
							원
						</p>
						<p class="SearchPrice">
							<span style="color: #e32e15; margin-right: 5px;">${item.product.total_discountrate}%</span>
							<fmt:formatNumber value="${item.product.discount_price}" type="number" groupingUsed="true" />
							원
						</p>
					</c:if>
					<c:if test="${item.product.discount_price == 0}">
						<p class="SearchPrice" style="margin-top : 15px;">
							<fmt:formatNumber value="${item.product.product_price}" type="number" groupingUsed="true" />
							원
						</p>
					</c:if>
					<!-- 타임세일 중일 경우 하단에 출력 -->
					<c:if test="${item.product.is_timesales == 1}">
						<p class="timesaleOntext">🕙타임세일중인 상품입니다.</p>
					</c:if>
				</div>
			</c:forEach>
		</div>
		<!-- 하단 상품 결과 끝 -->
		<!-- 페이징 버튼 시작 -->
		<div class="pagingButtonWrap">
			<a href="#" class="first"></a> <a href="#" class="prev"></a>
			<ul>
				<li><a href="#">1</a></li>
			</ul>
			<a href="#" class="next"></a> <a href="#" class="last"></a>
		</div>
		<!-- 페이징 버튼 끝 -->
	</div>
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</body>
</html>