let attachList = []; //전역선언

class UploadManager {
  constructor({ currentPage, inputId, buttonId, editBtn, cancelBtn, maxCount, type, regex, maxSize }) {
    this.currentPage = currentPage;
    this.inputId = inputId;
    this.buttonId = buttonId;
    this.editBtn = editBtn;
    this.cancelBtn = cancelBtn;
    this.maxCount = maxCount;
    this.regex = regex;
    this.maxSize = maxSize;

    this.type = type; // "Thumbnail" | "Detail"
    //this.productId = productId;

    this.selectedFiles = [];
    this.uploadedFiles = [];
    


    //this.uploadCompleted = false;
    this["uploadCompleted" + this.type] = false;

    this.csrfHeader = $("meta[name='_csrf_header']").attr("content");
    this.csrfToken = $("meta[name='_csrf']").attr("content");

    this.initEvents();
    console.log("생성된 UploadManager 상태:", this);
  }

  initEvents() {
    $(`#${this.inputId}`).on("change", (e) => this.handleFileSelect(e));
    console.log("inputId 초기화");
    $(`#${this.buttonId}`).on("click", (e) => this.uploadFiles(e));
    console.log("buttonId 초기화");
    $(`#${this.editBtn}`).on("click", (e) => this.editMode(e));
    console.log("editBtn 초기화");
    $(`#${this.cancelBtn}`).on("click", (e) => this.cancelBtn(e));
    console.log("cancelBtn 초기화");
  }

