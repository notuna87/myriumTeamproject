<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_chat.css" />

<body>
	<div class="row">
         <div class="col-lg-12">
            <sec:authorize access="hasAuthority('ADMIN')">
            	<h1 class="page-header">공지사항 보기(관리자)</h1>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
            	<h1 class="page-header">공지사항 보기</h1>
            </sec:authorize>
        </div>
	</div>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<td><span class="badge badge-danger ml-1">NEW</span> 마크는 최근 3일 이내에 업로드 된 글입니다.</td> 
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group">
						<label>No.</label> 
						<input class="form-control" name='id' value="${notice.id}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name='title' value="${notice.title}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name='content' readonly="readonly">${notice.content}</textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name='customerId' value="${notice.customerId}" readonly="readonly"/>
					</div>

					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq notice.customerId}">
							<button type="button" class="btn btn-warning softdel-btn" data-id="${notice.id}" data-customer-id="${notice.customerId}">글내림</button>
						</c:if>
					</sec:authorize>
					<sec:authorize access="hasAuthority('ADMIN')">
		            	<button data-oper='modify' class="btn btn-default">수정</button>
		            </sec:authorize>

					<%-- <button data-oper='modify' class="btn btn-default btn-success"
					onclick="location.href='/notice/modify?id=${notice.id}'">Modify</button> --%>

					<button data-oper='list' class="btn btn-default btn-info"
						onclick="location.href='/notice/list'">목록</button>

					<form id='operForm' action="/notice/modify" method='get'>
						<input type='hidden' id="id" name='id' value='${notice.id}'> <input type='hidden'
							name='pageNum' value='${cri.pageNum}'> <input type='hidden' name='amount'
							value='${cri.amount}'> <input type='hidden' name='type' value='${cri.type}'>
						<input type='hidden' name='keyword' value='${cri.keyword}'>
					</form>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>




</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>

<script type="text/javascript">
  $(document).ready(function() {
    var operForm = $("#operForm");

    $("button[data-oper='modify']").on("click", function(e) {
      operForm.attr("action", "/board/modify").submit();
    });
    
    $("button[data-oper='list']").on("click", function(e) {
      operForm.find("#id").remove();
      operForm.attr("action", "/board/list");
      operForm.submit();
    });
    
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    const customerId = $(this).data("customer-id");
	    if (confirm("글이 노출되지 않습니다. 정말 하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/board/softdel",
	            data: { 
	            	id: id,
	            	customerId: customerId
	            },
	            success: function () {
	                //location.reload();
	                window.location.href = "/board/list";
	            },
	            error: function () {
	                alert("글내림 실패");
	            }
	        });
	    }
	});
  });
</script>