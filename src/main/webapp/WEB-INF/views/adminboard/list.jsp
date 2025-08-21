<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="../includes_admin/header.jsp" %>

<style type="text/css">
   .badge {
     background-color: black;
     color: white;
     font-size: 18px;
     padding: 5px 10px;
     border-radius: 5px;
     margin: 0px 10px;
   }
   
   table.table td, table.table th {
      vertical-align: middle !important;
      text-align: center;
  }
  
  table.table {
      font-size: 13px;
  }
</style>

<body>
<%@ include file="../main/header.jsp" %>

<div style="width:1240px; margin:0 auto;">
	<div class="row">
		<div class="col-lg-12">
			<!-- 관리자일 경우와 일반 사용자에 따라 제목 다르게 출력 -->
			<sec:authorize access="hasAuthority('ADMIN')">
				<h1 class="page-header">문의하기<span class="badge">관리자</span></h1>
			</sec:authorize>
			<sec:authorize access="!hasAuthority('ADMIN')">
				<h1 class="page-header">문의하기</h1>
			</sec:authorize>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<!-- 일반사용자에게만 문의 작성 버튼 노출 -->
				<sec:authorize access="!hasAuthority('ADMIN')">
					<div class="panel-heading">
						문의사항을 작성하려면 등록 버튼을 클릭하세요.
						<button id='regBtn' type="button" class="btn btn-info">등록</button>
					</div>
				</sec:authorize>

				<div class="panel-body">
					<table style="width:100%;" class="table table-striped table-bordered table-hover" id="dataTables-example">
						<thead>
							<tr>
								<th class="text-center">No.</th>
								<th class="text-center">제목</th>
								<th class="text-center">작성자 ID</th>
								<th class="text-center">작성일</th>
								<th class="text-center">수정일</th>
								<!-- 관리자만 상태 및 관리 컬럼 노출 -->
								<sec:authorize access="hasAuthority('ADMIN')">
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
										<tr class="odd gradeX <c:if test='${board.isDeleted == 1}'>table-danger</c:if>">
											<td class="text-center">${board.id}</td>
											<td>
												<a class="move" href="${board.id}">${board.title}</a>
												<c:if test="${board.replyCnt > 0}">
													<b>[ <c:out value="${board.replyCnt}" /> ]</b>
												</c:if>
												<b>
													<c:choose>
														<c:when test="${board.isAnswered == 1}">
															<span class="label label-success">답변완료</span>
														</c:when>
														<c:otherwise>
															<span class="label label-default">미답변</span>
														</c:otherwise>
													</c:choose>
												</b>
											</td>
											<td class="text-center">${board.customerId}</td>
											<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.createdAt}" /></td>
											<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedAt}" /></td>

											<!-- 관리자 전용 열 -->
											<sec:authorize access="hasAuthority('ADMIN')">
												<td class="text-center">
													<c:choose>
														<c:when test="${board.isDeleted == 1}"><span class="label label-default">비노출</span></c:when>
														<c:otherwise><span class="label label-success">게시중</span></c:otherwise>
													</c:choose>
												</td>
												<td class="text-center">
													<button type="button" class="btn btn-sm btn-primary edit-btn" data-id="${board.id}">수정</button>
													<c:choose>
														<c:when test="${board.isDeleted == 0}">
															<button type="button" class="btn btn-sm btn-warning softdel-btn" data-id="${board.id}">비노출</button>
															<button type="button" class="btn btn-sm btn-danger harddel-btn" data-id="${board.id}">삭제</button>
														</c:when>
														<c:otherwise>
															<button type="button" class="btn btn-sm btn-success restore-btn" data-id="${board.id}">복구</button>
															<button type="button" class="btn btn-sm btn-danger harddel-btn" data-id="${board.id}">삭제</button>
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

					<!-- 검색조건 폼 -->
					<div class='row'>
						<div class="col-lg-12">
							<form id='searchFormBoard' action="/adminboard/list" method='get'>
								<select name='type'>
									<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" /> >선택하세요</option>
									<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" /> >제목</option>
									<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" /> >내용</option>
									<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" /> >작성자</option>
									<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" /> >제목 or 내용</option>
									<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" /> >제목 or 작성자</option>
									<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}" /> >제목 or 내용 or 작성자</option>
								</select>
								<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />' /> 
								<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}" />' /> 
								<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}" />' />
								<button type="submit" class="btn btn-sm btn-primary">
									<i class="fa fa-search"></i> 검색
								</button>
							</form>
						</div>
					</div>

					<!-- 페이지네이션 -->
					<div class="pull-right">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li class="paginate_button">
									<a class="page-link" href="${pageMaker.startPage - 1}">Previous</a>
								</li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
									<a href="${num}">${num}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next}">
								<li class="paginate_button">
									<a href="${pageMaker.endPage + 1}">Next</a>
								</li>
							</c:if>
						</ul>
					</div>

					<!-- actionForm: 페이지 이동 및 상세보기 폼 -->
					<form id='actionForm' action="/adminboard/list" method='get'>
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
						<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
						<input type='hidden' name='type' value='${pageMaker.cri.type}'>
						<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
					</form>

					<!-- 처리 완료 모달 -->
					<div class="modal" id="myModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<div class="modal-header">
									<h4 class="modal-title">처리 완료</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>

								<div class="modal-body">처리가 완료되었습니다.</div>

								<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
								</div>

							</div>
						</div>
					</div>
					<!-- End Modal -->
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

    // 모달 출력 및 히스토리 상태 초기화
    function checkModal(result){
        console.log("checkModal called with result:", result);

        if(result === '' || history.state){
            console.log("No modal shown due to empty result or history state.");
            return;
        } 

        if(parseInt(result) > 0){
            $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
            $("#myModal").modal("show");
            console.log("Modal shown for post ID:", result);
        }
    }
	checkModal(result);

	// 히스토리 상태 변경하여 뒤로가기 시 모달 재출력 방지
	history.replaceState({}, null, null);

	// 문의 작성 버튼 클릭 시 등록 페이지로 이동
	$("#regBtn").on("click", function(){
		console.log("작성 버튼 클릭 - /adminboard/register 로 이동");
		location.href = "/adminboard/register";
	});

	var actionForm = $("#actionForm");

	// 페이지네이션 클릭 이벤트 처리
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		var page = $(this).attr("href");
		console.log("페이지네이션 클릭, 이동할 페이지 번호:", page);

		// 기존 action 및 id 제거 (중복 파라미터 문제 해결)
		actionForm.removeAttr("action");
		actionForm.find("input[name='id']").remove();

		// 선택한 페이지 번호로 pageNum 값 변경 후 submit
		actionForm.find("input[name='pageNum']").val(page);
		actionForm.submit();
	});

	// 게시글 제목 클릭 시 상세 페이지 이동
	$(".move").on("click", function(e){
		e.preventDefault();
		var id = $(this).attr("href");
		console.log("게시글 상세보기 클릭, id:", id);

		actionForm.find("input[name='id']").remove();
		actionForm.append("<input type='hidden' name='id' value='" + id + "'>");
		actionForm.attr("action", "/adminboard/get");
		actionForm.submit();
	});

	// 검색 폼 검증 및 제출
	$("#searchFormBoard button").on("click", function(e){
		var selectedType = $("#searchFormBoard select[name='type']").val();
		var keyword = $("#searchFormBoard input[name='keyword']").val();

		if(!selectedType){
			alert("검색종류를 선택하세요");
			return false;
		}
		if(!keyword){
			alert("키워드를 입력하세요");
			return false;
		}

		// 검색 시 항상 첫 페이지부터
		$("#searchFormBoard input[name='pageNum']").val("1");
		e.preventDefault();

		console.log("검색 요청, type:", selectedType, ", keyword:", keyword);
		$("#searchFormBoard").submit();
	});

	// 관리자 버튼 이벤트 처리
	$(document).on("click", ".edit-btn", function(){
		var id = $(this).data("id");
		console.log("수정 버튼 클릭, id:", id);
		window.location.href = "/adminboard/modify?id=" + id;
	});

	$(document).on("click", ".harddel-btn", function(){
		var id = $(this).data("id");
		if(confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")){
			console.log("영구삭제 요청, id:", id);
			$.ajax({
				type: "post",
				url: "/adminboard/harddel",
				data: { id: id },
				success: function(){
					console.log("영구삭제 성공, 페이지 새로고침");
					location.reload();
				},
				error: function(){
					alert("삭제 실패");
					console.error("영구삭제 실패, id:", id);
				}
			});
		}
	});

	$(document).on("click", ".softdel-btn", function(){
		var id = $(this).data("id");
		if(confirm("글이 노출되지 않습니다.")){
			console.log("글내림 요청, id:", id);
			$.ajax({
				type: "post",
				url: "/adminboard/softdel",
				data: { id: id },
				success: function(){
					console.log("글내림 성공, 페이지 새로고침");
					location.reload();
				},
				error: function(){
					alert("글내림 실패");
					console.error("글내림 실패, id:", id);
				}
			});
		}
	});

	$(document).on("click", ".restore-btn", function(){
		var id = $(this).data("id");
		if(confirm("복구하시겠습니까?")){
			console.log("복구 요청, id:", id);
			$.ajax({
				type: "post",
				url: "/adminboard/restore",
				data: { id: id },
				success: function(){
					console.log("복구 성공, 페이지 새로고침");
					location.reload();
				},
				error: function(){
					alert("복구 실패");
					console.error("복구 실패, id:", id);
				}
			});
		}
	});
});
</script>

</body>
<%@ include file="../includes_admin/footer.jsp" %>
<%@ include file="../main/footer.jsp" %>
