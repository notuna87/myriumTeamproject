<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../includes_admin/header.jsp"%>

<style>
  .category-label {
    display: inline-block;
    margin: 1px;
  }
</style>

<!-- 뒤로가기 시 조회수 증가를 위해 새로고침 -->
<!-- 한 세션에서 여러번 조회수 늘릴수 있음 : 세션 당 조회수 중복 방지 적용 안됨 -> 구현과제 -->
<script>
    window.onpageshow = function(event) {
        if (event.persisted || window.performance.navigation.type === 2) {
            location.reload();
        }
    };
</script>

<body>
<%@include file="../main/header.jsp"%>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">회원관리<span class="badge">관리자</span></h1>
		</div>
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<sec:authorize access="isAuthenticated()">
					<input type="hidden" name="customerId"
						value='<sec:authentication property="principal.member.id"/>' />
				</sec:authorize>
				<sec:authorize access="hasAuthority('ADMIN')">
					<!-- <div class="panel-heading">
						새회원 등록은 작성을 클릭하세요.
						<button id='regBtn' type="button" class="btn btn-info">작성</button>
					</div> -->
					<div class="panel-heading">
						<span class="badge badge-danger ml-1">NEW</span> 최근 3일 이내에 등록된 신규 회원입니다.
					</div> 
				</sec:authorize>

				<!-- /.panel-heading -->
				<div class="panel-body">
					    <!-- 필터링 섹션 -->
				    <form action="/adminmember/list" method="get" class="form-inline" style="margin-bottom:10px;">
				        <!-- <select name="category" class="form-control">
				            <option value="">카테고리</option>
				            <c:forEach var="cat" items="${categories}">
				                <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
				            </c:forEach>
				        </select> -->
				        <select name="auth" class="form-control">
						    <option value= "">회원구분[일반/관리자)</option>
						    <option value="MEMBER" <c:if test="${param.auth == 'MEMBER'}">selected</c:if>>일반</option>
						    <option value="ADMIN" <c:if test="${param.auth == 'ADMIN'}">selected</c:if>>관리자</option>
						</select>
				        <select name="is_deleted" class="form-control">
				            <option value= -1>계정상태[활성/비활성]</option>
				            <option value= 0 <c:if test="${param.is_deleted == 0}">selected</c:if>>활성</option>
				            <option value= 1 <c:if test="${param.is_deleted == 1}">selected</c:if>>비활성</option>				            
				        </select>
				        <select name="gender" class="form-control">
				            <option value= "">성별[남자/여자]</option>
				            <option value= 'M' <c:if test="${param.gender == 'M'}">selected</c:if>>남자</option>
				            <option value= 'F' <c:if test="${param.gender == 'F'}">selected</c:if>>여자</option>
				        </select>
				        <!-- <select name="is_deleted" class="form-control">
				            <option value= -1>노출여부</option>
				            <option value= 0 <c:if test="${param.is_deleted == 0}">selected</c:if>>노출</option>
				            <option value= 1 <c:if test="${param.is_deleted == 1}">selected</c:if>>비노출</option>
				        </select> -->
				        <button type="submit" class="btn btn-primary">필터</button>
				        <button type="button" class="btn btn-info" onclick="location.href='/adminmember/list'">필터 초기화</button>

				    </form>
				
				    <!-- 회원 테이블 -->
				    <table class="table table-bordered table-hover">
				        <thead>
				            <tr>
				                <th class="text-center">번호</th>
				                <th class="text-center">권한</th>
				                <th class="text-center">상태</th>				                
				                <th class="text-center">아이디</th>
				                <th class="text-center">이름</th>
				                <th class="text-center">주소</th>
				                <th class="text-center">휴대전화</th>
				                <th class="text-center">이메일</th>
				                <th class="text-center">성별</th>
				                <th class="text-center">sms수신</th>				                
				                <th class="text-center">정보3자제공</th>				                
				                <th class="text-center">정보처리위탁</th>
				                <th class="text-center">관리</th>
				            </tr>
				        </thead>

				        <tbody>
				            <c:forEach items="${list}" var="member">
				                <tr>
				                    <td class="text-center">${member.id}</td>
									<c:set var="isAdmin" value="false" />
									<c:forEach var="auth" items="${member.authList}">
									    <c:if test="${auth.role eq 'ADMIN'}">
									        <c:set var="isAdmin" value="true" />
									    </c:if>
									</c:forEach>
									
									<td class="text-center">
									    <c:choose>
									        <c:when test="${isAdmin}">
									            <span class="label label-success ml-1">관리자</span>
									        </c:when>
									        <c:otherwise>
									            일반
									        </c:otherwise>
									    </c:choose>
									</td>
									<td class="text-center">${member.isDeleted == 0 ? '<span class="label label-success ml-1">활성</span>' : '비활성'}</td>
									<td class="text-right">${member.customerId}</td>
				                    <td class="text-left">${member.customerName}
   					                    <!-- NEW 라벨: 3일 이내 등록 -->
					                    <c:if test="${member.createdAt.time + (1000*60*60*24*3) > now.time}">
					                        <span class="badge">NEW</span>
					                    </c:if>
					                </td>
				                    <td class="text-right">${member.address}</td>
				                    <td class="text-right">${member.phoneNumber}</td>
				                    <td class="text-right">${member.email}</td>
				                    <td class="text-center">${member.gender == 'M' ? '남자' : '여자'}</td>
				                    <td class="text-center">${member.agreeSms ==1 ? '<span class="label label-success ml-1">동의</span>' : '비동의'}</td>
				                    <td class="text-center">${member.agreeThirdParty ==1 ? '<span class="label label-success ml-1">동의</span>' : '비동의'}</td>
				                    <td class="text-center">${member.agreeDelegate ==1 ? '<span class="label label-success ml-1">동의</span>' : '비동의'}</td>
				                    <td>
				                        <button class="btn btn-sm btn-primary" onclick="location.href='/adminmember/modify?id=${member.id}'">수정</button>
				                        <c:choose>
				                            <c:when test="${member.isDeleted == 0}">
				                                <button class="btn btn-sm btn-warning softdel-btn" data-id="${member.id}" data-display="false">비활성</button>
				                            </c:when>
				                            <c:otherwise>
				                                <button class="btn btn-sm btn-success restore-btn" data-id="${member.id}" data-display="true">활성</button>
				                            </c:otherwise>
				                        </c:choose>
				                        <button class="btn btn-sm btn-danger harddel-btn" data-id="${member.id}">삭제</button>
				                    </td>
				                </tr>
				            </c:forEach>
				        </tbody>
				     </table>


					<!-- 검색조건 -->
					<div class='row'>
						<div class="col-lg-12">
							<form id='searchForm' action="/adminmember/list" method='get'>
								<select name='type' >
									<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>아이디</option>
									<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>이름</option>
									<option value="CN" <c:out value="${pageMaker.cri.type eq 'CN'?'selected':''}"/>>아이디 or 이름</option>
								</select>
								<input type='hidden' name='type' value="C" />
								<input type='hidden' name='type' value="N" />
								<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
								<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
								<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />

								
								<button type="submit" class="btn btn-sm btn-primary">
									<i class="fa fa-search"></i> 회원검색
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

					<form id='actionForm' action="/adminmember/list" method='get'>
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
				$(".modal-body").html("상품 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
	}
	
	$("#regBtn").on("click",function(){
		self.location = "/adminmember/register";
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
		actionForm.attr("action","/adminmember/modify");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e){
		//if(!searchForm.find("option:selected").val()){
		//	alert("검색종류를 선택하세요");
		//	return false;
		//}

		//if(!searchForm.find("input[name='keyword']").val()){
		//	alert("키워드를 입력하세요");
		//	return false;
		//}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
		
	});
    
	// 관리자용 버튼 이벤트
	$(document).on("click", ".edit-btn", function () {
	    const id = $(this).data("id");
	    window.location.href = "/adminmember/modify?id=" + id;
	});

	$(document).on("click", ".harddel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/harddel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 삭제 실패");
	            }
	        });
	    }
	});
	
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("계정이 비활성됩니다.")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/softdel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 비활성 실패");
	            }
	        });
	    }
	});

	$(document).on("click", ".restore-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("계정이 활성됩니다.")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/restore",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 활성 실패");
	            }
	        });
	    }
	});
    
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>