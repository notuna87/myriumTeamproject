<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리움</title>
<!-- reset css  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<!-- Swiper CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/views/main/topad.jsp"%>
	<%@ include file="/WEB-INF/views/main/header.jsp"%>
	<%@ include file="/WEB-INF/views/sub/product.jsp"%>
	<%@ include file="/WEB-INF/views/sub/productDetail.jsp"%>
	<%@ include file="/WEB-INF/views/sub/popularProducts.jsp"%>
	<%@ include file="/WEB-INF/views/sub/announcement.jsp"%>
	<%@ include file="/WEB-INF/views/sub/review.jsp"%>
	<%@ include file="/WEB-INF/views/sub/subQna.jsp"%>
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
</body>
</html>