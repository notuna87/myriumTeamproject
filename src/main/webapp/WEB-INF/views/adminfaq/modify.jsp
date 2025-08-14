<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes_admin/header.jsp" %> 

<body>

<%@include file="../main/header.jsp"%>
<div style="width:1240px; margin:0 auto;">
<div class="row">
     <div class="col-lg-12">
        <h1 class="page-header">FAQ 수정<span class="badge">관리자</span></h1>
    </div>
</div>

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">수정 후 수정 버튼을 클릭하세요.</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<form role="form" action="/adminfaq/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
					
					<sec:authorize access="isAuthenticated()">
						<input type="hidden" name="updatedBy" value='<sec:authentication property="principal.member.customerId"/>' />
					</sec:authorize>
					
					<div class="form-group">
					       <label>No.</label> 
                           <input class="form-control" name='id' value="${faq.id}" readonly="readonly">
					</div>
					
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
					      <label>제목</label> 	
                      	  <input class="form-control" name='question' value="${faq.question}" >
					</div>

					<div class="form-group">
		                  <label>내용</label>
					      <textarea class="form-control" rows="3" name='answer' style="resize:none; height:300px;">${faq.answer}</textarea>
					</div>

					<div class="form-group">
					      <label>작성자</label> 
                          <input class="form-control" name='customerId' value="${faq.customerId}" readonly="readonly">
					</div>

   					<sec:authorize access="hasAuthority('ADMIN')">
		            	<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                        <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
		            </sec:authorize>

					<button type="submit" data-oper='list' class="btn btn-info">목록</button>

				</form>
			</div>
		</div>
	</div>
</div>
</div>


<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form");
	
	$("button").on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
				formObj.attr("action", "/adminfaq/harddel"); // 소프트 삭제 => softdel, 하드(영구) 삭제 => harddel 
			}
		}else if(operation === 'list'){
			formObj.attr("action", "/adminfaq/list").attr("method", "get");
			formObj.empty();
		}
		
		formObj.submit();
		
	});
	
});
</script>


</body>
<%@include file="../includes_admin/footer.jsp" %> 
<%@include file="../main/footer.jsp"%>