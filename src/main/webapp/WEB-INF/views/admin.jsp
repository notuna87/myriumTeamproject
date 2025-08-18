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

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <style>
		.outer-wrapper {
		    height: 80vh;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin: 50px 0;
		}
        .menu-container {
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .menu-title {
            margin-bottom: 30px;
            font-size: 1.8rem;
            font-weight: bold;
            color: #2f5233;
        }
        .menu-button {
            width: 100%;
            margin-bottom: 15px;
            font-size: 1.2rem;
            padding: 15px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #4caf50, #2e7d32);
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .menu-button:hover {
            background: linear-gradient(135deg, #66bb6a, #388e3c);
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.2);
        }
        .menu-button:active {
            transform: translateY(0);
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body>
<%@ include file="main/header.jsp" %>
<%
    List<String[]> adminMenu = Arrays.asList(
        new String[] {"상품 관리", "adminproduct/list"},
        new String[] {"회원 관리", "adminmember/list"},
        new String[] {"공지 관리", "adminnotice/list"},
        new String[] {"FAQ 관리", "adminfaq/list"},
        new String[] {"리뷰 관리", "adminreview/list"},
        new String[] {"문의 관리", "adminboard/list"},
        new String[] {"주문 관리", "adminorder/list"}
    );
    request.setAttribute("menuList", adminMenu);
%>

<div class="outer-wrapper">
    <div class="menu-container">
        <h2 class="menu-title">관리자 메뉴</h2>
        <c:forEach var="menu" items="${menuList}">
            <form action="${menu[1]}" method="get">
                <button type="submit" class="menu-button">${menu[0]}</button>
            </form>
        </c:forEach>
    </div>
</div>

<%@ include file="main/footer.jsp" %>
</body>
</html>
