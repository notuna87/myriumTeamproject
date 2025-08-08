<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
						<button type="submit" class="searchIcon" style="background: none; border: none; padding: 0;">
							<img style="transform: translate(-4px, -2px);" src="${pageContext.request.contextPath}/resources/img/logo/icon_search.svg" alt="search_icon">
						</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 상단 서치 박스 끝 -->
		<!-- 하단 검색 결과 카운트 및 정렬 시작 -->
		<div class="searchResult">
			<p class="countItems">
				<span style="font-weight: 500;">${searchResultCount}</span> items
			</p>
			<form id="sortForm" action="/search/result" method="get">
			<input type="text" value="${searchKeyword}" name="searchKeyword">
				<select name="sort" class="orderBy" onchange="document.getElementById('sortForm').submit();">
					<option value="">::: 기준선택 :::</option>
					<option value="new">신상품</option>
					<option value="name">상품명</option>
					<option value="lowPrice">낮은가격</option>
					<option value="highPrice">높은가격</option>
					<option value="review">사용후기</option>
				</select>
			</form>
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
						<p class="SearchPrice" style="margin-top: 15px;">
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
		<div class="pagingButtonWrap paginate_button">
			<a href="1" class="first"></a>
			<c:if test="${pageMaker.cri.pageNum != 1}">
				<a href="${pageMaker.cri.pageNum-1}" class="prev page-link"></a>
			</c:if>
			<c:if test="${pageMaker.cri.pageNum == 1}">
				<a href="1" class="prev page-link"></a>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${i == pageMaker.cri.pageNum}">
						<ul class="active">
							<li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active': ''}"><a href="${num}">${num}</a></li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul>
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': ''}"><a href="${num}">${num}</a></li>
						</ul>
					</c:otherwise>
				</c:choose>

			</c:forEach>

			<c:if test="${pageMaker.endPage != pageMaker.endPage}">
				<a href="${pageMaker.cri.pageNum+1}" class="next page-link"></a>
			</c:if>
			<c:if test="${pageMaker.endPage == pageMaker.endPage}">
				<a href="${pageMaker.endPage}" class="next page-link"></a>
			</c:if>
			<a href="${pageMaker.endPage}" class="last"></a>
		</div>
		<!-- 페이징 버튼 끝 -->
	</div>
	<form id='actionForm' action="/search/result" method='get'>
		<input type='hidden' name='searchKeyword' value='${searchKeyword}'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='sort' value='${sort}'>

	</form>
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
</body>
<script>
	$(document).ready(function() {
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			console.log("click");
			// 클릭된 요소의 href 값을 찾아서 input 폼 안의 pageNum 필드에 설정		
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	});
</script>

</html>