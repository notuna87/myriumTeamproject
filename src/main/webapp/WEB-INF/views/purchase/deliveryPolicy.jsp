<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리움 : 배송정보 제공방침 동의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<style>
.deliveryWrap {
	width: 100%;
	height: 100%;
	padding: 30px;
	background-color : #fafafa;
	margin: 0 auto;
}

.policyContent {
	background-color: #fff;
	padding: 20px;
	font-size: 14px;
	color: #555;
	border-radius: 20px;
	margin-top: 40px;
	border : 1px solid #ebebeb;
}

button {
	display: block;
	min-width: 60px;
	height: 40px;
	padding: 0 14px;
	border: 1px solid #1a54f5;
	background-color: #1A54F5;
	color: #fff;
	margin: 0 auto;
	margin-top: 112px;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
}

</style>
</head>
<body>
	<div class="deliveryWrap">
		<h2>배송정보 제공 방침</h2>
		<div class="policyContent">
			<p>본 상품의 원할한 배송을 위하여 회원님의 주소를 상품판매업체 및 배송업체에 제공합니다.</p>
		</div>
		<button onclick="window.close();">확인</button>
	</div>
</body>
</html>