let attachList = [];  //전역선언

class UploadManager {
  constructor({ inputId, buttonId, maxCount, type, regex, maxSize }) {
    this.inputId = inputId;
    this.buttonId = buttonId;
    this.maxCount = maxCount;    
    this.regex = regex;
    this.maxSize = maxSize;    
    
    this.type = type; // "Thumbnail" | "Detail"
    //this.productId = productId;
    
    this.selectedFiles = [];
    this.uploadedFiles = [];   
    
    this.uploadCompleted = false;
    this["uploadCompleted" + this.type] = false;

    this.csrfHeader = $("meta[name='_csrf_header']").attr("content");
    this.csrfToken = $("meta[name='_csrf']").attr("content");

    this.initEvents();
    console.log("생성된 UploadManager 상태:", this);
  }

  initEvents() {
    $(`#${this.inputId}`).on("change", e => this.handleFileSelect(e));
    console.log("inputId 초기화");
    $(`#${this.buttonId}`).on("click", e => this.uploadFiles(e));
    console.log("buttonId 초기화");
  }

  handleFileSelect(e) {
    const files = Array.from(e.target.files);
    const total = this.selectedFiles.length + files.length;
    if (total > this.maxCount) {
      alert(`❗ 최대 ${this.maxCount}개까지 파일을 업로드할 수 있습니다.`);
      $(`#${this.inputId}`).val('');
      return;
    }

    files.forEach(file => {
      if (this.checkExtension(file.name, file.size)) {
        this.selectedFiles.push(file);
      }
    });

    if (this.selectedFiles.length > 0) {
      $(`#${this.buttonId}`).show();
    }

    this.updatePreviewList();
    $(`#${this.inputId}`).val('');
  }

  checkExtension(fileName, fileSize) {
    //const regex = /(.*?)\.(exe|sh|zip|alz)$/i;
    //const maxSize = 5242880;
    const fileSizeMB = (fileSize / (1024 * 1024)).toFixed(2);
    const maxSizeMB = (this.maxSize / (1024 * 1024)).toFixed(2);
    
    if (this.regex.test(fileName)) {
      alert(`❗ [ ${fileName} ]은 허용되지 않는 확장자입니다.`);
      return false;
    }
    if (fileSize >= this.maxSize) {
      alert(`❗ [ ${fileName} ] ${fileSizeMB}MB 너무 큽니다. (허용크기 : ${maxSizeMB}MB)`);
      return false;
    }
    return true;
  }

