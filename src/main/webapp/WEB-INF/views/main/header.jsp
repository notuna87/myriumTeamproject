<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
				<!-- 로그인 안 했을 때 -->
				<sec:authorize access="!isAuthenticated()">
					<li><a href="${pageContext.request.contextPath}/admin">관리자</a></li>
					<li><a href="#" id="mypageLinkNotLoggedIn">마이페이지</a></li>
					<li><a href="${pageContext.request.contextPath}/login">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/join" class="loginWrapLastchild">회원가입</a></li>
				</sec:authorize>

				<!-- 로그인 했을 때 -->
				<sec:authorize access="isAuthenticated()">
					<li><a href="${pageContext.request.contextPath}/admin">관리자</a></li>
					<li><a href="${pageContext.request.contextPath}/mypage">마이페이지</a></li>
					<li><sec:authentication property="principal.member.customerName" var="username" /> <span>${username}님</span></li>
					<li><a href="#" onclick="document.getElementById('logoutForm').submit(); return false;" class="logoutLi">로그아웃</a>
						<form id="logoutForm" action="${pageContext.request.contextPath}/customLogout" method="post" style="display: none;"></form></li>
				</sec:authorize>

			</ul>
		</div>
	</div>

	<div class="navsearchWrap">
		<div class="navbarWrap">
			<ul>
				<li><a href="#">브랜드 소개</a></li>
				<li><a href="${pageContext.request.contextPath}/category">식물키우기</a></li>
				<li><a href="#">타임세일</a></li>
				<li><a href="${pageContext.request.contextPath}/total_review">리뷰</a></li>
				<li><a href="#">매거진</a></li>
				<li class="subCategoryWrap"><a href="#">고객센터</a>
					<div class="subCategory">
						<ul>
							<li><a href="#">식물백서</a></li>
							<li><a href="${pageContext.request.contextPath}/adminnotice/list">공지사항</a></li>
							<li><a href="${pageContext.request.contextPath}/adminboard/list">문의하기</a></li>
							<li><a href="#">상품 리뷰</a></li>
							<li><a href="${pageContext.request.contextPath}/adminfaq/list">FAQ</a></li>
						</ul>
					</div></li>
			</ul>
		</div>

		<div class="searchBoxWrap">
			<fieldset class="headerFieldset">
				<form id="searchForm" style="display: flex; align-items: center;" action="/search" method="post">
					<input name="productSearch" class="searchBox" type="text" placeholder="내가 키운 채소 내가 먹기" style="height: 18px;">
					<a href="#" class="searchIcon"> <img onclick="document.getElementById('searchForm').submit();" src="${pageContext.request.contextPath}/resources/img/logo/icon_search.svg" alt="search_icon">
					</a>
				</form>
			</fieldset>
			<a href="#" class="cartIcon"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_user.svg" alt="user_icon">
			</a>
			<sec:authorize access="!isAuthenticated()">
				<a href="#" class="cartIcon" id="cartLinkNotLoggedIn"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_cart.svg" alt="cart_icon"></a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="${pageContext.request.contextPath}/cart" class="cartIcon"> <img src="${pageContext.request.contextPath}/resources/img/logo/icon_cart.svg" alt="cart_icon"></a>
			</sec:authorize>




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
					<li><a class="categorymenuSmall" href="${pageContext.request.contextPath}/board/list">문의하기</a></li>
					<li class="categorymenuSmall">공지사항</li>
				</ul>
			</li>
		</ul>
	</div>

	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							const menu = document.querySelector(".menu-wrap");
							const categoryMenu = document
									.querySelector(".categoryMenu");

							if (menu) {
								menu
										.addEventListener(
												"click",
												function() {
													menu.classList
															.toggle("open");
													if (categoryMenu) {
														categoryMenu.style.display = categoryMenu.style.display === "block" ? "none"
																: "block";
													}
												});
							}
						});
	</script>

	<script>
  const isLoggedIn = <sec:authorize access="isAuthenticated()">true</sec:authorize><sec:authorize access="!isAuthenticated()">false</sec:authorize>;
	</script>


	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const mypageLink = document.getElementById('mypageLinkNotLoggedIn');

    if (mypageLink) {
      mypageLink.addEventListener('click', function (e) {
        e.preventDefault(); // 링크 기본 이동 막기
        alert("회원 전용 기능입니다. 로그인 후 이용해주세요.");
        location.href = "${pageContext.request.contextPath}/login";
      });
    }
  });
  
	// 로그인 확인
	document.addEventListener("DOMContentLoaded", function() {
		const cartLink = document.getElementById('cartLinkNotLoggedIn');
		const purchaseLink = document.getElementById('purchaseLinkNotLoggedIn');
		
		if (cartLink) {
			cartLink.addEventListener('click', function(e) {
				e.preventDefault();
				alert("로그인 후 이용해주세요.");
				location.href = "${pageContext.request.contextPath}/login";
			});
		}
		if (purchaseLink) {
			purchaseLink.addEventListener('click', function(e) {
				e.preventDefault();
				alert("로그인 후 이용해주세요.");
				location.href = "${pageContext.request.contextPath}/login";
			});
		}

	});

</script>

</body>

</html>
