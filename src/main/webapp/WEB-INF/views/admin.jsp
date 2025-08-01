<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Arrays" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메뉴</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <style>
		.outer-wrapper {
		    height: 80vh;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
        .menu-container {
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .menu-title {
            margin-bottom: 30px;
        }
        .menu-button {
            width: 100%;
            margin-bottom: 10px;
            font-size: 1.2rem;
            padding: 15px;
        }
    </style>
</head>


<body>
<%@ include file="main/header.jsp" %>
<%
    // 메뉴 항목 이름과 이동할 URL 매핑
    List<String[]> adminMenu = Arrays.asList(
        new String[] {"상품 관리(구현중)", "product/list"},
        new String[] {"회원 관리(미구현)", "member/list"},
        new String[] {"공지사항 관리", "notice/list"},
        new String[] {"FAQ 관리", "faq/list"},
        new String[] {"리뷰 관리(미구현)", "review/list"},
        new String[] {"문의 관리", "board/list"},
        new String[] {"주문 관리(미구현)", "order/list"}
    );
    request.setAttribute("menuList", adminMenu);
%>

<div class="outer-wrapper">
    <div class="menu-container">
        <h2 class="menu-title">관리자 메뉴</h2>
        <c:forEach var="menu" items="${menuList}">
            <form action="${menu[1]}" method="get">
                <button type="submit" class="btn btn-primary menu-button">${menu[0]}</button>
            </form>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="main/footer.jsp" %>
</body>
</html>