  updatePreviewList() {
	const list = $("#uploadList" + this.type);
	if (list.length === 0) {
	  console.warn("DOM 요소가 없습니다.updatePreviewList(): #uploadList" + this.type);
	  return;
	}
  
	  list.empty();
	    
	  const radioName = "thumbnailMain"; // 라디오 그룹 이름 (같은 그룹이면 하나만 선택됨)    
	    
	  this.selectedFiles.forEach((file, idx) => {
	    const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");
	    //const name = $("<span>").text(file.name);
	    //const delBtn = $("<button>").text("삭제").addClass("btn btn-sm btn-danger").on("click", () => {
	    //  this.selectedFiles.splice(idx, 1);
	    //  this.updatePreviewList();
	    //});
	    //li.append(name).append(delBtn);
	    //list.append(li);
	      
	    const content = $("<div>").addClass("d-flex align-items-center");
	      
	    // 이미지 파일이면 미리보기 생성
	    if (file.type.startsWith("image/")) {
	      const reader = new FileReader();
	      reader.onload = function (e) {
			  const img = $("<img>").attr("src", e.target.result);
			
			  if (this.type === "Detail") {
			    file.is_detail = 1;
			    img.css({
			      maxWidth: "100%",
			      objectFit: "cover",
			      marginRight: "10px",
			      cursor: "pointer"
			    }).on("click", () => {
			      const win = window.open();
			      win.document.write(`<img src="${e.target.result}" style="max-width:100%">`);
			    });
			  } else {
			    img.css({
			      width: "40px",
			      height: "40px",
			      objectFit: "cover",
			      marginRight: "10px",
			      cursor: "pointer"
			    });
			  }
			
			  content.prepend(img);
			}.bind(this);  // 여기 중요: this.type을 접근하기 위해 bind(this) 필요
	      reader.readAsDataURL(file);
	    } else {
	      content.append($("<i>").addClass("fas fa-file-alt mr-2"));
	    }
	
	    content.append($("<span>").text(file.name));
	      
	    // 대표 이미지 선택 라디오 버튼 (Thumbnail만)
	    if (this.type === "Thumbnail") {
	      file.is_thumbnail = 1;
	      const radioWrapper = $("<div>").addClass("d-flex flex-column align-items-center ms-4");
	
	      const radioBtn = $("<input type='radio'>")
	        .attr("name", radioName)
	        .attr("value", file.uuid)
	        .addClass("form-check-input mb-1")
	        .on("change", () => {
	          this.selectedFiles.forEach(f => delete f.is_thumbnail_main);
	          file.is_thumbnail_main = 1;
	          this.updatePreviewList(); // 다시 그려서 대표 표시 업데이트
	        });
	
	        if (file.is_thumbnail_main || idx === 0 && !this.selectedFiles.some(f => f.is_thumbnail_main)) {
	          radioBtn.prop("checked", true);
	          file.is_thumbnail_main = 1;
	        }
	
	        const label = $("<small>").text(file.is_thumbnail_main ? "대표 이미지" : "").addClass("text-primary fw-bold");
	
	        radioWrapper.append(radioBtn, label);
	        content.append(radioWrapper);
	      }
	
		  const delBtnWrapper = $("<div>").addClass("text-right mt-3");
	      const delBtn = $("<button type='button'>")
	        .addClass("btn btn-sm btn-danger ml-2")
	        .text("삭제")
	        .on("click", () => {
	        this.selectedFiles.splice(idx, 1);
	        this.updatePreviewList();
	    });
	
	    delBtnWrapper.append(delBtn);
	      li.append(content, delBtnWrapper);
	      list.append(li);      
	    });
  }

  uploadFiles(e) {
    e.preventDefault();
    if (this.selectedFiles.length === 0) {
      alert("업로드할 파일을 선택하세요.");
      return;
    }

    //if (this.type.toLowerCase() === 'detail' && !this.uploadCompletedThumnail) {
    //  alert("❗ 상품 이미지를 먼저 업로드해주세요.");
    //  return;
    //}

    const formData = new FormData();
    this.selectedFiles.forEach((file, index) => {
    
      console.log("file(before) :" + file);
    
      formData.append("uploadFile", file);
      formData.append(`is_thumbnail_${index}`, file.is_thumbnail === 1 ? "1" : "0");
      formData.append(`is_thumbnail_main_${index}`, file.is_thumbnail_main === 1 ? "1" : "0");
      formData.append(`is_detail_${index}`, file.is_detail === 1 ? "1" : "0");
      
      console.log("file(after) :" + file);    
    });
    
    formData.append("type", this.type);

    $.ajax({
      url: '/uploadAjaxAction',
      processData: false,
      contentType: false,
      data: formData,
      type: 'POST',
      dataType: 'json',
      beforeSend: xhr => {
        if (this.csrfHeader && this.csrfToken) {
          xhr.setRequestHeader(this.csrfHeader, this.csrfToken);
        }
      },
success: result => {
    console.log("Attatch result: " + result);
    console.log(JSON.stringify(result, null, 2));  // JSON 형식 출력

    // 기존 uploadedFiles와 합치되 중복 uuid는 제거
    const existingUuids = new Set(this.uploadedFiles.map(f => f.uuid));
    const newFiles = result.filter(f => !existingUuids.has(f.uuid));

    this.uploadedFiles = [...this.uploadedFiles, ...newFiles];
    attachList = [...attachList, ...newFiles];

    this.updateAttachInput();
    this.updateUploadedUI(this.uploadedFiles);  // 모든 업로드 결과를 다시 그림
    this.selectedFiles = [];
    this["uploadCompleted" + this.type] = true;
    $(`#${this.buttonId}`).hide();
}
    });
  }

