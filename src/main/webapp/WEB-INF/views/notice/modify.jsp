<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %> 

<body>

<div class="row">
     <div class="col-lg-12">
        <sec:authorize access="hasAuthority('ADMIN')">
        	<h1 class="page-header">공지사항 수정(관리자)</h1>
        </sec:authorize>
        <sec:authorize access="!hasAuthority('ADMIN')">
        	<h1 class="page-header">공지사항 수정</h1>
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
				<form role="form" action="/notice/modify" method="post" enctype="multipart/form-data">
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
                           <input class="form-control" name='id' value="${notice.id}" readonly="readonly">
					</div>

					<div class="form-group">
					      <label>제목</label> 	
                      	  <input class="form-control" name='title' value="${notice.title}">
					</div>

					<div class="form-group">
		                  <label>내용</label>
					      <textarea class="form-control" rows="3" name='content'>${notice.content}</textarea>
					</div>

					<div class="form-group">
					      <label>작성자</label> 
                          <input class="form-control" name='customerId' value="${notice.customerId}" readonly="readonly">
					</div>

                    <sec:authentication property="principal" var="pinfo"/>	
                    <!--  <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
	     			 <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button> --> 

                   <sec:authentication property="principal" var="pinfo"/>
                    <!--<sec:authorize access="isAuthenticated()">
                      <c:if test="${pinfo.username eq notice.customerId}">
                        <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                        <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                      </c:if>
                    </sec:authorize> -->                   

					<c:choose>
						<c:when test="${not empty attachFiles}">
							<div class="form-group">
						        <label>첨부파일</label>
						        <ul class="list-group uploadList">
						            <c:forEach items="${attachFiles}" var="file">
						                <li class="list-group-item uploadedFile">
						                    <!-- <a href="/download?uuid=${file.uuid}&path=${fn:replace(file.uploadPath, '\\', '/')}&filename=${file.fileName}">
											    ${file.fileName}
											</a> -->
											<a href="/download?uuid=${file.uuid}&path=${fn:replace(file.uploadPath, '\\', '/')}&filename=${file.fileName}">
											    ${file.fileName}
											</a>
											<button type="button" id="fileDeleteBtn" class="btn btn-xs btn-danger remove-file-btn" data-uuid="${file.uuid}">삭제</button>
						                </li>
						            </c:forEach>
						        </ul>
						    </div>
						</c:when>
						<c:otherwise>
						<div class="form-group">
						        <label>첨부파일</label>
							<ul class="list-group uploadList">
								<li class="list-group">첨부파일이 없습니다.</span>
							</ul>
							 </div>
						</c:otherwise>
					</c:choose>
					
					
						<!-- 업로드 영역 -->
						<div class="form-group">
							<label class="form-label"><strong>첨부파일 업로드</strong></label>

							<!-- 설명 문구 -->
							<p class="text-muted small mb-2">
								※ 파일은 <strong>3개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일을 선택하려면 <strong>Ctrl 키</strong>를 누른 상태에서 클릭하세요.<br>
								※ 첨부파일은 <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded"
								style="background-color: #f8f9fa; border: 1px solid #ddd;">
								<input type="file" id="uploadInput" multiple>
								<ul id="uploadList" class="list-group mt-2"></ul>
								<button id="uploadBtn" class="btn btn-primary">업로드</button>
							</div>
						</div>
						
					<input type="hidden" name="deleteFiles" id="deleteFiles">
					<input type="hidden" name="attachListJson" id="attachListJson" >


                   <div class="text-right mt-3">
	   					<sec:authorize access="hasAuthority('ADMIN')">
			            	<button type="submit" data-oper='modify' class="btn btn-success">등록</button>
	                        <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
			            </sec:authorize>	
						<button type="submit" data-oper='list' class="btn btn-info">목록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<!-- <script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form");
	
	// 수정/삭제/목록 버튼 처리
	$("button").on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
				formObj.attr("action", "/notice/harddel"); // 소프트 삭제 => softdel, 하드(영구) 삭제 => harddel 
			}
		}else if(operation === 'list'){
			formObj.attr("action", "/notice/list").attr("method", "get");
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
	
	// 기존 파일 삭제 처리
    let deletedFile = [];
    $(".remove-file-btn").on("click", function () {
        const uuid = $(this).data("uuid");
        const fileName = $(this).data("fileName");
        const uuidFileName = uuid + "_" + fileName;        
        deletedFile.push(uuidFileName);
        $(this).closest("li").remove();
        $("#deleteFiles").val(deletedFile.join(","));
    });

    // 파일 추가 제한 (최대 3개)
    $("#add-file-btn").on("click", function () {
        const current = $(".uploadedFile").length;
        const currentNew = $(".upload-file").length;
        const total = current + currentNew;

        if (total >= 3) {
            alert("최대 3개의 파일만 업로드 가능합니다.");
            return;
        }

        $("#new-file-inputs").append('<input type="file" name="uploadFiles" class="form-control upload-file">');
    });
    
    



});
	
</script> -->

    <!-- ====================================================== -->
  <!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/js/upload_manager.js"></script>
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
      const uploadManager = new UploadManager({
        uploadInputSelector: '#uploadInput',
        uploadListSelector: '#uploadList',
        uploadBtnSelector: '#uploadBtn',
        fileDeleteBtnSelector: '#fileDeleteBtn',
        attachListJsonSelector: '#attachListJson',
        maxFiles: 3,
        uploadUrl: '/uploadAjaxAction',
        deleteUrl: '/deleteFile',
		generateThumbnail: false
      });
    });
  </script>
  
  
</body>

<%@include file="../includes_admin/footer.jsp" %> 
<%@include file="../main/footer.jsp"%>