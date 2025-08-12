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
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardRegister.css" />

<body>
<%@include file="../main/header.jsp"%>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">문의사항 등록</h1>
		</div>
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">작성 후 등록 버튼을 클릭하세요.</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
				<c:if test="${product != null}">
				<h5 style="font-weight : bold;">문의하실 상품</h5>
				<div class="boardProductInfo">
						<table>
							<tr>
								<th><img src="${pageContext.request.contextPath}/upload/${product.thumbnail.img_path}"></th>
								<td><p class="productName">상풍명 : ${product.product.product_name}</p>
								<p class="productContent">${product.product.product_content }</p>
								<p class="productPrice">상품 가격 : <fmt:formatNumber value="${product.product.product_price}" type="number" />원</p></td>
							</tr>
						</table>
					</div>
				</c:if>
					<form role="form" action="/adminboard/register" method="post">
					<input type="hidden" name="productId" value="${productid}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
						
						<sec:authorize access="isAuthenticated()">
						    <input type="hidden" name="createdBy" value='<sec:authentication property="principal.username"/>' />
						    <input type="hidden" name="userId" value='<sec:authentication property="principal.member.id"/>' />
						</sec:authorize>
						
						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title'>
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name='content'></textarea>
						</div>

						<div class="form-group">
							<label>작성자</label>
							<input class="form-control" name="customerId"  value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>
						<button type="submit" class="btn btn-default btn-success">등록</button>
						<button type="reset" class="btn btn-default btn-info">다시작성</button>
					</form>

				</div>
			</div>
		</div>
	</div>

</body>

<%@include file="../includes_admin/footer.jsp" %>
<%@include file="../main/footer.jsp"%>

</html>