  handleFileSelect(e) {
    const files = Array.from(e.target.files);
    const total = this.selectedFiles.length + files.length;
    if (total > this.maxCount) {
      alert(`❗ 최대 ${this.maxCount}개까지 파일을 업로드할 수 있습니다.`);
      $(`#${this.inputId}`).val("");
      return;
    }
	console.log("handleFileSelect(files) :" + files);
	console.log("handleFileSelect(files) :" + JSON.stringify(files, null, 2));
	console.log("handleFileSelect(this.uploadedFiles):" + JSON.stringify(this.uploadedFiles, null, 2));
    files.forEach((file) => {
      if (this.checkExtension(file.name, file.size)) {
        this.selectedFiles.push(file);
        console.log("handleFileSelect(selectedFiles) :" + JSON.stringify(this.selectedFiles, null, 2));
      }
    });

    if (this.selectedFiles.length > 0) {
      $(`#${this.buttonId}`).show();
    }

    this.updatePreviewList();
    $(`#${this.inputId}`).val("");
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
      alert(
        `❗ [ ${fileName} ] ${fileSizeMB}MB 너무 큽니다. (허용크기 : ${maxSizeMB}MB)`
      );
      return false;
    }
    return true;
  }

  updatePreviewList() {
    this.currentPage = ""
    const list = $("#uploadList" + this.type);
    if (list.length === 0) return;

    list.empty();

    const radioName = "thumbnailMain";
    
	//console.log("selectedFiles:" + JSON.parse(selectedFiles));
	console.log("updatePreviewList(selectedFiles) :" + JSON.stringify(this.selectedFiles, null, 2));
	
    this.selectedFiles.forEach((file, idx) => {
    
      const li = $("<li>").addClass(
        "list-group-item d-flex justify-content-between align-items-center"
      );
      const content = $("<div>").addClass("d-flex align-items-center");


        // 이미지 파일이면 미리보기 생성
		if (file instanceof File) {
		  const reader = new FileReader();
		  reader.onload = function (e) {
		    const img = $("<img>")
		      .attr("src", e.target.result)
		      .css({
		        width: this.type === "Detail" ? "100%" : "40px",
		        height: this.type === "Detail" ? "auto" : "40px",
		        objectFit: "cover",
		        marginRight: "10px",
		        cursor: "pointer",
		      })
		      .on("click", () => {
		        const win = window.open();
		        win.document.write(
		          `<img src="${e.target.result}" style="max-width:100%">`
		        );
		      });
		
		    content.prepend(img);
		  }.bind(this);
		  reader.readAsDataURL(file);
		} else {
		  // 서버에서 불러온 기존 파일 처리 (이미지 경로 생성)
		  const fileUrl = `/display?fileName=${encodeURIComponent(
		    file.uploadPath + "/" + file.uuid + "_" + file.fileName
		  )}`;
		  const img = $("<img>")
		    .attr("src", fileUrl)
		    .css({
		      width: this.type === "Detail" ? "100%" : "40px",
		      height: this.type === "Detail" ? "auto" : "40px",
		      objectFit: "cover",
		      marginRight: "10px",
		      cursor: "pointer",
		    })
		    .on("click", () => {
		      const win = window.open();
		      win.document.write(
		        `<img src="${fileUrl}" style="max-width:100%">`
		      );
		    });
		
		  content.prepend(img);
		}
       

        content.append($("<span>").text(file.name));

        // 대표 이미지 선택 라디오 버튼 (Thumbnail만)
        if (this.type === "Thumbnail") {
          file.is_thumbnail = 1;
          const radioWrapper = $("<div>").addClass(
            "d-flex flex-column align-items-center ms-4"
          );

          const radioBtn = $("<input type='radio'>")
            .attr("name", radioName)
            .attr("value", file.uuid)
            .addClass("form-check-input mb-1")
            .on("change", () => {
              this.selectedFiles.forEach((f) => delete f.is_thumbnail_main);
              file.is_thumbnail_main = 1;
              this.updatePreviewList(); // 다시 그려서 대표 표시 업데이트
            });

          // currentPage가 'modify'이면 라디오 버튼 비활성화
		  if (this.currentPage === "modify") {
		      radioBtn.prop("disabled", true);
		  }

          if (
            file.is_thumbnail_main ||
            (idx === 0 && !this.selectedFiles.some((f) => f.is_thumbnail_main))
          ) {
            radioBtn.prop("checked", true);
            file.is_thumbnail_main = 1;
          }

          const label = $("<small>")
            .text(file.is_thumbnail_main ? "대표 이미지" : "")
            .addClass("text-primary fw-bold");

          radioWrapper.append(radioBtn, label);
          content.append(radioWrapper);
        }

        const delBtnWrapper = $("<div>").addClass("text-right mt-3");
        const delBtn = $("<button type='button'>")
          .css({margin: "5px"})
          .addClass("btn btn-sm btn-danger")
          .addClass(file.is_thumbnail === 1 ? "delBtnThumbnail" : "delBtnDetail")
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
    console.log("uploadFiles(start)------------------>");
    console.log("upload(selectedFiles) :" + JSON.stringify(this.selectedFiles, null, 2));
    
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
    this.selectedFiles = this.selectedFiles.filter(f => f instanceof File);
    this.selectedFiles.forEach((file, index) => {

      console.log("upload(before) :" + JSON.stringify(file, null, 2));

      formData.append("uploadFile", file);
      formData.append(
        `is_thumbnail_${index}`,
        file.is_thumbnail === 1 ? "1" : "0"
      );
      formData.append(
        `is_thumbnail_main_${index}`,
        file.is_thumbnail_main === 1 ? "1" : "0"
      );
      formData.append(`is_detail_${index}`, file.is_detail === 1 ? "1" : "0");

      console.log("upload(after) :" + JSON.stringify(file, null, 2));
    });
    
    formData.append("type", this.type);

    $.ajax({
      url: "/uploadAjaxAction",
      processData: false,
      contentType: false,
      data: formData,
      type: "POST",
      dataType: "json",
      beforeSend: (xhr) => {
        if (this.csrfHeader && this.csrfToken) {
          xhr.setRequestHeader(this.csrfHeader, this.csrfToken);
        }
      },
      success: (result) => {
        console.log("Upload result 1: " + JSON.stringify(result, null, 2)); // JSON 형식 출력

        // 기존 uploadedFiles와 합치되 중복 uuid는 제거
        const existingUuids = new Set(this.uploadedFiles.map((f) => f.uuid));
        const newFiles = result.filter((f) => !existingUuids.has(f.uuid));
        console.log("upload(newFiles) :" + JSON.stringify(newFiles, null, 2));
		console.log("upload(uploadedFiles-before) :" + JSON.stringify(this.uploadedFiles, null, 2));
        this.uploadedFiles = [...this.uploadedFiles, ...newFiles];
        console.log("upload(uploadedFiles-after) :" + JSON.stringify(this.uploadedFiles, null, 2));
        attachList = [...attachList, ...newFiles];
        console.log("upload(attachList) :" + JSON.stringify(attachList, null, 2));

        this.updateAttachInput();
        this.updateUploadedUI(this.uploadedFiles); // 모든 업로드 결과를 다시 그림
        this.selectedFiles = [];
        this["uploadCompleted" + this.type] = true;
        $(`#${this.buttonId}`).hide();
        $(`#${this.inputId}`).hide();
        $(`#${this.editBtn}`).show();
        
        console.log("selectedFiles:" + JSON.stringify(this.selectedFiles, null, 2));
        console.log("Upload result 2: " + JSON.stringify(this.uploadedFiles, null, 2));
        console.log("Attatch result: " + JSON.stringify(result, null, 2));
      },
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
      console.warn(
        "DOM 요소가 없습니다.updateUploadedUI(files): #uploadList" + this.type
      );
      return;
    }
    list.empty();
    
    

    files.forEach((file) => {
      const fileCallPath = encodeURIComponent(
        file.uploadPath.replace(/\\/g, "/") +
          "/" +
          file.uuid +
          "_" +
          file.fileName
      );
      const li = $("<li>").addClass(
        "list-group-item d-flex justify-content-between align-items-center"
      );
      //li.append($("<span>").text(file.fileName));
      //list.append(li);

      const content = $("<div>").addClass("d-flex align-items-center");

      if (file.image) {
        if (this.type === "Detail") {
          const thumbPath =
            "/display?fileName=" +
            encodeURIComponent(
              file.uploadPath.replace(/\\/g, "/") +
                "/" +
                file.uuid +
                "_" +
                file.fileName
            );
          content.append(
            $("<img>").attr("src", thumbPath).css({
              maxWidth: "100%",
              objectFit: "cover",
              marginRight: "10px",
              cursor: "pointer",
            })
          );
        } else {
          const thumbPath =
            "/display?fileName=" +
            encodeURIComponent(
              file.uploadPath.replace(/\\/g, "/") +
                "/s_" +
                file.uuid +
                "_" +
                file.fileName
            );
          content.append(
            $("<img>").attr("src", thumbPath).css({
              width: "40px",
              height: "40px",
              objectFit: "cover",
              marginRight: "10px",
            })
          );
        }
      } else {
        content.append($("<i>").addClass("fas fa-file-alt mr-2"));
      }

      content.append($("<span>").text(file.fileName));

      // 대표 이미지 표시(Thumbnail만)
      console.log("isThumbnailMain:" + file.isThumbnailMain);
      if (file.isThumbnailMain === 1) {
        const textWrapper = $("<div>").addClass(
          "d-flex flex-column align-items-center ms-4"
        );
        const label = $("<span>")
          .text("대표 이미지")
          .addClass("label label-primary");
        textWrapper.append(label);
        content.append(textWrapper);
      }

      const delBtnWrapper = $("<div>").addClass("text-right mt-3");

      const delBtn = $("<button type='button'>")
        .css({margin: "5px"})
        .addClass("btn btn-sm btn-danger")
        .addClass(file.is_thumbnail === 1 ? "delBtnDetThumbnail" : "delBtnDetail")
        .text("삭제")
        //.hide() // 업로드 후 삭제버튼 숨김
        .on("click", () => {
          this.deleteFile(fileCallPath, file.image ? "image" : "file", $(this).closest("li"));
        });

	  delBtnWrapper.append(delBtn);
      li.append(content).append(delBtnWrapper);
	  list.append(li);

    });
    
	this.selectedFiles = [];

    console.log(
      "this.selectedFiles(updateUploadedUI):" + JSON.stringify(this.selectedFiles, null, 2)
    );
    console.log(
      "this.uploadedFiles(updateUploadedUI):" + JSON.stringify(this.uploadedFiles, null, 2)
    );
    console.log("attachList(updateUploadedUI):" + JSON.stringify(attachList, null, 2)
    );
  }

  deleteFile(fileName, type, liElement) {
    $.ajax({
      url: "/deleteFile",
      data: { fileName: fileName, type: type },
      type: "POST",
      success: function (result) {
        liElement.remove();
      },
    });
  }

  editMode(e) {
    e.preventDefault();
    console.log("editMode(this.uploadedFiles):" + JSON.stringify(this.uploadedFiles, null, 2));
    console.log("editMode(this.selectedFiles):" + JSON.stringify(this.selectedFiles, null, 2));
    //this.selectedFiles = this.uploadedFiles;
    console.log("editMode(this.selectedFiles - after):" + JSON.stringify(this.selectedFiles, null, 2));
    //this.uploadCompleted = false;
    this["uploadCompleted" + this.type] = false;

    //this.updateUploadedUI(this.selectedFiles);

    //$(`#${this.buttonId}`).show();
    $(`#${this.inputId}`).show();
    $(`#${this.cancelBtn}`).show();
    $(`#${this.editBtn}`).hide();
    this.currentPage = "";
    this.updatePreviewList();
    $("input[type='radio']").prop("disabled", false);
    
    
  } 

}
