<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes_admin/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<style>
.uploadResult { width: 100%; background-color: lightgray; }
.uploadResult ul { display: flex; flex-flow: row; justify-content: center; align-items: center; }
.uploadResult ul li { list-style: none; padding: 10px; }
.uploadResult ul li img { width: 100px; }
</style>
</head>
<body>
<%@include file="../main/header.jsp"%>
<div style="width:1240px; margin:0 auto;">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">공지사항 등록<span class="badge">관리자</span></h1>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">작성 후 등록 버튼을 클릭하세요.</div>
				<div class="panel-body">
					<form role="form" action="/adminnotice/register" method="post" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<sec:authorize access="isAuthenticated()">
							<input type="hidden" name="createdBy" value='<sec:authentication property="principal.username"/>' />
							<input type="hidden" name="userId" value='<sec:authentication property="principal.member.id"/>' />
						</sec:authorize>

						<div class="form-group">
							<label>제목</label>
							<input class="form-control" name='title'>
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="10" name='content' style="resize : none;"></textarea>
						</div>

						<div class="form-group">
							<label>작성자</label>
							<input class="form-control" name="customerId"
								value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label class="form-label"><strong>첨부파일 업로드</strong></label>
							<p class="text-muted small mb-2">
								※ 파일은 <strong>3개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일 선택 시 <strong>Ctrl 키</strong>를 누르고 클릭하세요.<br>
								※ 첨부파일은 <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded" style="background-color: #f8f9fa; border: 1px solid #ddd;">
								<input type="file" id="uploadInput" multiple>
								<ul id="uploadList" class="list-group mt-2"></ul>
								<button id="uploadBtn" class="btn btn-primary">업로드</button>
							</div>
						</div>
						
						<input type="hidden" name="attachList" id="attachListJson"> 
						
						<div class="text-right mt-3">
							<button type="submit" class="btn btn-success">등록</button>
							<button type="button" class="btn btn-info" id="listBtn">목록</button>
							<button type="reset" class="btn btn-warning" id="resetBtn">다시작성</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
  const csrfHeader = $("meta[name='_csrf_header']").attr("content");
  const csrfToken = $("meta[name='_csrf']").attr("content");
  
  const regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$", "i");
  const maxSize = 5242880; // 5MB
  let selectedFiles = [];
  let uploadedFileList = [];
  let uploadCompleted = false;

  $("#uploadBtn").hide();

  function checkExtension(fileName, fileSize) {
    if (regex.test(fileName)) {
      alert(`❗ 파일 [ ${fileName} ]은 허용되지 않는 확장자입니다.`);
      return false;
    }
    if (fileSize >= maxSize) {
      const sizeMB = (fileSize / (1024*1024)).toFixed(2);
      const maxMB = (maxSize / (1024*1024)).toFixed(2);
      alert(`❗ 파일 [ ${fileName} ]이 ${sizeMB}MB 너무 큽니다. (허용 용량: ${maxMB}MB)`);
      return false;
    }
    return true;
  }

  $("#uploadInput").on("change", function (e) {
    const files = Array.from(e.target.files);
    if (selectedFiles.length + files.length > 3) {
      alert("❗ 최대 3개까지 파일을 업로드할 수 있습니다.");
      $(this).val('');
      return;
    }

    files.forEach(file => {
      if (checkExtension(file.name, file.size)) {
        selectedFiles.push(file);
        console.log("선택 파일 추가:", file.name);
      }
    });
    
    if (selectedFiles.length > 0) $("#uploadBtn").show();
    updateFileListUI();
    $(this).val('');
  });

  $("#uploadBtn").on("click", function (e) {
    e.preventDefault();
    if (selectedFiles.length === 0) {
      alert("업로드할 파일을 먼저 선택해주세요.");
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
      beforeSend: xhr => {
        if (csrfHeader && csrfToken) xhr.setRequestHeader(csrfHeader, csrfToken);
      },
      success: function (result) {
        console.log("업로드 성공:", JSON.stringify(result, null, 2));
        uploadedFileList = result;
        selectedFiles = [];
        uploadCompleted = true;
        setAttachListJson(result);
        $("#uploadBtn").hide();
        showUploadedFiles(result);
      }
    });
  });

  function updateFileListUI() {
    const list = $("#uploadList");
    list.empty();
    selectedFiles.forEach((file, idx) => {
      const li = $("<li>").addClass("list-group-item d-flex align-items-center justify-content-between");
      const content = $("<div>").addClass("d-flex align-items-center");
      if (file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = e => content.prepend($("<img>").attr("src", e.target.result).css({ width:"40px", height:"40px", objectFit:"cover", marginRight:"10px" }));
        reader.readAsDataURL(file);
      } else content.append($("<i>").addClass("fas fa-file-alt mr-2"));
      content.append($("<span>").text(file.name));

      const delBtn = $("<button type='button'>").addClass("btn btn-sm btn-danger ml-2").text("삭제")
        .on("click", () => {
          console.log("선택 파일 삭제:", file.name);
          selectedFiles.splice(idx, 1);
          updateFileListUI();
        });

      li.append(content).append(delBtn);
      list.append(li);
    });
  }

  function showUploadedFiles(uploadResultArr) {
    const list = $("#uploadList");
    list.empty();
    uploadResultArr.forEach(obj => {
      const filePath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/" + obj.uuid + "_" + obj.fileName);
      const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");
      const content = $("<div>").addClass("d-flex align-items-center");
      if (obj.image) {
        const thumbPath = "/display?fileName=" + encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
        content.append($("<img>").attr("src", thumbPath).css({ width:"40px", height:"40px", objectFit:"cover", marginRight:"10px" }));
      } else content.append($("<i>").addClass("fas fa-file-alt mr-2"));
      content.append($("<span>").text(obj.fileName));

      const delBtn = $("<button type='button'>").addClass("btn btn-danger btn-sm").text("삭제")
        .on("click", () => deleteFile(filePath, obj.image ? "image" : "file", li));
      li.append(content).append(delBtn);
      list.append(li);
    });
  }

  function deleteFile(fileName, type, liElement) {
    $.ajax({
      url: '/deleteFile',
      type: 'POST',
      data: { fileName, type },
      success: function () {
        console.log("삭제 성공:", fileName);
        liElement.remove();
      },
      error: function (xhr) { console.error("삭제 실패:", xhr.responseText); }
    });
  }

  function setAttachListJson(list) {
    $("#attachListJson").val(JSON.stringify(list));
    console.log("attachListJson 설정:", JSON.stringify(list));
  }

  $("button[type='reset']").on("click", function() {
    console.log("리셋 버튼 클릭됨, 업로드 초기화");
    uploadedFileList.forEach(file => {
      const filePath = encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/");
      deleteFile(filePath + file.fileName, file.image ? "image" : "file", $("<li>"));
    });
    selectedFiles = [];
    uploadedFileList = [];
    uploadCompleted = false;
    $("#uploadList").empty();
    $("#uploadInput").val('');
    $("#uploadBtn").hide();
    setAttachListJson([]);
  });

  $("form").on("submit", function (e) {
    const title = $("input[name='title']").val().trim();
    const content = $("textarea[name='content']").val().trim();
    if (!title || !content || (selectedFiles.length > 0 && !uploadCompleted)) {
      alert(!title ? "제목을 입력해주세요." : !content ? "내용을 입력해주세요." : "파일 업로드를 완료해주세요.");
      e.preventDefault();
      return;
    }
    console.log("폼 제출, 제목:", title, "내용 길이:", content.length);
  });
  
  document.getElementById("listBtn").addEventListener("click", function() {
	    window.history.back();
	  });  


});
</script>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>
</body>
</html>
