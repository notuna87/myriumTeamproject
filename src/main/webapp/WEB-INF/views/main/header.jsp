<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Header</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css" />

</head>
<body>
	<div class="headerWrap">
		<div class="logo">
			<div class="logoImg">
				<a href="${pageContext.request.contextPath}/"> <img src="${pageContext.request.contextPath}/resources/img/logo/logo.png" alt="logo">
				</a>
			</div>
			<ul class="loginWrap">
				<li><a href="${pageContext.request.contextPath}/admin">관리자</a></li> <!-- admin test -->
				<li><a href="#">주문조회</a></li>
				<li><a href="#">로그인</a></li>
				<li><a href="#" class="loginWrapLastchild">회원가입</a></li>
			</ul>
		</div>

		<div class="navsearchWrap">
			<div class="navbarWrap">
				<ul>
					<li><a href="#">브랜드 소개</a></li>
					<li><a href="#">식물키우기</a></li>
					<li><a href="#">타임세일</a></li>
					<li><a href="#">리뷰</a></li>
					<li><a href="#">매거진</a></li>
					<li class="subCategoryWrap"><a href="#">고객센터</a>
						<div class="subCategory">
							<ul>
								<li><a href="#">식물백서</a></li>
								<li><a href="#">공지사항</a></li>
								<li><a href="#">문의하기</a></li>
								<li><a href="#">상품 리뷰</a></li>
								<li><a href="#">FAQ</a></li>
							</ul>
						</div></li>
					<li><a href="${pageContext.request.contextPath}/board/list">고객게시판</a></li>
				</ul>
			</div>

			<div class="searchBoxWrap">
				<fieldset class="headerFieldset">
					<input class="searchBox" type="text" placeholder="내가 키운 채소 내가 먹기">
					<a href="#" class="searchIcon"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_search.svg" alt="search_icon">
					</a>
				</fieldset>
				<a href="#" class="cartIcon"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_user.svg" alt="user_icon">
				</a> <a href="${pageContext.request.contextPath}/cart" class="cartIcon"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_cart.svg" alt="cart_icon">
				</a>

				<div class="menu-wrap">
					<span class="line"></span> <span class="line"></span> <span class="line"></span>
				</div>
			</div>
		</div>

		<div class="categoryMenu" style="display: none;">
			<ul>
				<li>브랜드소개</li>
				<li>식물키우기
					<ul>
						<li class="categorymenuSmall">원예용품</li>
						<li class="categorymenuSmall">식물키트모음</li>
						<li class="categorymenuSmall">허브 키우기</li>
						<li class="categorymenuSmall">채소키우기</li>
						<li class="categorymenuSmall">꽃시키우기</li>
						<li class="categorymenuSmall">기타 키우기키트</li>
					</ul>
				</li>
				<li>타임세일</li>
				<li>리뷰</li>
				<li>매거진</li>
				<li>고객센터
					<ul>
						<li class="categorymenuSmall">마이페이지</li>
						<li class="categorymenuSmall">주문/배송조회</li>
						<li class="categorymenuSmall">관심상품</li>
						<li class="categorymenuSmall">FAQ</li>
						<li class="categorymenuSmall">문의하기</li>
						<li class="categorymenuSmall">공지사항</li>
					</ul>
				</li>
				<li>고객게시판
					<ul>
						<li><a class="categorymenuSmall" href="${pageContext.request.contextPath}/board/list">게시판</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		const menu = document.querySelector(".menu-wrap");
		const categoryMenu = document.querySelector(".categoryMenu");

		if (menu) {
			menu.addEventListener("click", function () {
				menu.classList.toggle("open");
				if (categoryMenu) {
					categoryMenu.style.display =
						categoryMenu.style.display === "block" ? "none" : "block";
				}
			});
		}
	});
</script>
</body>

</html>
