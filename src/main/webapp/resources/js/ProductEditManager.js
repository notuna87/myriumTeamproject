class ProductEditManager {
  constructor({ currentPage, inputId, buttonId, editBtn, cancelBtn, maxCount, type, regex, maxSize }) {
    console.log(`[Init] ProductEditManager 생성됨: ${type}`);
    
    this.currentPage = currentPage;
    this.inputId = inputId;
    this.buttonId = buttonId;
    this.editBtn = editBtn;
    this.cancelBtn = cancelBtn;
    this.maxCount = maxCount;
    this.regex = regex;
    this.maxSize = maxSize;
    this.type = type;

    this.selectedFiles = [];
    this.attachList = [];
    this.uploadedFiles = [];
    this.deleteUuids = [];
    this["uploadCompleted" + this.type] = false;

    this.csrfHeader = $("meta[name='_csrf_header']").attr("content");
    this.csrfToken = $("meta[name='_csrf']").attr("content");

    this.initEvents();
  }

  initEvents() {
    console.log(`[InitEvents] ${this.type} - 이벤트 바인딩 시작`);
    
    $(`#${this.inputId}`).on("change", (e) => this.handleFileSelect(e));
    $(`#${this.buttonId}`).on("click", (e) => this.uploadFiles(e));
    $(`#${this.editBtn}`).on("click", (e) => this.editMode(e));
    $(`#${this.cancelBtn}`).on("click", (e) => this.cancelEdit(e));
  }

  initializeFromServerData(serverFiles) {
    console.log(`[InitFromServer] ${this.type} 서버 데이터 초기화:`, serverFiles);
    
    this.selectedFiles = [];
    this.uploadedFiles = serverFiles.slice();
    this["uploadCompleted" + this.type] = true;
    this.updatePreviewList();
  }

  handleFileSelect(e) {
    const files = Array.from(e.target.files);
    const totalCount = this.selectedFiles.length + this.uploadedFiles.filter(f => !f.toDelete).length + files.length;
    
    console.log(`[FileSelect] ${this.type} - 선택된 파일:`, files);

    if (totalCount > this.maxCount) {
      alert(`❗ 최대 ${this.maxCount}개까지 파일을 업로드할 수 있습니다.`);
      $(`#${this.inputId}`).val("");
      return;
    }

    files.forEach((file) => {
      if (this.checkExtension(file.name, file.size)) {
        this.selectedFiles.push(file);
        console.log(`[FileSelect] 파일 추가됨: ${file.name}`);
      }
    });

    if (this.selectedFiles.length > 0) {
      $(`#${this.buttonId}`).show();
    }
    this.updatePreviewList();
    $(`#${this.inputId}`).val("");
  }

  checkExtension(fileName, fileSize) {
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

    console.log(`[Check] ${fileName} 확장자/크기 통과`);
    return true;
  }

  toDelete(index, isUploaded) {
    console.log(`[Delete] ${this.type} - index: ${index}, isUploaded: ${isUploaded}`);

    if (isUploaded) {
      this.uploadedFiles[index].toDelete = true;
    } else {
      this.selectedFiles.splice(index, 1);
    }

    this.updatePreviewList();
  }

  setMainImage(index, isUploaded) {
    console.log(`[MainImage] ${this.type} - 대표 이미지 설정: index=${index}, isUploaded=${isUploaded}`);

    if (isUploaded) {
      this.uploadedFiles.forEach((img, i) => {
        img.isThumbnailMain = i === index ? 1 : 0;
      });
      this.selectedFiles.forEach(f => f.isThumbnailMain = 0);
    } else {
      this.selectedFiles.forEach((file, i) => {
        file.isThumbnailMain = i === index ? 1 : 0;
      });
      this.uploadedFiles.forEach(f => f.isThumbnailMain = 0);
    }

    this.updatePreviewList();
  }

  updatePreviewList() {
    $("input[type='radio']").prop("disabled", true);
    
    //console.log(`[Preview] ${this.type} - uploadedFiles`, JSON.parse(this.uploadedFiles));
    
    const list = $(`#uploadList${this.type}`);
    if (list.length === 0) return;

    list.empty();
    console.log(`[Preview] ${this.type} - 미리보기 업데이트`);

    this.uploadedFiles.forEach((file, index) => {
      if (file.toDelete) return;

      const fileUrl = `/display?fileName=${encodeURIComponent(file.uploadPath + "/" + file.uuid + "_" + file.fileName)}`;
      const li = $(`
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <div class="d-flex align-items-center">
            <img src="${fileUrl}" style="${this.type === 'Detail' ? 'max-width:100%' : 'width:40px;height:40px;object-fit:cover;'};margin-right:10px;cursor:pointer;" />
            <span>${file.fileName}</span>
          </div>
          <div class="d-flex align-items-center">
            ${this.type === 'Thumbnail' ? `
              <input type="radio" name="mainImage${this.type}" ${file.isThumbnailMain === 1 ? 'checked' : ''} data-index="${index}" data-uploaded="true" class="main-radio" />
              <label style="margin-right:10px;">대표</label>
            ` : ''}
            <div class="text-right mt-3">
              <button type="button" class="btn btn-sm btn-danger delete-btn ${file.is_thumbnail === 1 ? 'delBtnThumbnail' : 'delBtnDetail'}" data-index="${index}" data-uploaded="true" data-uuid="${file.uuid}">삭제</button>
          	</div>
          </div>
        </li>
      `);
      list.append(li);
    });

    this.selectedFiles.forEach((file, index) => {
      const objectUrl = URL.createObjectURL(file);
      const li = $(`
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <div class="d-flex align-items-center">
            <img src="${objectUrl}" style="${this.type === 'Detail' ? 'max-width:100%' : 'width:40px;height:40px;object-fit:cover;'};margin-right:10px;cursor:pointer;" />
            <span>${file.name}</span>
          </div>
          <div class="d-flex align-items-center">
            ${this.type === 'Thumbnail' ? `
              <input type="radio" name="mainImage${this.type}" ${file.isThumbnailMain === 1 ? 'checked' : ''} data-index="${index}" data-uploaded="false" class="main-radio" />
              <label style="margin-right:10px;">대표</label>
            ` : ''}
            <div class="text-right mt-3">
                <button type="button" class="btn btn-sm btn-danger delete-btn ${file.is_thumbnail === 1 ? 'delBtnThumbnail' : 'delBtnDetail'}" data-index="${index}" data-uploaded="false" data-uuid="${file.uuid}">삭제</button>
          	</div>
          </div>
        </li>
      `);
      list.append(li);
    });

    list.find(".delete-btn").off("click").on("click", (e) => {
      const target = $(e.currentTarget);
      const index = parseInt(target.data("index"));
      const isUploaded = target.data("uploaded");
      this.toDelete(index, isUploaded);
    });

    list.find(".main-radio").off("change").on("change", (e) => {
      const target = $(e.currentTarget);
      const index = parseInt(target.data("index"));
      const isUploaded = target.data("uploaded");
      this.setMainImage(index, isUploaded);
    });
  }

  buildFormData(formData, prefix) {
    console.log(`[FormData] ${this.type} - FormData 구성 시작`);

    this.uploadedFiles.forEach((file, i) => {
      if (file.toDelete) {
        formData.append(`${prefix}[${i}][delete]`, "true");
        formData.append(`${prefix}[${i}][uuid]`, file.uuid);
        formData.append(`${prefix}[${i}][fileName]`, file.fileName);
      } else {
        formData.append(`${prefix}[${i}][uuid]`, file.uuid);
        formData.append(`${prefix}[${i}][fileName]`, file.fileName);
        formData.append(`${prefix}[${i}][isThumbnailMain]`, file.isThumbnailMain === 1 ? "1" : "0");
      }
    });

    this.selectedFiles.forEach((file, i) => {
      formData.append(`${prefix}[new][${i}][file]`, file);
      formData.append(`${prefix}[new][${i}][isThumbnailMain]`, file.isThumbnailMain === 1 ? "1" : "0");
    });
  }

  editMode(e) {
    e.preventDefault();
    console.log(`[EditMode] ${this.type} - 편집모드 진입`);

    this["uploadCompleted" + this.type] = false;
    //$(`#${this.buttonId}`).show();
    $(`#${this.inputId}`).show();
    $(`#${this.cancelBtn}`).show();
    $(`#${this.editBtn}`).hide();
    $(`.delBtn${this.type}`).show();    
    $("input[type='radio']").prop("disabled", false);
  }

  cancelEdit(e) {
    e.preventDefault();
    console.log(`[CancelEdit] ${this.type} - 편집 취소`);

    this.selectedFiles = [];
    this.uploadedFiles.forEach(f => delete f.toDelete);
    this["uploadCompleted" + this.type] = true;
    this.updatePreviewList();
    $(`#${this.buttonId}`).hide();
    $(`#${this.inputId}`).hide();
    $(`#${this.cancelBtn}`).hide();
    $(`#${this.editBtn}`).show();
    $(`.delBtn${this.type}`).hide();
    $("input[type='radio']").prop("disabled", true);
  }

updateAttachInput() {
  console.log(`[AttachInput] ${this.type} - attachList 업데이트`);

  // toDelete 되지 않은 파일만 전송
  const filteredFiles = this.uploadedFiles.filter(file => !file.toDelete);

  const attachData = filteredFiles.map(file => ({
    uuid: file.uuid,
    fileName: file.fileName,
    uploadPath: file.uploadPath,
    isThumbnail: this.type === 'Thumbnail' ? 1 : 0,
    isThumbnailMain: this.type === 'Thumbnail' ? (file.isThumbnailMain === 1 ? 1 : 0) : 0,
    isDetail: this.type === 'Detail' ? 1 : 0
  }));

  // 전역 hidden input에 JSON 문자열로 저장
  const attachInput = document.getElementById("attachListJson");
  if (attachInput) {
    attachInput.value = JSON.stringify(attachData);
    console.log(`[AttachInput] attachListJson set:`, attachData);
  }
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
        
        attachList = [...attachList, ...newFiles];
        console.log("upload(attachList) :" + JSON.stringify(attachList, null, 2));
        this.uploadedFiles = [...this.uploadedFiles, ...newFiles];
        console.log("upload(uploadedFiles-after) :" + JSON.stringify(this.uploadedFiles, null, 2));

        this.updateAttachInput();
        //this.updateUploadedUI(this.uploadedFiles); // 모든 업로드 결과를 다시 그림
        //this.initializeFromServerData(result);
        this.selectedFiles = [];
        
        this.updatePreviewList();
        this["uploadCompleted" + this.type] = true;
        $(`#${this.buttonId}`).hide();
        $(`#${this.inputId}`).hide();
        $(`#${this.editBtn}`).show();
        $(`.delBtn${this.type}`).hide();
    	$("input[type='radio']").prop("disabled", true);
    	
        
        console.log("selectedFiles:" + JSON.stringify(this.selectedFiles, null, 2));
        console.log("Upload result 2: " + JSON.stringify(this.uploadedFiles, null, 2));
        console.log("Attatch result: " + JSON.stringify(result, null, 2));
      },
      error: (xhr, status, err) => {
        console.error(`[Upload] ${this.type} - 업로드 실패`, status, err);
        alert("업로드 실패");
      }
    });
  }
}
