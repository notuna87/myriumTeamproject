<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="../includes_admin/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_chat.css" />

<style type="text/css">
   table.table td, table.table th {
      vertical-align: middle !important;
      text-align: center;
  }
  
  table.table {
      font-size: 13px;
  }
</style>

<body>
<%@include file="../main/header.jsp"%>
<div style="width:1240px; margin:0 auto;">

	<div class="row">
         <div class="col-lg-12">
            <sec:authorize access="hasAuthority('ADMIN')">
            	<h1 class="page-header">문의사항 보기<span class="badge">관리자</span></h1>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
            	<h1 class="page-header">문의사항 보기</h1>
            </sec:authorize>
            
			<!-- 디버그용 로그인 및 권한 정보 -->
			<div>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.member" var="pminfo" />
				    <sec:authentication property="principal.authorities" var="roles" />
				    <!-- <c:out value="#debug - ${pminfo.customerName} / 권한 ${roles} ==> ADMIN만 답변글 클릭 가능, 답변버튼 노출" /></div>	-->
				</sec:authorize>
			</div>
			
        </div>
	</div>

	<!-- 문의사항 내용 및 상태 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<!-- 문의 상태 표시 -->
					<div>
						<span>이 문의는 현재</span>>
						<span>
					        <b>
					          <c:choose>
					            <c:when test="${board.isAnswered == 1}">
					              <span class="label label-success">답변완료</span>
					            </c:when>
					            <c:otherwise>
					              <span class="label label-default ">미답변</span>
					            </c:otherwise>
					          </c:choose>
					        </b>
					    </span>	
					    <span>상태입니다.</span>	
					</div>		
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label>No.</label> 
						<input class="form-control" name='id' value="${board.id}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name='title' value="${board.title}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name='content' readonly="readonly" style="resize:none;">${board.content}</textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name='customerId' value="${board.customerId}" readonly="readonly"/>
					</div>

					<!-- 현재 로그인 사용자 정보 -->
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.customerId}">
							<button type="button" class="btn btn-warning softdel-btn" data-id="${board.id}" data-customer-id="${board.customerId}">글내림</button>
						</c:if>
					</sec:authorize>

					<!-- 관리자용 수정 버튼 -->
					<sec:authorize access="hasAuthority('ADMIN')">
		            	<button data-oper='modify' class="btn btn-default">수정</button>
		            </sec:authorize>

					<button data-oper='list' class="btn btn-default btn-info">목록</button>

					<!-- 수정 폼 -->
					<form id='operForm' action="/adminboard/modify" method='get'>
						<input type='hidden' id="id" name='id' value='${board.id}'> 
						<input type='hidden' name='pageNum' value='${cri.pageNum}'> 
						<input type='hidden' name='amount' value='${cri.amount}'> 
						<input type='hidden' name='type' value='${cri.type}'>
						<input type='hidden' name='keyword' value='${cri.keyword}'>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 답변 채팅 패널 -->
	<div class='row'>
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> 채팅

					<!-- 답변/추가문의 버튼 (권한별) -->
					<sec:authorize access="hasAuthority('ADMIN')">
						<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>답변하기</button>
					</sec:authorize>
					<sec:authorize access="hasAuthority('MEMBER') and !hasAuthority('ADMIN')">
						<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>추가문의</button>
					</sec:authorize>
				</div>
				<div class="panel-body">
					<ul class="chat">
						<li class="left clearfix" data-rno="12">
							<div>
								<div class="header">
									<strong class="primary-font">관리자</strong> 
									<small id="currentDate" class="pull-right text-muted"></small>
									<p>아직 등록된 답변이 없습니다.</p>
								</div>
							</div>
						</li>
					</ul>
				</div>
				<div class="panel-footer"></div>
			</div>
		</div>
	</div>

	<!-- 새 답변 Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					
					<sec:authorize access="hasAuthority('ADMIN')">
					    <h4 class="modal-title" id="myModalLabel">답변 작성</h4>
					</sec:authorize>
					
					<sec:authorize access="hasAuthority('MEMBER') and !hasAuthority('ADMIN')">
					    <h4 class="modal-title" id="myModalLabel">추가 문의</h4>
					</sec:authorize>

				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>내용을 작성하세요</label>
						<textarea class="form-control" rows="3" name='reply' style="resize:none;"></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<sec:authorize access="isAuthenticated()">
							<span id="replyerspan" style="background-color: #e0e0e0" class="form-control"> 
								<c:out value="${pageContext.request.userPrincipal.name}" />
							</span>
						</sec:authorize>
					</div>
					<div class="form-group">
						<label>작성일시</label> 
						<input class="form-control" name='reply_date' value='2018-01-01 13:13' readonly />
					</div>
				</div>
				<div class="modal-footer">
					<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	// 현재 날짜 출력 (답변이 없을 경우)
    const now = new Date();
	const currentDate = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0') + '-' + String(now.getDate()).padStart(2, '0');
	document.getElementById('currentDate').textContent = currentDate;
	
	// 관리자 여부 플래그 (0 또는 1)
	var isAdmin = <sec:authorize access="hasAuthority('ADMIN')">1</sec:authorize><sec:authorize access="!hasAuthority('ADMIN')">0</sec:authorize>;
	
	var bnoValue = '${board.id}';
	var replyUL = $(".chat");
	
	console.log("게시글 번호(bnoValue):", bnoValue);
	console.log("채팅 리스트 요소(replyUL):", replyUL);
	
    // 답변 목록 첫 페이지 로드
	showList(1);
	
	/**
	 * 답변 목록 조회 함수
	 * @param {number} page 페이지 번호
	 */
	function showList(page){
	   replyService.getList({bno:bnoValue, page: page || 1 }, function(replyCnt, list) {

	   	    console.log("replyCnt (답변 개수):", replyCnt);
	   	    console.log("list (답변 목록):", list);
	   	    
	   	    if(page == -1){
	   	      pageNum = Math.ceil(replyCnt / 10.0);
	   	      showList(pageNum);
	   	      return;
	   	    }  
  
	      var str = "";
	      
	      if(!list || list.length === 0){
	          replyUL.html("");
	    	  return;
	      }
	      
	      for (var i = 0, len = list.length; i < len; i++) {
	    	  let isAdminReply = list[i].writer_is_admin == 1;
	    	  console.log("답변 작성자 권한 확인:", isAdminReply);

		      str += '<li class="' + (isAdminReply ? 'right' : 'left') +' clearfix" data-rno="' + list[i].rno + '">';
		      str += '  <div>';
		      str += '    <div class="header">';
		      str += '      <strong class="primary-font">[' + list[i].rno + '] ' + list[i].replyer + '</strong>';
		      str += '      <small class="text-muted">' + replyService.displayTime(list[i].reply_date) + '</small>';
		      str += '    </div>';
		      str += '    <p class="' + (isAdminReply ? 'admin-reply' : 'member-reply') + '">' + list[i].reply + '</p>';
		      str += '  </div>';
		      str += '</li>';
	      }
	      
	      replyUL.html(str);
	      showReplyPage(replyCnt);
	
		 }); 
	} 
	
	// 페이징 처리용 변수 및 함수
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	/**
	 * 페이징 UI 생성 함수
	 * @param {number} replyCnt 답변 총 개수
	 */
	function showReplyPage(replyCnt){
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        var active = pageNum == i? "active" : "";
	        str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul>";
	      console.log("페이징 HTML:", str);
	      replyPageFooter.html(str);
	}
	
	// 페이징 번호 클릭 이벤트
	replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("페이징 번호 클릭됨");
       
       var targetPageNum = $(this).attr("href");
       console.log("선택된 페이지 번호:", targetPageNum);
       
       pageNum = targetPageNum;
       showList(pageNum);
    }); 
	
	// 답변 작성 모달 관련 변수
	var modal = $(".modal");
	var modalInputReply = modal.find("textarea[name='reply']");
	var modalInputReplyer = modal.find("#replyerspan");
	var modalInputReplyDate = modal.find("input[name='reply_date']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	// 답변 작성 버튼 클릭 이벤트
	$("#addReplyBtn").on("click", function(e){
	  modal.find("textarea").val("");            // 입력 필드 초기화
	  modalInputReplyDate.closest("div").hide(); // 작성일 숨김
	  modal.find("button[id !='modalCloseBtn']").hide(); // 모든 버튼 숨김
	  modalRegisterBtn.show();                    // 등록 버튼만 표시
	  modal.modal("show");                        // 모달 오픈
	});
	
	// 답변 등록 처리
	modalRegisterBtn.on("click", function(e){
	    var reply = {
	          reply: modalInputReply.val(),
	          replyer: '${pinfo.username}',
	          bno: bnoValue,
	          customer_id: '${board.customerId}',
	          user_id: '${pminfo.id}',
	          writer_is_admin: isAdmin
	        };
	    console.log("등록할 답변 데이터:", reply);
	    
	    replyService.add(reply, function(result){
	      alert(result);
	      modal.find("textarea").val("");
	      modal.modal("hide");
	      
	      // 답변 상태 뱃지 변경
	      var badgeElement = $("span.label");
	      if (isAdmin == 1) {
	        badgeElement.removeClass("label-default").addClass("label-success").text("답변완료");
	      } else {
	        badgeElement.removeClass("label-success").addClass("label-default").text("미답변");
	      }
	      
	      showList(1);
	    });
	});
	
	// 답변 상세 조회 (관리자 전용)
	$(".chat").on("click", "li", function(e){
	    if (!isAdmin) {
		    alert("관리자만 답변 상세보기를 할 수 있습니다.");
		    return;
		}
	      
	    var rno = $(this).data("rno");
	    console.log("상세 조회할 답변 번호(rno):", rno);
	    replyService.get(rno, function(reply){
	        modalInputReply.val(reply.reply);
	        modalInputReplyer.val(reply.replyer);
	        modalInputReplyDate.val(replyService.displayTime(reply.reply_date)).attr("readonly","readonly");
	        modal.data("rno", reply.rno);
	        
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();
	        modal.modal("show");
	    });
	});
	
	// 답변 수정 처리
	modalModBtn.on("click", function(e){
	    var reply = {rno: modal.data("rno"), reply: modalInputReply.val(), updated_by: '${board.customerId}'};
	    console.log("수정할 답변 데이터:", reply);
	    replyService.update(reply, function(result){
	      alert(result);
	      modal.modal("hide");
	      showList(pageNum);
	    });
	});
	
	// 답변 삭제 처리 (소프트 삭제)
	modalRemoveBtn.on("click", function(e){
  	  var rno = modal.data("rno");
  	  console.log("삭제할 답변 번호:", rno);
  	  replyService.softdel(rno, function(result){
  	      alert(result);
  	      modal.modal("hide");
  	      showList(pageNum);
  	  });
	});
	
	// 모달 닫기 버튼
	$('#modalCloseBtn').on('click', function() {      
	    $('#myModal').modal('hide');
	});
});
</script>

<script type="text/javascript">
$(document).ready(function() {
    var operForm = $("#operForm");

    $("button[data-oper='modify']").on("click", function(e) {
      operForm.attr("action", "/adminboard/modify").submit();
    });
    
    $("button[data-oper='list']").on("click", function(e) {
      operForm.find("#id").remove();
      operForm.attr("action", "/adminboard/list");
      operForm.submit();
    });
    
	// 글내림 버튼 클릭 이벤트 (글 숨기기, soft delete)
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    const customerId = $(this).data("customer-id");
	    if (confirm("글이 노출되지 않습니다.")) {
	        $.ajax({
	            type: "post",
	            url: "/adminboard/softdel",
	            data: { 
	            	id: id,
	            	customerId: customerId
	            },
	            success: function () {
	                window.location.href = "/adminboard/list";
	            },
	            error: function () {
	                alert("글내림 실패");
	            }
	        });
	    }
	});
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>
