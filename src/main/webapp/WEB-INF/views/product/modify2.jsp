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
			<h1 class="page-header">상품정보 수정(관리자)</h1>
		</div>
	</div>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">(※) 표시는 필수 입력사항입니다.</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/product/modify" method="post" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

						<sec:authorize access="isAuthenticated()">
							<input type="hidden" name="updated_by"
								value='<sec:authentication property="principal.username"/>' />
							<input type="hidden" name="created_by"
								value='<sec:authentication property="principal.username"/>' />
							<input type="hidden" name="userId"
								value='<sec:authentication property="principal.member.id"/>' />
							<input type="hidden" name="id" value="${product.id}" />
						</sec:authorize>
        
						<div class="form-group">
						    <label class="required">(※)카테고리</label>
						    <div>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="gardening" value="1" ${category.gardening ==1 ? 'checked' : ''}> 🧰 원예용품
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="plantkit" value="1" ${category.plantkit ==1 ? 'checked' : ''}> 🌱 식물키트모음
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="hurb" value="1" ${category.hurb ==1 ? 'checked' : ''}> 🌿 허브키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="vegetable" value="1" ${category.vegetable ==1 ? 'checked' : ''}> 🥬 채소키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="flower" value="1" ${category.flower ==1 ? 'checked' : ''}> 🌸 꽃씨키우기
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" class="category" name="etc" value="1" ${category.etc ==1 ? 'checked' : ''}> 📦 기타키우기키트
						        </label>
						    </div>
						</div>
						
						<!-- <input type="hidden" name="category" id="selectedCategory"> -->
						
						<div class="form-group">
						    <label class="required">전시영역</label>
						    <div>
						        <label class="radio-inline">
						            <input type="checkbox" name="is_mainone" value="1" ${product.is_mainone ==1 ? 'checked' : ''}> 메인 1
						        </label>
						        <label class="radio-inline">
						            <input type="checkbox" name="is_maintwo" value="1" ${product.is_maintwo ==1 ? 'checked' : ''}> 메인 2
						        </label>
						    </div>
						</div>
						
				        <div class="form-group">
				            <label class="required">(※)상품명</label>
				            <input type="text" name="product_name" class="form-control" value="${product.product_name}">
				        </div>
				        
				        <div class="form-group">
				            <label class="required">상품부제(설명)</label>
				            <input type="text" name="product_content" class="form-control" value="${product.product_content}">
				        </div>
				
				        <div class="form-group">
				            <label class="required">(※)가격(원)</label>
				            <input type="number" name="product_price" class="form-control" value="${product.product_price}">
				        </div>
				
				        <div class="form-group">
					        <!-- 입반할인 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">일반할인</label>
							    <div class="col-sm-10">
							        <select id="is_discount" name="is_discount" class="form-control" >
							            <option value="0" ${product.is_discount ==0 ? 'selected' : ''}>없음</option>
							            <option value="1" ${product.is_discount ==1 ? 'selected' : ''}>적용</option>
							        </select>
							    </div>
							</div>
							
							<!-- 일반 할인율 -->
							<div id="discount_fields" style="display: none;">
							    <div class="form-group row">
							        <label class="col-sm-2 col-form-label">▶ 일반 할인율(%)</label>
							        <div class="col-sm-10">
							            <input type="number" id="discount_rate" name="discount_rate" value="${product.discount_rate}" class="form-control" min="0" max="100">
							        </div>
							    </div>
							</div>
							
							<!-- 타임세일 여부 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">타임세일</label>
							    <div class="col-sm-10">
							        <select id="is_timesales" name="is_timesales" class="form-control">
							            <option value="0" ${product.is_timesales ==0 ? 'selected' : ''}>없음</option>
							            <option value="1" ${product.is_timesales ==1 ? 'selected' : ''}>적용</option>
							        </select>
							    </div>
							</div>
							
							<!-- 타임세일 할인율 -->
							<div id="timesales_fields" style="display: none;">
							    <div class="form-group row">
							        <label class="col-sm-2 col-form-label">▶ 타임세일 할인율(%)</label>
							        <div class="col-sm-10">
							            <input type="number" id="timesalediscount_rate" name="timesalediscount_rate" value="${product.timesalediscount_rate}" class="form-control" min="0" max="100">
							        </div>
							    </div>
							</div>
							
							<!-- 총 할인율 표시 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">총 할인율(%)</label>
							    <div class="col-sm-10">
							        <input type="text" id="total_discountrate" name="total_discountrate" class="form-control" readonly>
							    </div>
							</div>
							<!-- 최종 가격 표시 -->
							<div class="form-group row">
							    <label class="col-sm-2 col-form-label">최종 할인가격(원)</label>
							    <div class="col-sm-10">
							        <input type="text" id="discount_price" name="discount_price" class="form-control" readonly>
							    </div>
							</div>
						</div>
						
				        <div class="form-group">
				            <label>(※)배송비(원)</label>
				            <input type="number" name="delivery_fee" value="3500" class="form-control">
				        </div>
				
				        <div class="form-group">
				            <label>(※)발송기한(일)</label>
				            <input type="number" name="delivery_days" value="3" class="form-control">
				        </div>
				
						<div class="form-group">
						    <label>(※)기초재고수량(개)</label>
						    <input type="number" name="product_stock" id="product_stock" value="${product.product_stock}" class="form-control" min="0">
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
							<button type='button' id="editBtnThumbnail" class="btn btn-success ml-2">수정</button>
							<label class="form-label"><h4><strong>상품 이미지 (최대 10장)</strong></h4></label>
							<!-- 설명 문구 -->
							<p class="text-muted small mb-2">
								※ 상품 이미지는 <strong>10개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일을 선택하려면 <strong>Ctrl 키</strong>를 누른 상태에서 클릭하세요.<br>
								※ <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded"
								style="background-color: #f8f9fa; border: 1px solid #fff;">
								<input type="file" id="uploadInputThumbnail" name="thumbnailImages" multiple accept="image/*">
								<small>대표이미지를 체크하세요.</small><br>
								<ul id="uploadListThumbnail" class="list-group mt-2"></ul>
								<button id="uploadBtnThumbnail" class="btn btn-primary">업로드</button>
								<button id="cancelBtnThumbnail" class="btn btn-dark">취소</button>
							</div>
						</div>
						<div class="form-group">
							<button type='button' id="editBtnDetail" class="btn btn-success ml-2">수정</button>
							<label class="form-label"><h4><strong>상품상세정보 이미지 (최대 5장)</strong></h4></label>
							<!-- 설명 문구 -->
							<p class="text-muted small mb-2">
								※ 상품상세정보 이미지는 <strong>5개</strong> 까지 업로드할 수 있습니다.<br>
								※ 여러 파일을 선택하려면 <strong>Ctrl 키</strong>를 누른 상태에서 클릭하세요.<br>
								※ <strong>등록 전에 반드시 업로드</strong>해야 합니다.
							</p>

							<div class="upload-box p-3 rounded"
								style="background-color: #f8f9fa; border: 1px solid #fff;">
								<input type="file" id="uploadInputDetail" name="detailImages" multiple accept="image/*">
								<ul id="uploadListDetail" class="list-group mt-2"></ul>
								<button id="uploadBtnDetail" class="btn btn-primary">업로드</button>
								<button id="cancelBtnDetail" class="btn btn-dark">취소</button>
							</div>
						</div>
						
						<input type="hidden" name="attachList" id="attachListJson">
						
						<div class="text-right mt-3">
							<button type="submit" class="btn btn-success">등록</button>
							<button type="reset" class="btn btn-warning" id="resetBtn">다시작성</button>
						</div>
						
						<ul id="uploadListThumbnail" class="list-group mt-3"></ul>
						<ul id="uploadListDetail" class="list-group mt-3"></ul>
						
					</form>
				</div>
			</div>
		</div>
	</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/js/RegisterUploadManager.js"></script>
