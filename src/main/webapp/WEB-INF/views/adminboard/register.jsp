<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes_admin/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardRegister.css" />

<style>
  table.table td, table.table th {
      vertical-align: middle !important;
      text-align: center;
  }
  
    table.table {
      font-size: 13px;
  }
</style>
</head>

<body>
<%@include file="../main/header.jsp"%>

<div style="width:1240px; margin:0 auto;">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">문의사항 등록</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">작성 후 등록 버튼을 클릭하세요.</div>
				<div class="panel-body">
					<!-- 상품 정보가 있으면 표시 -->
					<c:if test="${product != null}">
						<h5 style="font-weight: bold;">문의하실 상품</h5>
						<div class="boardProductInfo">
							<table>
								<tr>
									<th>
										<img src="${pageContext.request.contextPath}/upload/${product.thumbnail.img_path}" alt="상품 이미지">
									</th>
									<td>
										<p class="productName">상품명 : ${product.product.product_name}</p>
										<p class="productContent">${product.product.product_content}</p>
										<p class="productPrice">상품 가격 : <fmt:formatNumber value="${product.product.product_price}" type="number" /> 원</p>
									</td>
								</tr>
							</table>
						</div>
					</c:if>

					<!-- 문의 등록 폼 -->
					<form role="form" action="/adminboard/register" method="post">
						<input type="hidden" name="productId" value="${productid}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
						
						<sec:authorize access="isAuthenticated()">
						    <input type="hidden" name="createdBy" value='<sec:authentication property="principal.username"/>' />
						    <input type="hidden" name="userId" value='<sec:authentication property="principal.member.id"/>' />
						</sec:authorize>
						
						<div class="form-group">
							<label for="title">제목</label>
							<input id="title" class="form-control" name='title' required>
						</div>

						<div class="form-group">
							<label for="content">내용</label>
							<textarea id="content" class="form-control" rows="10" name='content' style="resize: none; height:300px;" required></textarea>
						</div>

						<div class="form-group">
							<label for="customerId">작성자</label>
							<input id="customerId" class="form-control" name="customerId"  
								value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>

						<button type="submit" class="btn btn-default btn-success">등록</button>
						<button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/adminboard/list'">목록</button>
						<button type="reset" class="btn btn-warning btn-info">다시작성</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes_admin/footer.jsp" %>
<%@include file="../main/footer.jsp"%>

</body>
</html>
