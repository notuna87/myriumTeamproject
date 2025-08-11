<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myriumstory</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css"/>
</head>
<body>
	<div>
		<div class="myriumstoryWrap" style="background-image: url('<c:url value="/resources/img/myriumstory/myriumImg.png"/>');">
			<h2>우리들의 마음은,</h2>
			<h2>지금 안녕한가요?</h2>
			<br>
			<p>몸건강을 위한 제품은 많지만 마음건강을 위한</p>
			<p>제품은 많지 않아요. 마이리움이 그 해답을 드리고 싶어요.</p>
			<a href="<c:url value='/brand_intro'/>" class="myriumstoryButton">마이리움 스토리</a>
		</div>
	</div>
</body>
</html>
