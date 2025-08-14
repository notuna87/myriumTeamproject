<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">수정 후 수정 버튼을 클릭하세요.</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<form role="form" action="/adminnotice/modify" method="post" enctype="multipart/form-data">
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
					      <textarea class="form-control" rows="3" name='content' style="resize:none; height:300px;">${notice.content}</textarea>
					</div>

					<div class="form-group">
					      <label>작성자</label> 
                          <input class="form-control" name='customerId' value="${notice.customerId}" readonly="readonly">
					</div>

                   <sec:authentication property="principal" var="pinfo"/>
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
								<li class="list-group">첨부파일이 없습니다.
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
						
					<input type="hidden" name="deleteUuids" id="deleteUuids">
					<input type="hidden" name="attachList" id="attachListJson" >
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
<!-- <script src="/resources/js/upload_manager.js"></script> -->
<script type="text/javascript">
$(document).ready(function () {
	
  let currentPage = "notice_modify";
	
  const csrfHeader = $("meta[name='_csrf_header']").attr("content");
  const csrfToken = $("meta[name='_csrf']").attr("content");
  
  var regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$", "i");
  var maxSize = 5242880; // 5MB
  
  // uploadedFile 갯수
  const uploadedCount = document.querySelectorAll(".uploadedFile").length;  
  console.log("uploadedCount:" + uploadedCount);
  
  function checkExtension(fileName, fileSize) {
    const fileSizeMB = (fileSize / (1024 * 1024)).toFixed(2);
    const maxSizeMB = (maxSize / (1024 * 1024)).toFixed(2);
    

    if (regex.test(fileName)) {
      alert("❗ 파일 [ " + fileName + " ]은 허용되지 않는 확장자입니다.");
      return false;
    }
    
    if (fileSize >= maxSize) {
      alert("❗ 파일이 [ " + fileName + " ]" + fileSizeMB + "MB 너무 큽니다. (허용 용량 : " + maxSizeMB + "MB)");
      return false;
    }
    
    return true;
  }
  
  // 선택된 파일 리스트를 전역에서 관리
  let selectedFiles = [];
  let uploadedFileList = []; // 업로드 완료된 파일 정보
  let uploadCompleted = false; // 업로드 완료 여부 flag

  
  // 업로드 버튼 처음에 숨김
  $("#uploadBtn").hide(); 
  
  //파일 선택 시 UI 표시 및 배열에 저장
  $("#uploadInput").on("change", function (e) {
    const files = Array.from(e.target.files);

    // 최대 3개 제한
    const totalCount = selectedFiles.length + document.querySelectorAll(".uploadedFile").length + files.length;
	    
    console.log("[uploadInput]totalCount:" + totalCount);
	    
    if (totalCount > 3) {
	       alert("❗ 최대 3개까지 파일을 업로드할 수 있습니다.");
	    $(this).val('');
	    return;
	  }

    files.forEach(file => {
      if (checkExtension(file.name, file.size)) {
        selectedFiles.push(file);
      }
    });
    
    if (selectedFiles.length > 0) {
        $("#uploadBtn").show(); // 파일이 선택되면 보여줌
      }

    updateFileListUI();

    // input 초기화 (같은 파일 다시 선택할 경우에도 change 이벤트 발생하게 하기 위함)
    $(this).val('');
  });

  // 업로드 버튼 클릭 시 실제 업로드
  $("#uploadBtn").on("click", function (e) {
    e.preventDefault(); // 기본 submit 방지
    if(selectedFiles.length === 0){
      alert("업로드할 파일을 먼저 선택해주세요.");
      return;
    }
    
    console.log("[uploadBtn]selectedFiles + uploadedFileList:" + (selectedFiles.length + document.querySelectorAll(".uploadedFile").length));
    
    if (selectedFiles.length + uploadedFileList.length > 3) {
    	  alert("❗ 최대 3개까지 파일을 업로드할 수 있습니다.");
    	  return;
    	}

    const formData = new FormData();
    selectedFiles.forEach(file => formData.append("uploadFile", file));

    $.ajax({
      url: '/uploadAjaxAction',
      processData: false,
      contentType: false,
      data: formData,
      type: 'POST',
      dataType: 'json',
      beforeSend: function (xhr) {
        if (csrfHeader && csrfToken) {
          xhr.setRequestHeader(csrfHeader, csrfToken);
        }
      },
      success: function (result) {
    	  
    	  console.log("Attatch result: " + result);
    	  console.log(JSON.stringify(result, null, 2));  // JSON 형식으로 보기 좋게 출력
    	  
    	  showUploadedFiles(result);
    	  uploadedFileList = uploadedFileList.concat(result); // 누적 저장 // 업로드 완료된 파일 저장
    	  selectedFiles = [];            // 선택 목록 초기화
    	  uploadCompleted = true;        // 업로드 완료 플래그 true
    	  setAttachListJson(result);     // 숨은 input에 JSON으로 저장
    	  $("#uploadBtn").hide(); // 업로드 후 숨김
    	}
    });
  });
  

  // 미리보기 영역 업데이트
  function updateFileListUI() {
	  
    const list = $("#uploadList");
    list.empty();

    selectedFiles.forEach((file, index) => {
      const li = $("<li>").addClass("list-group-item d-flex align-items-center justify-content-between");
      const content = $("<div>").addClass("d-flex align-items-center");

      // 이미지 파일이면 미리보기 생성
      if (file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = $("<img>").attr("src", e.target.result).css({
            width: "40px",
            height: "40px",
            objectFit: "cover",
            marginRight: "10px"
          });
          content.prepend(img);
        };
        reader.readAsDataURL(file);
      } else {
        content.append(
          $("<i>").addClass("fas fa-file-alt mr-2")
        );
      }

      content.append($("<span>").text(file.name));

      const delBtn = $("<button type='button'>")
        .addClass("btn btn-sm btn-danger delBtn")
        .text("삭제")
        .on("click", function () {
          selectedFiles.splice(index, 1); // 배열에서 제거
          updateFileListUI();             // UI 다시 그림
        });

      li.append(content).append(delBtn);
      list.append(li);
    });
  }

  function showUploadedFiles(uploadResultArr) {
	  const list = $("#uploadList");
	  list.empty();

	  uploadResultArr.forEach(obj => {
	    const fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/" + obj.uuid + "_" + obj.fileName);

	    const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");

	    const content = $("<div>").addClass("d-flex align-items-center");

	    if (obj.image) {
	      const thumbPath = "/display?fileName=" + encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
	      content.append(
	        $("<img>").attr("src", thumbPath).css({
	          width: "40px",
	          height: "40px",
	          objectFit: "cover",
	          marginRight: "10px"
	        })
	      );
	    } else {
	      content.append(
	        $("<i>").addClass("fas fa-file-alt mr-2")
	      );
	    }

	    content.append($("<span>").text(obj.fileName));

	    const delBtn = $("<button type='button'>")
	      .addClass("btn btn-danger btn-sm delBtn")
	      .text("삭제")
	      //.hide() // 업로드 후 삭제버튼 숨김
	      .on("click", function () {
	        deleteFile(obj.uploadPath, obj.fileName, obj.image ? "image" : "file", obj.uuid, $(this).closest("li"));
		    // 업로드 목록에서 제거 (UUID 기준)
		    uploadedFileList = uploadedFileList.filter(file => file.uuid !== obj.uuid);
		    setAttachListJson(uploadedFileList);
	      });
	    
	    li.append(content).append(delBtn);
	    list.append(li);
	  });
	}


  function deleteFile(fileCallPath, fileName, type, uuid, liElement) {
    $.ajax({
      url: '/deleteUploadedFile',
      data: { datePath: fileCallPath, fileName: fileName, uuid: uuid, type: type },
      type: 'POST',
      success: function (result) {
    	  console.log("delete - result:" + result);
        liElement.remove();
      }
    });
  }
  
  function setAttachListJson(attachList) {
	  document.getElementById("attachListJson").value = JSON.stringify(attachList);
	}
  
  $("button[type='reset']").on("click", function() {
	  confirm("주의❗ 모든 이미지가 삭제됩니다!");
    if (uploadedFileList.length > 0) {
    	uploadedFileList.forEach(function (file) {
          const fileCallPath = encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/");
          const fileName = encodeURIComponent(file.fileName);
          const uuid = file.uuid;
          const data = { datePath: fileCallPath, fileName: fileName, uuid: uuid, type: file.image == 1 ? 'image' : 'file', isUpdate: true, currentPage: currentPage };

          $.ajax({
            url: '/deleteUploadedFile',
            type: 'POST',
            data: data,
            beforeSend: function (xhr) {
              if (csrfHeader && csrfToken) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
              }
            },
            success: function () {
              console.log('삭제 성공:', fileCallPath);
            },
            error: function (xhr) {
              console.error('삭제 실패:', xhr.responseText);
            }
          });
        });
      }  	  
	  selectedFiles = [];       // 선택된 파일 배열 초기화
	  uploadCompleted = false;  // 업로드 완료 상태 초기화
	  uploadedFileList = [];    // 업로드된 파일 목록 초기화
	  $("#uploadList").empty(); // 업로드 리스트 UI 초기화
	  $("#uploadInput").val(''); // 파일 input 초기화 (필수)
	  $("#uploadBtn").hide(); // 업로드 후 숨김
	  setAttachListJson([]); // 숨은 필드 초기화
	});
  
  
  let deleteFileUuids = [];
  
  $(".remove-file-btn").on("click", function () {
	  const uuid = $(this).data("uuid");
	  // uploadedFileList 에서 제거
	  uploadedFileList = uploadedFileList.filter(file => file.uuid !== uuid);
	  setAttachListJson(uploadedFileList);
	  
	  deleteFileUuids.push(uuid);
	  $("#deleteUuids").val(deleteFileUuids.join(","));
	  $(this).closest("li").remove();
	});
  
  
  var formObj = $("form");
  
  // 등록 버튼 클릭 시 유효성 검사
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