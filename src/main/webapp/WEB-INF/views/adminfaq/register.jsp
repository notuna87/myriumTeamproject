<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 등록</title>
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">FAQ 등록(관리자)</h1>
		</div>
	</div>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">작성 후 등록 버튼을 클릭하세요.</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/adminfaq/register" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
						
						<sec:authorize access="isAuthenticated()">
						    <input type="hidden" name="createdBy" value='<sec:authentication property="principal.username"/>' />
						    <input type="hidden" name="userId" value='<sec:authentication property="principal.member.id"/>' />
						</sec:authorize>
						
						<div class="form-group">
						    <label>분류</label>
						    <div>
						        <label class="radio-inline">
						            <input type="radio" name="section" value="0" checked> 📌 일반
						        </label>
						        <label class="radio-inline">
						            <input type="radio" name="section" value="1"> 📦 상품 관련
						        </label>
						        <label class="radio-inline">
						            <input type="radio" name="section" value="2"> 🌱 관리 & 재배 관련
						        </label>
						        <label class="radio-inline">
						            <input type="radio" name="section" value="3"> 🚚 배송 관련
						        </label>
						        <label class="radio-inline">
						            <input type="radio" name="section" value="4"> 🔁 반품 & 환불 관련
						        </label>
						    </div>
						</div>
						
						<div class="form-group">
							<label>자주 묻는 질문</label> <input class="form-control" name='question'>
						</div>

						<div class="form-group">
							<label>답변내용</label>
							<textarea class="form-control" rows="10" name='answer'></textarea>
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