<script src="/resources/js/PreviewUploader.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	
	let currentPage = "modify";
	
	let isSubmitting = false;  // 제출 여부를 추적하는 플래그
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const csrfToken = $("meta[name='_csrf']").attr("content");
	
	const priceInput = document.querySelector('input[name="product_price"]');
	const discountSelect = document.getElementById('is_discount');
	const timesaleSelect = document.getElementById('is_timesales');
	const discountRateInput = document.getElementById('discount_rate');
	const timesaleRateInput = document.getElementById('timesalediscount_rate');
	const totalRateInput = document.getElementById('total_discountrate');
	const finalPriceInput = document.getElementById('discount_price');
	
///////////////// 렌더링 후 ///////////////////  
    // 전역 리스트 초기화
    attachList = [];
    //console.log('${attachImgsJson}');
    console.log('${attachImgJson}');
    const attachImgs = JSON.parse('${attachImgsJson}');
    //const attachImgs = '${attachImgsJson}';
    console.log(attachImgs);
    
 // 서버 데이터 변환
    const allFiles = attachImgs.map(convertServerImageToUploadFormat);
 	console.log("allFiles:" + JSON.stringify(allFiles, null, 2));
    const thumbnailFiles = allFiles.filter(f => f.isThumbnail === 1);
    console.log("thumbnailFiles:" + JSON.stringify(thumbnailFiles, null, 2));
    const detailFiles = allFiles.filter(f => f.isDetail === 1);
    console.log("detailFiles:" + JSON.stringify(detailFiles, null, 2));



    
    //attachList = [...allFiles];
    
    function convertServerImageToUploadFormat(serverFile) {
    	  const fullPath = serverFile.img_path;
    	  const thumbPath = serverFile.img_path_thumb;

    	  const pathParts = fullPath.split("/");
    	  const fileNameWithUUID = pathParts[pathParts.length - 1]; // 예: uuid_filename.jpg
    	  const fileName = fileNameWithUUID.substring(fileNameWithUUID.indexOf("_") + 1); // filename.jpg
    	  const uploadPath = pathParts.slice(0, pathParts.length - 1).join("/");

    	  return {
    	    id: serverFile.id,
    	    fileName: fileName,
    	    uploadPath: uploadPath,
    	    uuid: serverFile.uuid,
    	    image: 1,
    	    isThumbnail: serverFile.is_thumbnail,
    	    isThumbnailMain: serverFile.is_thumbnail_main,
    	    isDetail: serverFile.is_detail,
    	    img_path: fullPath,
    	    img_path_thumb: thumbPath,
    	    createdAt: serverFile.created_at,
    	    createdBy: serverFile.created_by,
    	    updatedAt: serverFile.updated_at,
    	    updatedBy: serverFile.updated_by,
    	  };
    	}
   
    function initUploadManagerFromServerData(currentPage, type, files) {
    	  const manager = new UploadManager({
    		currentPage:  currentPage === "modify" ? "modify" : "register",
    	    inputId: "uploadInput" + type,
    	    buttonId: "uploadBtn" + type,
    	    editBtn: "editBtn" + type,
    	    cancelBtn: "cancelBtn" + type,
    	    maxCount: type === "Thumbnail" ? 10 : 5,
    	    regex: /(.*?)\.(exe|sh|zip|alz)$/i,
    	    maxSize: 5242880,
    	    type: type
    	  });
    	  // ⚠️ 필터링 추가 위치
    	  console.log("selectedFiles(before filter):", JSON.stringify(files, null, 2));
    	  const filteredFiles = files.filter(f => f instanceof File);
    	  console.log("selectedFiles(after filter):", JSON.stringify(filteredFiles, null, 2));
    	  
    	  manager.selectedFiles = [];
    	  manager.selectedFiles = [...files];
    	  console.log("1- selectedFiles:" + JSON.stringify(manager.selectedFiles, null, 2));
    	  manager.uploadedFiles = [];
    	  manager.uploadedFiles = [...files];
    	  console.log("2- uploadedFiles:" + JSON.stringify(manager.uploadedFiles, null, 2));
    	  console.log("3- attachList(before):" + JSON.stringify(attachList, null, 2));
    	  manager.updateAttachInput();
    	  console.log("4- attachList(after):" + JSON.stringify(attachList, null, 2));
    	  
    	  manager["uploadCompleted" + type] = true;
    	  manager.updatePreviewList();    	  
    	  
    	  return manager;
    	}

    	window.uploadThumbnailManager = initUploadManagerFromServerData(currentPage,"Thumbnail", thumbnailFiles);
    	window.uploadDetailManager = initUploadManagerFromServerData(currentPage, "Detail", detailFiles);
   
   
	//const filesFromServer = attachImgs;

	// uploadManager에 맞게 변환
	//const convertedFiles = filesFromServer.map(convertServerImageToUploadFormat);
	//console.log("convertedFiles:" + convertedFiles);
	// 초기 렌더링 시 서버 데이터 받아서 변환
	//const convertedThumbnailFiles = filesFromServer.map(convertServerImageToUploadFormat).filter(f => f.isThumbnail);
	//console.log("convertedThumbnailFiles:" + convertedThumbnailFiles);
	//const convertedDetailFiles = filesFromServer.map(convertServerImageToUploadFormat).filter(f => f.isDetail);
	//console.log("convertedDetailFiles:" + convertedDetailFiles);
	
	//function convertServerImageToUploadFormat(serverFile) {
	  // 예: "product/img/thumbnail/2025/08/04/87f45b6b..._db.jpg"
	//  const fullPath = serverFile.img_path;
	  //console.log("fullPath:" + fullPath);
	//  const uuid = serverFile.uuid;
	  //console.log("uuid:" + uuid);
	//  const pathParts = fullPath.split("/");
	  //console.log("pathParts:" + pathParts);
	//  const fileNameWithUUID = pathParts[pathParts.length - 1]; // "87f45b6b..._db.jpg"
	  //console.log("fileNameWithUUID:" + fileNameWithUUID);
	//  const fileName = fileNameWithUUID.substring(fileNameWithUUID.indexOf("_") + 1); // "db.jpg"
	  //console.log("fileName:" + fileName);
	//  const uploadPath = pathParts.slice(0, pathParts.length - 1).join("/"); // "product/img/thumbnail/2025/08/04"
	  //console.log("uploadPath:" + uploadPath);
	  
	//  return {
	//    fileName: fileName,
	//    uploadPath: uploadPath,
	//    uuid: uuid,
	//    image: 1,  // 이미지이므로 1
	//    isThumbnail: serverFile.is_thumbnail,
	//    isThumbnailMain: serverFile.is_thumbnail_main,
	//    isDetail: serverFile.is_detail
	//  };
	//}
	

	
	// 업로드 매니저에 전달
	//uploadThumbnailManager.editMode(convertedThumbnailFiles);
	//uploadDetailManager.editMode(convertedDetailFiles);
	
	//selectedFiles = convertedThumbnailFiles;
	//console.log("selectedFiles:", JSON.stringify(selectedFiles, null, 2));
  
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

      totalRateInput.value = totalRate;
      //finalPriceInput.value = finalPrice.toLocaleString();
      finalPriceInput.value = finalPrice;
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
  //let selectedImgsThumbnail = [];
  //let selectedImgsDetail = [];
  //let uploadedThumbnailList = []; // 썸네일 업로드 완료된 파일 정보
  //let uploadedDetailList = []; // 상품상세정보 업로드 완료된 파일 정보
  //let uploadCompletedThumbnail = false; // 썸네일 업로드 완료 여부 flag
  //let uploadCompletedDetail = false; // 상품상세정보 업로드 완료 여부 flag

  // 업로드 버튼 처음에 숨김
  //$("#uploadBtnThumbnail").hide(); 
  //$("#uploadBtnDetail").hide(); 
  



  
  $("button[type='reset']").on("click", function() {
    if (attachList.length > 0) {
    	attachList.forEach(function (file) {
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
	  uploadedFiles = [];    // 업로드된 파일 목록 초기화
	  uploadCompletedThumbnail = false;  // 업로드 완료 상태 초기화
	  uploadCompletedDetail = false;  // 업로드 완료 상태 초기화
	  $("#uploadListThumbnail").empty(); // 업로드 리스트 UI 초기화
	  $("#uploadListDetail").empty(); // 업로드 리스트 UI 초기화
	  $("#uploadInputThumbnail").val(''); // 파일 input 초기화 (필수)
	  $("#uploadInputDetail").val(''); // 파일 input 초기화 (필수)
	  $("#uploadBtnThumbnail").hide(); // 업로드 숨김
	  $("#uploadBtnDetail").hide(); // 업로드 숨김
	});
  

  // 등록 버튼 클릭 시 유효성 검사
  $("form").on("submit", function (e) {
	e.preventDefault();
	isSubmitting = true;  
	//const checkedCategories = $("input.category:checked");
	//const checkedCategories = $("input[type='checkbox'][name='gardening'],input[name='plantkit'],input[name='hurb'],input[name='vegetable'],input[name='flower'],input[name='etc']").filter(":checked");
    const product_name = $("input[name='product_name']").val().trim();
    const product_price = $("input[name='product_price']").val().trim();
    const delivery_fee = $("input[name='delivery_fee']").val().trim();
    const delivery_days = $("input[name='delivery_days']").val().trim();
    const product_stock = $("input[name='product_stock']").val().trim();

    
    
    const checkedCount = $("input[type='checkbox']:checked").length;
    console.log("checkedCategories:" + checkedCount);
    if (checkedCount === 0) {
      alert("카테고리를 하나 이상 선택해주세요.");
      e.preventDefault();
      return;
    }

    if (!product_name) {      
      alert("상품명을 입력해주세요.");
      $("input[name='product_name']").focus();
      e.preventDefault();
      return;
    }
    
    if (!product_price) {
      alert("가격을 입력해주세요.");
      $("input[name='product_price']").focus();
      e.preventDefault();
      return;
    }
    
    if (!delivery_fee) {
      alert("배송비를 입력해주세요.");
      $("input[name='delivery_fee']").focus();
      e.preventDefault();
      return;
    }
    
    if (!delivery_days) {
      alert("배송기한를 입력해주세요.");
      $("input[name='delivery_days']").focus();
      e.preventDefault();
      return;
    }
    
    if (!product_stock) {
      alert("기초재고수량를 입력해주세요.");
      $("input[name='product_stock']").focus();
      e.preventDefault();
      return;
    }

    // 파일이 선택된 경우 업로드 완료 여부 체크
    if (uploadThumbnailManager.selectedFiles.length > 0) {
      alert("상품 이미지 업로드 버튼을 눌러주세요.");
      e.preventDefault();
      return;
    }
    if (uploadDetailManager.selectedFiles.length > 0) {
      alert("상품상세정보 이미지 업로드 버튼을 눌러주세요.");
      e.preventDefault();
      return;
    }
    if (!uploadThumbnailManager.uploadCompletedThumbnail) {
      alert("상품 이미지 업로드를 완료해주세요.");
      e.preventDefault();
      return;
    }
    if (!uploadDetailManager.uploadCompletedDetail) {
      alert("상품상세정보 이미지 업로드를 완료해주세요.");
      e.preventDefault();
      return;
    }
    $("form").off("submit").submit();
  });
  
  
  // 뒤로가기 시 업로드 된 파일 삭제
	window.addEventListener("beforeunload", function (e) {
	    
		if (currentPage !== "modify"){
			if (!isSubmitting && attachList.length > 0) {
		        document.getElementById("resetBtn").click();
		        e.preventDefault();
		        e.returnValue = ""; // 경고창
		    }			
		}
	});
  

	  
	  
	  

	  
		// 썸네일 버튼 토글
	    if (window.uploadThumbnailManager.uploadCompletedThumbnail) {
	    	console.log("uploadCompletedThumbnail: checked")
	        $('#uploadBtnThumbnail').hide();
	        $('#deleteBtnThumbnail').hide();
	        $('#uploadInputThumbnail').hide();
	        $('#cancelBtnThumbnail').hide();
	        $('.delBtnThumbnail').hide();
	    }

	    if (window.uploadDetailManager.uploadCompletedDetail) {
	    	console.log("uploadCompletedDetail: checked")
	        $('#uploadBtnDetail').hide();
	        $('#deleteBtnDetail').hide();
	        $('#uploadInputDetail').hide();
	        $('#cancelBtnDetail').hide();
	        $('.delBtnDetail').hide();
	    }
		  
//		$('#modifyBtnThumbnail').on('click', function () {
//		    $('#uploadBtnThumbnail, #deleteBtnThumbnail, #uploadInputThumbnail').show();
//		    $('#modifyBtnThumbnail').hide();
//		    window.uploadThumbnailManager.uploadCompletedThumbnail = false;
//		});

//		$('#modifyBtnDetail').on('click', function () {
//		    $('#uploadBtnDetail, #deleteBtnDetail, #uploadInputDetail').show();
//		    $('#modifyBtnDetail').hide();
//		    window.uploadDetailManager.uploadCompletedDetail = false;
//		});
		



});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>

</html>