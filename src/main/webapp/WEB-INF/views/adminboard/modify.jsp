<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %> 

<body>
<div style="width:1240px; margin:0 auto;">
	<div class="row">
		<div class="col-lg-12">
			<sec:authorize access="hasAuthority('ADMIN')">
				<h1 class="page-header">문의사항 수정<span class="badge">관리자</span></h1>
			</sec:authorize>
			<sec:authorize access="!hasAuthority('ADMIN')">
				<h1 class="page-header">문의사항 수정</h1>
			</sec:authorize>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">수정 후 등록 버튼을 클릭하세요.</div>
				<div class="panel-body">
					<form role="form" action="/adminboard/modify" method="post" id="boardForm">
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
						      <textarea class="form-control" rows="3" name='content' style="resize:none; height:300px;">${board.content}</textarea>
						</div>

						<div class="form-group">
							<label>작성자</label> 
							<input class="form-control" name='customerId' value="${board.customerId}" readonly="readonly">
						</div>

						<sec:authorize access="hasAuthority('ADMIN')">
							<button type="submit" data-oper='modify' class="btn btn-default">등록</button>
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
	const formObj = $("#boardForm");

	$("button").on("click", function(e) {
		e.preventDefault();

		const operation = $(this).data("oper");
		console.log("버튼 클릭 - operation:", operation);

		if (operation === 'remove') {
			if (confirm("삭제 후 복구할 수 없습니다.")) {
				formObj.attr("action", "/adminboard/harddel");
				console.log("삭제 처리 진행: 하드 딜리트 요청");
			} else {
				console.log("삭제 취소됨");
				return;  // 취소 시 폼 제출 막음
			}
		} else if (operation === 'list') {
			console.log("목록 이동 처리");

			formObj.attr("action", "/adminboard/list").attr("method", "get");

			// 기존 파라미터만 남기고 폼 내용 비우기
			const pageNumTag = $("input[name='pageNum']").clone();
			const amountTag = $("input[name='amount']").clone();
			const keywordTag = $("input[name='keyword']").clone();
			const typeTag = $("input[name='type']").clone();

			formObj.empty();
			formObj.append(pageNumTag, amountTag, keywordTag, typeTag);
		} else if (operation === 'modify') {
			console.log("수정 처리");
			formObj.attr("action", "/adminboard/modify");
		} else {
			console.log("알 수 없는 operation:", operation);
		}

		formObj.submit();
	});
});
</script>

</body>
<%@include file="../includes_admin/footer.jsp" %> 
<%@include file="../main/footer.jsp"%>
