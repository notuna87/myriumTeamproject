<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %> 

<body>
<div style="width:1240px; margin:0 auto;">
    <div class="row">
        <div class="col-lg-12">
            <sec:authorize access="hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항 수정<span class="badge">관리자</span></h1>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항 수정</h1>
            </sec:authorize>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">수정 후 수정 버튼을 클릭하세요.</div>
                <div class="panel-body">
                    <form id="noticeForm" role="form" action="/adminnotice/modify" method="post" enctype="multipart/form-data">
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
                            <input class="form-control" name='id' value="${notice.id}" readonly>
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
                            <input class="form-control" name='customerId' value="${notice.customerId}" readonly>
                        </div>

                        <!-- 첨부파일 -->
                        <c:choose>
                            <c:when test="${not empty attachFiles}">
                                <div class="form-group">
                                    <label>첨부파일</label>
                                    <ul class="list-group uploadList">
                                        <c:forEach items="${attachFiles}" var="file">
                                            <li class="list-group-item uploadedFile">
                                                <a href="/download?uuid=${file.uuid}&path=${fn:replace(file.uploadPath, '\\', '/')}&filename=${file.fileName}">
                                                    ${file.fileName}
                                                </a>
                                                <button type="button" class="btn btn-xs btn-danger remove-file-btn" data-uuid="${file.uuid}">삭제</button>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="form-group">
                                    <label>첨부파일</label>
                                    <ul class="list-group uploadList">
                                        <li class="list-group-item">첨부파일이 없습니다.</li>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- 파일 업로드 영역 -->
                        <div class="form-group">
                            <label class="form-label"><strong>첨부파일 업로드</strong></label>
                            <p class="text-muted small mb-2">
                                ※ 파일은 <strong>3개</strong> 까지 업로드 가능.<br>
                                ※ Ctrl 키를 누른 상태에서 여러 파일 선택 가능.<br>
                                ※ 등록 전에 반드시 업로드하세요.
                            </p>
                            <div class="upload-box p-3 rounded" style="background-color: #f8f9fa; border: 1px solid #ddd;">
                                <input type="file" id="uploadInput" multiple>
                                <ul id="uploadList" class="list-group mt-2"></ul>
                                <button id="uploadBtn" class="btn btn-primary" style="display:none;">업로드</button>
                            </div>
                        </div>

                        <input type="hidden" name="deleteUuids" id="deleteUuids">
                        <input type="hidden" name="attachList" id="attachListJson">
                        <input type="hidden" name="userId" value="${notice.userId}">

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
</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(function () {

	let uploadedFileList = [];
    let selectedFiles = [];    
    let uploadCompleted = false;
    let deleteFileUuids = [];

    console.log("공지사항 수정 페이지 로드");

    function updateFileListUI() {
        const list = $("#uploadList").empty();
        selectedFiles.forEach((file, idx) => {
            const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");
            li.text(file.name);
            const btn = $("<button>").addClass("btn btn-sm btn-danger").text("삭제").on("click", function(){
                selectedFiles.splice(idx,1);
                updateFileListUI();
            });
            li.append(btn);
            list.append(li);
        });
    }

    $("#uploadInput").on("change", function(e){
        const files = Array.from(e.target.files);
        if(files.length + selectedFiles.length + $(".uploadedFile").length > 3){
            alert("❗ 최대 3개까지 업로드 가능");
            $(this).val('');
            return;
        }
        selectedFiles.push(...files);
        updateFileListUI();
        $("#uploadBtn").show();
        $(this).val('');
        console.log("선택된 파일:", selectedFiles.map(f=>f.name));
    });

    $("#uploadBtn").on("click", function(e){
        e.preventDefault();
        if(selectedFiles.length===0){ alert("업로드할 파일 선택 필요"); return; }

        const formData = new FormData();
        selectedFiles.forEach(f=>formData.append("uploadFile",f));

        $.ajax({
            url:'/uploadAjaxAction',
            processData:false,
            contentType:false,
            data:formData,
            type:'POST',
            dataType:'json',
            success:function(result){
                console.log("업로드 완료:", result);
                uploadedFileList = uploadedFileList.concat(result);
                selectedFiles = [];
                uploadCompleted = true;
                $("#uploadBtn").hide();
                $("#attachListJson").val(JSON.stringify(uploadedFileList));
            }
        });
    });

    $(".remove-file-btn").on("click", function(){
        const uuid = $(this).data("uuid");
        uploadedFileList = uploadedFileList.filter(f=>f.uuid!==uuid);
        $("#attachListJson").val(JSON.stringify(uploadedFileList));
        deleteFileUuids.push(uuid);
        $("#deleteUuids").val(deleteFileUuids.join(","));
        $(this).closest("li").remove();
        console.log("첨부파일 삭제:", uuid);
    });

//    $("form button[type=submit]").on("click", function(e){
//        const op = $(this).data("oper");
//        console.log("버튼 클릭 operation:", op);

//        if(op==='remove' && !confirm("삭제 후 복구 불가.")){ e.preventDefault(); return; }
//        if(op==='list'){ 
//            e.preventDefault(); 
//            $("#noticeForm").attr("action","/adminnotice/list").attr("method","get").submit();
//        }
        // 제목/내용 체크
//        const title = $("input[name='title']").val().trim();
//        const content = $("textarea[name='content']").val().trim();
//        if(!title){ alert("제목 필요"); e.preventDefault(); return; }
//        if(!content){ alert("내용 필요"); e.preventDefault(); return; }
//        if(selectedFiles.length>0 && !uploadCompleted){ alert("파일 업로드 먼저"); e.preventDefault(); return; }
//    });
    
    // 등록 버튼 클릭 시 유효성 검사
    var formObj = $("form");
    $("form button[type=submit]").on("click", function (e) {
  	  
  	const title = $("input[name='title']").val().trim();
      const content = $("textarea[name='content']").val().trim();

      if (!title) {
        alert("제목을 입력해주세요.");
        $("input[name='title']").focus();
        e.preventDefault();
        return;
      }

      if (!content) {
        alert("내용을 입력해주세요.");
        $("textarea[name='content']").focus();
        e.preventDefault();
        return;
      }

      // 파일이 선택된 경우 업로드 완료 여부 체크
      if (selectedFiles.length > 0 && !uploadCompleted) {
        alert("파일 업로드를 먼저 완료해주세요.");
        e.preventDefault();
        return;
      }
      
  	e.preventDefault();
  	
  	  const operation = $(this).data("oper");
  	
  	console.log(operation);
  	
  	if(operation === 'remove'){
  		if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
  			formObj.attr("action", "/adminnotice/harddel"); // 소프트 삭제 => softdel, 하드(영구) 삭제 => harddel 
  		}
  	}else if(operation === 'list'){
  		formObj.attr("action", "/adminnotice/list").attr("method", "get");
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
