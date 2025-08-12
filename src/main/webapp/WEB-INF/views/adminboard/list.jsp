<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="../includes_admin/header.jsp"%>

<body>
<%@include file="../main/header.jsp"%>
<div style="width:1240px; margin:0 auto;">
	<div class="row">
		<div class="col-lg-12">
			<sec:authorize access="hasAuthority('ADMIN')">
				<h1 class="page-header">문의하기<span class="badge">관리자</span></h1>
			</sec:authorize>
			<sec:authorize access="!hasAuthority('ADMIN')">
				<h1 class="page-header">문의하기</h1>
			</sec:authorize>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<sec:authorize access="!hasAuthority('ADMIN')">
					<div class="panel-heading">
						문의사항을 작성하려면 작성 버튼을 클릭하세요.
						<button id='regBtn' type="button" class="btn btn-info">작성</button>
					</div>
				</sec:authorize>

				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%" class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th class="text-center">No.</th>
								<th class="text-center">제목</th>
								<th class="text-center">작성자 ID</th>
								<th class="text-center">작성일</th>
								<th class="text-center">수정일</th>

								<!-- 관리자만 노출 -->
								<sec:authorize access="hasAuthority('ADMIN')">
									<!-- <th>답변여부</th> -->
									<th class="text-center">상태</th>
									<th class="text-center">관리</th>
								</sec:authorize>
							</tr>
						</thead>

						<tbody>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="7" class="text-center">작성된 문의가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="board">
										<tr
											class="odd gradeX 
								          <c:if test='${board.isDeleted == 1}'>table-danger</c:if>'">
											<td class="text-center">${board.id}</td>
											<td><a class="move" href="${board.id}"> ${board.title}</a> <c:choose>
													<c:when test="${board.replyCnt > 0}">
														<b>[ <c:out value="${board.replyCnt}" /> ]
														</b>
													</c:when>
												</c:choose> <b> <c:choose>
														<c:when test="${board.isAnswered == 1}">
															<span class="label label-success">답변완료</span>
														</c:when>
														<c:otherwise>
															<span class="label label-default">미답변</span>
														</c:otherwise>
													</c:choose>
											</b></td>

											<td class="text-center">${board.customerId}</td>
											<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
													value="${board.createdAt}" /></td>
											<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
													value="${board.updatedAt}" /></td>

											<!-- 관리자 전용 열 -->
											<sec:authorize access="hasAuthority('ADMIN')">
												<td class="text-center"><c:choose>
														<c:when test="${board.isDeleted == 1}">미노출</c:when>
														<c:otherwise>정상</c:otherwise>
													</c:choose></td>
												<td class="text-center">
													<button type="button" class="btn btn-sm btn-primary edit-btn" data-id="${board.id}">수정</button>

													<c:choose>
														<c:when test="${board.isDeleted == 0}">
															<button type="button" class="btn btn-sm btn-warning softdel-btn"
																data-id="${board.id}">글내림</button>
															<button type="button" class="btn btn-sm btn-danger harddel-btn"
																data-id="${board.id}">영구삭제</button>
														</c:when>
														<c:otherwise>
															<button type="button" class="btn btn-sm btn-success restore-btn"
																data-id="${board.id}">복구</button>
															<button type="button" class="btn btn-sm btn-danger harddel-btn"
																data-id="${board.id}">영구삭제</button>
														</c:otherwise>
													</c:choose>
												</td>
											</sec:authorize>
										</tr>
									</c:forEach>
								</c:otherwise>

							</c:choose>
						</tbody>
					</table>


					<!-- 검색조건 -->
					<div class='row'>
						<div class="col-lg-12">
							<form id='searchForm' action="/adminboard/list" method='get'>
								<select name='type'>
									<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>선택하세요</option>
									<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
									<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
									<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
									<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
										or 내용</option>
									<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
										or 작성자</option>
									<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
										or 내용 or 작성자</option>
								</select> 
								
								<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
								<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
								<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
								
								<button type="submit" class="btn btn-sm btn-primary">
									<i class="fa fa-search"></i> 검색
								</button>
							</form>
						</div>
					</div>
					<!-- end 검색조건 -->



					<!-- 페이지 처리 -->
					<div class="pull-right">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li class="paginate_button"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': ''} "><a
									href="${num}">${num}</a></li>
							</c:forEach>

							<c:if test="${pageMaker.next}">
								<li class="paginate_button"><a href="${pageMaker.endPage+1}">Next</a></li>
							</c:if>
						</ul>
					</div>
					<!-- end 페이지 처리 -->

					<form id='actionForm' action="/adminboard/list" method='get'>
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> <input
							type='hidden' name='amount' value='${pageMaker.cri.amount}'> <input type='hidden'
							name='type' value='${pageMaker.cri.type}'> <input type='hidden' name='keyword'
							value='${pageMaker.cri.keyword}'>
					</form>


					<!-- The Modal -->
					<div class="modal" id="myModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h4 class="modal-title">Modal Heading</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>

								<!-- Modal body -->
								<div class="modal-body">처리가 완료되었습니다.</div>

								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
								</div>

							</div>
						</div>
						<!-- End Modal -->
					</div>
				</div>
			</div>
		</div>

	</div>

</div>
<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var result = '${result}'; 	
    
	checkModal(result);
	//상태 객체, 제목,  URL, 현재 상태를 빈 상태로 대체, 뒤로가기 버튼을 눌렀을 때 이전 페이지로 되돌아가지 않고 현재 페이지에 그대로 만듬
	history.replaceState({}, null,null);   // 뒤로가기 모달창을 보여준 뒤에는 더 이상 모달창이 필요하지 않음
	//페이지 이동(뒤로가기)하므로 세션 기록(history)을 조작하는history.replaceState({}, null, null); 메서드 사용
           //마지막 값이 null로 설정되면 현재 URL이 유지
	
	function checkModal(result){
		if(result === '' || history.state){  //빈문자열이거나 history.state true일 때 모달이 보이지 않음
			return ;
		}else{
			if(parseInt(result)>0){
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
	}
	
	$("#regBtn").on("click",function(){
		self.location = "/adminboard/register";
	})
	
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		
		actionForm.removeAttr("action"); //뒤로가기 후 기존 파라미터 누적문제 해결
		actionForm.find("input[name='id']").remove(); //뒤로가기 후 기존 파라미터 누적문제 해결
		
		// 클릭된 요소의 href 값을 찾아서 input 폼 안의 pageNum 필드에 설정		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		
		actionForm.find("input[name='id']").remove(); //뒤로가기 후 기존 파라미터 누적문제 해결
		
		actionForm.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action","/adminboard/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}

		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
		
	});
    
	// 관리자용 버튼 이벤트
	$(document).on("click", ".edit-btn", function () {
	    const id = $(this).data("id");
	    window.location.href = "/adminboard/modify?id=" + id;
	});

	$(document).on("click", ".harddel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/adminboard/harddel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("삭제 실패");
	            }
	        });
	    }
	});
	
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("글이 노출되지 않습니다. 정말 하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/adminboard/softdel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("글내림 실패");
	            }
	        });
	    }
	});

	$(document).on("click", ".restore-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("복구하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/adminboard/restore",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("복구 실패");
	            }
	        });
	    }
	});
	
    
});
</script>

</body>
<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>

