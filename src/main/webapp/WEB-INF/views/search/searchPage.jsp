<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<div class="searchInput">
					<input type="text" class="searchInputBox">
					<img src="${pageContext.request.contextPath}/resources/img/button/ico_search.svg" alt="">
				</div>
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
			<c:forEach begin="0" end="7">
				<div class="searchProduct">
					<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfsEsk2azXHAyj92XeY0txyj4S5PMbPQM-RA&s" alt="임시" style="margin-bottom: 12px;" />
					<h4>몰티즈</h4>
					<p class="searchProductContent">자기가 귀여운걸 아는 몰티즈</p>
					<p class="SearchOriginalPrice" style="margin-top: 8px">10원</p>
					<p class="SearchPrice">
						<span style="color: #e32e15; margin-right: 5px;">5%</span> 3000원
					</p>
					<!-- 타임세일 중일 경우 하단에 출력 -->
					<p class="timesaleOntext">🕙타임세일중인 상품입니다.</p>
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