<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %> 

<body>

<div class="row">
     <div class="col-lg-12">
        <sec:authorize access="hasAuthority('ADMIN')">
        	<h1 class="page-header">문의사항 수정(관리자)</h1>
        </sec:authorize>
        <sec:authorize access="!hasAuthority('ADMIN')">
        	<h1 class="page-header">문의사항 수정</h1>
        </sec:authorize>
    </div>
</div>

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">수정 후 수정 버튼을 클릭하세요.</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
					<input type='hidden' name='pageNum' value='${cri.pageNum}'>
					<input type='hidden' name='amount' value='${cri.amount}'>
					<input type='hidden' name='type' value='${cri.type}'>
					<input type='hidden' name='keyword' value='${cri.keyword}'>
					
					<sec:authorize access="isAuthenticated()">
						<input type="hidden" name="updatedBy" value='<sec:authentication property="principal.member.customerId"/>' />
					</sec:authorize>
					
					<div class="form-group">
					       <label>No.</label> 
                           <input class="form-control" name='id' value="${board.id}" readonly="readonly">
					</div>

					<div class="form-group">
					      <label>제목</label> 	
                      	  <input class="form-control" name='title' value="${board.title}" >
					</div>

					<div class="form-group">
		                  <label>내용</label>
					      <textarea class="form-control" rows="3" name='content'>${board.content}</textarea>
					</div>

					<div class="form-group">
					      <label>작성자</label> 
                          <input class="form-control" name='customerId' value="${board.customerId}" readonly="readonly">
					</div>

                    <sec:authentication property="principal" var="pinfo"/>	
                    <!--  <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
	     			 <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button> --> 

                   <sec:authentication property="principal" var="pinfo"/>
                    <!--<sec:authorize access="isAuthenticated()">
                      <c:if test="${pinfo.username eq board.customerId}">
                        <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                        <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                      </c:if>
                    </sec:authorize> -->
                   
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
				formObj.attr("action", "/board/harddel"); // 소프트 삭제 => softdel, 하드(영구) 삭제 => harddel 
			}
		}else if(operation === 'list'){
			formObj.attr("action", "/board/list").attr("method", "get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		
		formObj.submit();
		
	});
	
});
</script>


</body>
<%@include file="../includes_admin/footer.jsp" %> 
<%@include file="../main/footer.jsp"%>