  isUploaded() {
    return this.uploadedFiles.length > 0;
  }

  updateAttachInput() {
    $("#attachListJson").val(JSON.stringify(attachList));
  }
  
  updateUploadedUI(files) {
    const list = $("#uploadList" + this.type);
	if (list.length === 0) {
	  console.warn("DOM 요소가 없습니다.updateUploadedUI(files): #uploadList" + this.type);
	  return;
	}
    list.empty();
    
    files.forEach(file => {
      const fileCallPath = encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/" + file.uuid + "_" + file.fileName);
      const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");
      //li.append($("<span>").text(file.fileName));
      //list.append(li);
      
	  const content = $("<div>").addClass("d-flex align-items-center");
	
	  if (file.image) {
	    if (this.type === "Detail") {
	    	const thumbPath = "/display?fileName=" + encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/" + file.uuid + "_" + file.fileName);
	        content.append(
		      $("<img>").attr("src", thumbPath).css({
			    maxWidth: "100%",
			    objectFit: "cover",
			    marginRight: "10px",
			    cursor: "pointer"
		      })
		    );
	    } else {
	    	const thumbPath = "/display?fileName=" + encodeURIComponent(file.uploadPath.replace(/\\/g, '/') + "/s_" + file.uuid + "_" + file.fileName);
		    content.append(
		      $("<img>").attr("src", thumbPath).css({
		        width: "40px",
		        height: "40px",
		        objectFit: "cover",
		        marginRight: "10px"
		      })
		    );
		  }
	  } else {
	    content.append(
	      $("<i>").addClass("fas fa-file-alt mr-2")
	    );
	  }
	
	  content.append($("<span>").text(file.fileName));
	  
	  
	  // 대표 이미지 표시(Thumbnail만)
	  console.log("isThumbnailMain:" + file.isThumbnailMain);
	  if (file.isThumbnailMain === 1) {
	      const textWrapper = $("<div>").addClass("d-flex flex-column align-items-center ms-4");
          const label = $("<span>").text("대표 이미지").addClass("label label-primary");	
	      textWrapper.append(label);
	      content.append(textWrapper);
	  }
	  
	  const btnWrapper = $("<div>").addClass("text-right mt-3");
	  
	  const delBtn = $("<button type='button'>")
	    .addClass("btn btn-danger btn-sm")
	    .text("삭제")
	    .hide() // 업로드 후 삭제버튼 숨김
	  //  .on("click", () => {
	  //    this.deleteFile(fileCallPath, file.image ? "image" : "file", $(this).closest("li"));
	  //  });
	
	  li.append(content).append(delBtn);
	  
	  	  
	  		        // 수정 버튼
		        const editBtn = $("<button type='button'>")
		            .addClass("btn btn-sm btn-primary ml-2")
		            .text("수정")
		            .on("click", () => {
		                this.editMode([file]);
		            });

		        btnWrapper.append(editBtn);
		        li.append(btnWrapper);
	  
	  list.append(li);      
    });
    
    console.log("this.selectedFiles:" + JSON.stringify(this.selectedFiles, null, 2)); 
    console.log("this.uploadedFiles:" + JSON.stringify(this.uploadedFiles, null, 2)); 
    console.log("this.attachList:" + JSON.stringify(this.attachList, null, 2)); 

  }
  
  deleteFile(fileName, type, liElement) {
    $.ajax({
      url: '/deleteFile',
      data: { fileName: fileName, type: type },
      type: 'POST',
      success: function (result) {
        liElement.remove();
      }
    });
  }
  
  editMode(existingFiles) {
  console.log("existingFiles:" + JSON.stringify(existingFiles, null, 2));
    this.selectedFiles = [...existingFiles];  // 외부에서 받은 파일들로 설정
    this.uploadCompleted = false;
    this["uploadCompleted" + this.type] = false;

    this.updateUploadedUI(this.selectedFiles);
    $(`#${this.buttonId}`).show();
  }


}
