<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<style>
.uploadResult {
	width: 100%;
	background-color: lightgray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">신규 상품 등록(관리자)</h1>
		</div>
	</div>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">작성 후 등록 버튼을 클릭하세요.</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/notice/register" method="post" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

						<sec:authorize access="isAuthenticated()">
							<input type="hidden" name="createdBy"
								value='<sec:authentication property="principal.username"/>' />
							<input type="hidden" name="userId"
								value='<sec:authentication property="principal.member.id"/>' />
						</sec:authorize>
        
						<div class="form-group">
						    <label class="required">카테고리</label>
						    <div>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="원예용품" checked> 🪵 원예용품
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="식물키트모음"> 🪴 식물키트모음
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="허브키우기"> 🌿 허브키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="채소키우기"> 🥬 채소키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="꽃씨키우기"> 🌸 꽃씨키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="category" value="기타키우기키트"> 📦 기타키우기키트
						        </label>
						    </div>
						</div>
						<div class="form-group">
						    <label class="required">전시영역</label>
						    <div>
						        <label class="radio-inline">
						            <input type="checkbox" name="is_mainone" value="1"> 메인 1
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="is_maintwo" value="1"> 메인 2
						        </label>
						    </div>
						</div>
						
				        <div class="form-group">
				            <label class="required">상품명</label>
				            <input type="text" name="product_name" class="form-control" required>
				        </div>
				
				        <div class="form-group">
				            <label class="required">가격(원)</label>
				            <input type="number" name="product_price" class="form-control" required>
				        </div>
				
				        <div class="form-group">
					        <!-- 입반할인 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">일반할인</label>
							    <div class="col-sm-10">
							        <select id="is_discount" name="is_discount" class="form-control">
							            <option value="0">없음</option>
							            <option value="1">적용</option>
							        </select>
							    </div>
							</div>
							
							<!-- 일반 할인율 -->
							<div id="discount_fields" style="display: none;">
							    <div class="form-group row">
							        <label class="col-sm-2 col-form-label">▶ 일반 할인율(%)</label>
							        <div class="col-sm-10">
							            <input type="number" id="discount_rate" name="discount_rate" class="form-control" min="0" max="100">
							        </div>
							    </div>
							</div>
							
							<!-- 타임세일 여부 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">타임세일</label>
							    <div class="col-sm-10">
							        <select id="is_timesales" name="is_timesales" class="form-control">
							            <option value="0">없음</option>
							            <option value="1">적용</option>
							        </select>
							    </div>
							</div>
							
							<!-- 타임세일 할인율 -->
							<div id="timesales_fields" style="display: none;">
							    <div class="form-group row">
							        <label class="col-sm-2 col-form-label">▶ 타임세일 할인율(%)</label>
							        <div class="col-sm-10">
							            <input type="number" id="timesale_rate" name="timesale_rate" class="form-control" min="0" max="100">
							        </div>
							    </div>
							</div>
							
							<!-- 총 할인율 표시 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">총 할인율</label>
							    <div class="col-sm-10">
							        <input type="text" id="total_discountrate" class="form-control" readonly>
							    </div>
							</div>
							<!-- 최종 가격 표시 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">최종 할인가격</label>
							    <div class="col-sm-10">
							        <input type="text" id="final_price" class="form-control" readonly>
							    </div>
							</div>
						</div>
						
				        <div class="form-group">
				            <label>배송비(원)</label>
				            <input type="number" name="delivery_fee" value="3500" class="form-control">
				        </div>
				
				        <div class="form-group">
				            <label>발송기한(일)</label>
				            <input type="number" name="delivery_days" value="3" class="form-control">
				        </div>
				
						<div class="form-group">
						    <label>기초 재고수량(개)</label>
						    <input type="number" name="product_stock" id="product_stock" value="" class="form-control" min="0">
						</div>
						
						<div class="form-group">
						    <label>상품상태</label>
						    <select name="product_status" id="product_status" class="form-control">
						        <option value="0">판매중지</option>
						        <option value="1">정상</option>
						        <option value="2">품절</option>
						    </select>
						</div>				        
				        
				        <!--  <div class="form-group">
				            <label class="required">상품 이미지 (최대 10장)</label>
				            <input type="file" name="thumbnailImages" multiple accept="image/*">
				            <small>썸네일로 사용할 이미지는 체크하세요.</small><br>
				            <input type="checkbox" name="thumbnailCheck"> 썸네일 여부
				        </div>
				
				        <div class="form-group">
				            <label>상품설명 이미지 (최대 5장)</label>
				            <input type="file" name="detailImages" multiple accept="image/*">
				        </div> -->

						<!-- 업로드 영역 -->
						<div class="form-group">
							<label class="form-label" class="required"><strong>상품 이미지 (최대 10장)</strong></label>
							<!-- 설명 문구 -->
							<p class="text-muted small mb-2">
								※ 상품 이미지는 <strong>10개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일을 선택하려면 <strong>Ctrl 키</strong>를 누른 상태에서 클릭하세요.<br>
								※ <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded"
								style="background-color: #f8f9fa; border: 1px solid #ddd;">
								<input type="file" id="uploadInputThumbnail" name="thumbnailImages" multiple accept="image/*">
								<small>썸네일로 사용할 이미지는 체크하세요.</small><br>
								<ul id="uploadListThumbnail" class="list-group mt-2"></ul>
								<button id="uploadBtnThumbnail" class="btn btn-primary">업로드</button>
							</div>
						</div>
						<div class="form-group" class="required">
							<label class="form-label"><strong>상품상세정보 이미지 (최대 5장)</strong></label>
							<!-- 설명 문구 -->
							<p class="text-muted small mb-2">
								※ 상품상세정보 이미지는 <strong>5개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일을 선택하려면 <strong>Ctrl 키</strong>를 누른 상태에서 클릭하세요.<br>
								※ <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded"
								style="background-color: #f8f9fa; border: 1px solid #ddd;">
								<input type="file" id="uploadInputDetail" name="detailImages" multiple accept="image/*">
								<ul id="uploadListDetail" class="list-group mt-2"></ul>
								<button id="uploadBtnDetail" class="btn btn-primary">업로드</button>
							</div>
						</div>
						
						<input type="hidden" name="attachList" id="attachListJson"> 
						
						<div class="text-right mt-3">
							<button type="submit" class="btn btn-success">등록</button>
							<button type="reset" class="btn btn-warning">다시작성</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/js/upload_manager.js"></script>
<script type="text/javascript">
$(document).ready(function () {
  const csrfHeader = $("meta[name='_csrf_header']").attr("content");
  const csrfToken = $("meta[name='_csrf']").attr("content");
  
  var regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$", "i");
  var maxSize = 5242880; // 5MB

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
  
  
  document.querySelector("select[id='is_discount']").addEventListener("change", function () {
      const box = document.getElementById("discount_fields");
      const selected = this.value;
      box.style.display = (selected === "1") ? "block" : "none";
  });
  document.querySelector("select[id='is_timesales']").addEventListener("change", function () {
      const box = document.getElementById("timesales_fields");
      const selected = this.value;
      box.style.display = (selected === "1") ? "block" : "none";
  });
  
  
  const priceInput = document.querySelector('input[name="product_price"]');
  const discountSelect = document.getElementById('is_discount');
  const timesaleSelect = document.getElementById('is_timesales');
  const discountRateInput = document.getElementById('discount_rate');
  const timesaleRateInput = document.getElementById('timesale_rate');
  const totalRateInput = document.getElementById('total_discountrate');
  const finalPriceInput = document.getElementById('final_price');

  function toggleFields() {
      document.getElementById('discount_fields').style.display = discountSelect.value === "1" ? 'block' : 'none';
      document.getElementById('timesales_fields').style.display = timesaleSelect.value === "1" ? 'block' : 'none';
  }

  function calculateDiscount() {
      const price = parseFloat(priceInput.value) || 0;
      const discountRate = discountSelect.value === "1" ? (parseFloat(discountRateInput.value) || 0) : 0;
      const timesaleRate = timesaleSelect.value === "1" ? (parseFloat(timesaleRateInput.value) || 0) : 0;

      const totalRate = discountRate + timesaleRate;
      const finalPrice = Math.round(price * (1 - totalRate / 100));

      totalRateInput.value = totalRate + "%";
      finalPriceInput.value = finalPrice.toLocaleString() + "원";
  }
  
	  // 이벤트 연결
	  discountSelect.addEventListener('change', () => {
	      toggleFields();
	      calculateDiscount();
	  });
	
	  timesaleSelect.addEventListener('change', () => {
	      toggleFields();
	      calculateDiscount();
	  });
	
	  [priceInput, discountRateInput, timesaleRateInput].forEach(input => {
	      input.addEventListener('input', calculateDiscount);
	  });
	
	  // 재고수량 입력값 감지 후 상품상태 자동 변경
	  document.getElementById('product_stock').addEventListener('input', function() {
	    const stockValue = parseInt(this.value) || 0;
	    const statusSelect = document.getElementById('product_status');

	    if (stockValue > 0) {
	      statusSelect.value = "1";  // 정상
	    } else if (stockValue === 0) {
	      statusSelect.value = "2" ;  // 품절
	    } 
	  });
	  
	  // 페이지 로딩 후 초기화
	  toggleFields();
	  calculateDiscount();
  

  // 선택된 파일 리스트를 전역에서 관리
  let selectedImgsThumbnail = [];
  let selectedImgsDetail = [];
  let uploadedThumbnailList = []; // 썸네일 업로드 완료된 파일 정보
  let uploadedDetailList = []; // 상품상세정보 업로드 완료된 파일 정보
  let uploadCompletedThumbnail = false; // 썸네일 업로드 완료 여부 flag
  let uploadCompletedDetail = false; // 상품상세정보 업로드 완료 여부 flag

  // 업로드 버튼 처음에 숨김
  $("#uploadBtnThumbnail").hide(); 
  $("#uploadBtnDetail").hide(); 
  
  //파일 선택 시 UI 표시 및 배열에 저장
  $("#uploadInputThumbnail").on("change", function (e) {
    const files = Array.from(e.target.files);
    const maxFiles = 10; // 최대 10개 제한

    if (selectedFiles.length + files.length > maxFiles) {
      alert("❗ 최대 ${maxFiles}개까지 파일을 업로드할 수 있습니다.");
      $(this).val('');
      return;
    }

    files.forEach(file => {
      if (checkExtension(file.name, file.size)) {
        selectedFiles.push(file);
      }
    });
    
    if (selectedFiles.length > 0) {
        $("#uploadBtnThumbnail").show(); // 파일이 선택되면 보여줌
      }

    updateFileListUI();

    // input 초기화 (같은 파일 다시 선택할 경우에도 change 이벤트 발생하게 하기 위함)
    $(this).val('');
  });
  $("#uploadInputDetail").on("change", function (e) {
    const files = Array.from(e.target.files);
    const maxFiles = 5; // 최대 5개 제한
    
    if (selectedFiles.length + files.length > maxFiles) {
      alert("❗ 최대 ${maxFiles}개까지 파일을 업로드할 수 있습니다.");
      $(this).val('');
      return;
    }

    files.forEach(file => {
      if (checkExtension(file.name, file.size)) {
        selectedFiles.push(file);
      }
    });
    
    if (selectedFiles.length > 0) {
        $("#uploadBtnDetail").show(); // 파일이 선택되면 보여줌
      }

    updateFileListUI();

    // input 초기화 (같은 파일 다시 선택할 경우에도 change 이벤트 발생하게 하기 위함)
    $(this).val('');
  });

  // 업로드 버튼 클릭 시 실제 업로드
  $("#uploadBtnThumbnail").on("click", function (e) {
    e.preventDefault(); // 기본 submit 방지
    if(selectedFiles.length === 0){
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
      beforeSend: function (xhr) {
        if (csrfHeader && csrfToken) {
          xhr.setRequestHeader(csrfHeader, csrfToken);
        }
      },
      success: function (result) {
    	  
    	  console.log("Attatch result: " + result);
    	  console.log(JSON.stringify(result, null, 2));  // JSON 형식으로 보기 좋게 출력
    	  
    	  showUploadedFiles(result);
    	  uploadedThumbnailList = result;     // 업로드 완료된 파일 저장
    	  selectedImgsThumbnail = [];            // 선택 목록 초기화
    	  uploadCompletedThumbnail = true;        // 업로드 완료 플래그 true
    	  setAttachListJson(result);     // 숨은 input에 JSON으로 저장
    	  $("#uploadBtnThumbnail").hide(); // 업로드 후 숨김
    	}
    });
  });
  
  $("#uploadBtnDetail").on("click", function (e) {
    e.preventDefault(); // 기본 submit 방지
    if(selectedFiles.length === 0){
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
      beforeSend: function (xhr) {
        if (csrfHeader && csrfToken) {
          xhr.setRequestHeader(csrfHeader, csrfToken);
        }
      },
      success: function (result) {
    	  
    	  console.log("Attatch result: " + result);
    	  console.log(JSON.stringify(result, null, 2));  // JSON 형식으로 보기 좋게 출력
    	  
    	  showUploadedFiles(result);
    	  uploadedThumbnailList = result;     // 업로드 완료된 파일 저장
    	  selectedImgsThumbnail = [];            // 선택 목록 초기화
    	  uploadCompletedThumbnail = true;        // 업로드 완료 플래그 true
    	  setAttachListJson(result);     // 숨은 input에 JSON으로 저장
    	  $("#uploadBtnDetail").hide(); // 업로드 후 숨김
    	}
    });
  });
  

  // 미리보기 영역 업데이트
  function updateFileListUI() {
	  
    const list = $("#uploadListThumbnail");
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
        .addClass("btn btn-sm btn-danger ml-2")
        .text("삭제")
        .on("click", function () {
          selectedImgsThumbnail.splice(index, 1); // 배열에서 제거
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
	      .addClass("btn btn-danger btn-sm")
	      .text("삭제")
	      .hide() // 업로드 후 삭제버튼 숨김
	      .on("click", function () {
	        deleteFile(fileCallPath, obj.image ? "image" : "file", $(this).closest("li"));
	      });

	    li.append(content).append(delBtn);
	    list.append(li);
	  });
	}


  function deleteFile(fileName, type, liElement) {
    $.ajax({
      url: '/deleteFile',
      data: { fileName: fileName, type: type },
      type: 'POST',
      success: function (result) {
        liElement.remove();
      }
    });
  }
  
  function setAttachListJson(attachList) {
	  document.getElementById("attachListJson").value = JSON.stringify(attachList);
	}
  
  $("button[type='reset']").on("click", function() {
    if (uploadedFileList.length > 0) {
    	uploadedFileList.forEach(function (file) {
          const fileCallPath = encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/");
          const fileName = encodeURIComponent(file.fileName);
          const uuid = file.uuid;
          const data = { datePath: fileCallPath, fileName: fileName, uuid: uuid, type: file.image == 1 ? 'image' : 'file' };

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
	  $("#uploadInputThumbnail").val(''); // 파일 input 초기화 (필수)
	  $("#uploadInputDetail").val(''); // 파일 input 초기화 (필수)
	  $("#uploadBtnThumbnail").hide(); // 업로드 숨김
	  $("#uploadBtnDetail").hide(); // 업로드 숨김
	});
  
  // 등록 버튼 클릭 시 유효성 검사
  $("form").on("submit", function (e) {
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
  });

});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>

</html>