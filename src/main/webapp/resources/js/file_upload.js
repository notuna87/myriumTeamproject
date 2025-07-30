/**
 *
 */

console.log("file_upload Module........");

export class UploadManager {
  constructor(config) {
    const defaultOptions = {
      maxFiles: 3,
      uploadUrl: "/uploadAjaxAction",
      deleteUrl: "/deleteFile",
      generateThumbnail: false, // 기본은 썸네일 미생성
    };

    // 사용자 config 병합
    this.options = Object.assign({}, defaultOptions, config);

    // config 객체로 주요 선택자, 최대 파일 수 등 설정 가능
    this.uploadInput = document.querySelector(this.options.uploadInputSelector);
    this.uploadList = document.querySelector(this.options.uploadListSelector);
    this.uploadBtn = document.querySelector(this.options.uploadBtnSelector);
    this.attachListJson = document.querySelector(
      this.options.attachListJsonSelector
    ); // 숨은 input
    this.maxFiles = this.options.maxFiles;
    this.uploadUrl = this.options.uploadUrl;
    this.deleteUrl = this.options.deleteUrl;
    this.generateThumbnail = this.options.generateThumbnail;

    // CSRF 토큰 헤더 이름과 값
    this.csrfHeader = document.querySelector(
      "meta[name='_csrf_header']"
    )?.content;
    this.csrfToken = document.querySelector("meta[name='_csrf']")?.content;

    this.regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$", "i");
    this.maxSize = 5 * 1024 * 1024; // 5MB

    // 상태 변수
    this.selectedFiles = [];
    this.uploadedFileList = [];
    this.uploadCompleted = false;

    // 이벤트 바인딩
    this.init();
  }

  init() {
    if (!this.uploadInput || !this.uploadList || !this.uploadBtn) {
      console.error("UploadManager: 필수 DOM 요소가 없습니다.");
      return;
    }

    this.uploadInput.addEventListener("change", (e) =>
      this.handleFileSelect(e)
    );
    this.uploadBtn.addEventListener("click", (e) => this.handleUpload(e));

    // reset 버튼 이벤트 처리
    const resetBtn = document.querySelector('button[type="reset"]');
    if (resetBtn) {
      resetBtn.addEventListener("click", (e) => this.handleReset(e));
    }
  }

  async handleReset(e) {
    e.preventDefault();

    // 서버에 업로드된 파일 삭제 요청
    if (this.uploadedFileList.length > 0) {
      try {
        for (const fileObj of this.uploadedFileList) {
          const fileCallPath = encodeURIComponent(
            fileObj.uploadPath.replace(/\\/g, "/") +
              "/" +
              fileObj.uuid +
              "_" +
              fileObj.fileName
          );
          await this.deleteFileOnServer(
            fileCallPath,
            fileObj.image ? "image" : "file"
          );
        }
      } catch (err) {
        console.error("서버 파일 삭제 중 오류:", err);
        alert("업로드된 파일 삭제 중 오류가 발생했습니다.");
        return;
      }
    }

    // 클라이언트 상태 초기화
    this.selectedFiles = [];
    this.uploadedFileList = [];
    this.uploadCompleted = false;
    this.uploadList.innerHTML = "";
    if (this.uploadInput) this.uploadInput.value = "";
    if (this.attachListJson) this.attachListJson.value = "";

    // 필요하면 폼도 리셋
    // e.target.closest('form').reset(); // 직접 폼 리셋 호출 가능
  }

  deleteFileOnServer(fileName, type) {
    return fetch(this.deleteUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        ...(this.csrfHeader && this.csrfToken
          ? { [this.csrfHeader]: this.csrfToken }
          : {}),
      },
      body: new URLSearchParams({ fileName, type }),
    }).then((response) => {
      if (!response.ok) throw new Error("파일 삭제 실패");
      return response.text();
    });
  }

  checkExtension(file) {
    const fileSizeMB = (file.size / (1024 * 1024)).toFixed(2);
    const maxSizeMB = (this.maxSize / (1024 * 1024)).toFixed(2);

    if (this.regex.test(file.name)) {
      alert(`❗ 파일 [ ${file.name} ]은 허용되지 않는 확장자입니다.`);
      return false;
    }
    if (file.size >= this.maxSize) {
      alert(
        `❗ 파일이 [ ${file.name} ] ${fileSizeMB}MB 너무 큽니다. (허용 용량 : ${maxSizeMB}MB)`
      );
      return false;
    }
    return true;
  }

  handleFileSelect(e) {
    const files = Array.from(e.target.files);

    if (this.selectedFiles.length + files.length > this.maxFiles) {
      alert(`❗ 최대 ${this.maxFiles}개까지 파일을 업로드할 수 있습니다.`);
      this.uploadInput.value = "";
      return;
    }

    files.forEach((file) => {
      if (this.checkExtension(file)) {
        this.selectedFiles.push(file);
      }
    });

    this.updateFileListUI();

    // input 초기화 (동일 파일 재선택시 이벤트 발생을 위해)
    this.uploadInput.value = "";
  }

  updateFileListUI() {
    this.uploadList.innerHTML = "";

    this.selectedFiles.forEach((file, index) => {
      const li = document.createElement("li");
      li.className =
        "list-group-item d-flex align-items-center justify-content-between";

      const content = document.createElement("div");
      content.className = "d-flex align-items-center";

      if (file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = (e) => {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.style.width = "40px";
          img.style.height = "40px";
          img.style.objectFit = "cover";
          img.style.marginRight = "10px";
          content.prepend(img);
        };
        reader.readAsDataURL(file);
      } else {
        const icon = document.createElement("i");
        icon.className = "fas fa-file-alt mr-2";
        content.appendChild(icon);
      }

      const span = document.createElement("span");
      span.textContent = file.name;
      content.appendChild(span);

      const delBtn = document.createElement("button");
      delBtn.type = "button";
      delBtn.className = "btn btn-sm btn-danger ml-2";
      delBtn.textContent = "삭제";
      delBtn.addEventListener("click", () => {
        this.selectedFiles.splice(index, 1);
        this.updateFileListUI();
      });

      li.appendChild(content);
      li.appendChild(delBtn);

      this.uploadList.appendChild(li);
    });
  }

  async handleUpload(e) {
    e.preventDefault();

    if (this.selectedFiles.length === 0) {
      alert("업로드할 파일을 먼저 선택해주세요.");
      return;
    }

    const formData = new FormData();
    this.selectedFiles.forEach((file) => formData.append("uploadFile", file));

    try {
      const response = await fetch(this.uploadUrl, {
        method: "POST",
        body: formData,
        headers:
          this.csrfHeader && this.csrfToken
            ? { [this.csrfHeader]: this.csrfToken }
            : {},
      });

      if (!response.ok) throw new Error("업로드 실패");

      const result = await response.json();

      console.log("Attach result:", result);

      this.showUploadedFiles(result);
      this.uploadedFileList = result;
      this.selectedFiles = [];
      this.uploadCompleted = true;
      this.updateFileListUI();

      if (this.attachListJson) {
        this.attachListJson.value = JSON.stringify(result);
      }
    } catch (error) {
      alert("파일 업로드 중 오류가 발생했습니다.");
      console.error(error);
    }
  }

  showUploadedFiles(uploadResultArr) {
    this.uploadList.innerHTML = "";

    uploadResultArr.forEach((obj) => {
      const li = document.createElement("li");
      li.className =
        "list-group-item d-flex justify-content-between align-items-center";

      const content = document.createElement("div");
      content.className = "d-flex align-items-center";

      if (obj.image) {
        const img = document.createElement("img");
        img.src = `/display?fileName=${encodeURIComponent(
          obj.uploadPath.replace(/\\/g, "/") +
            "/s_" +
            obj.uuid +
            "_" +
            obj.fileName
        )}`;
        img.style.width = "40px";
        img.style.height = "40px";
        img.style.objectFit = "cover";
        img.style.marginRight = "10px";
        content.appendChild(img);
      } else {
        const icon = document.createElement("i");
        icon.className = "fas fa-file-alt mr-2";
        content.appendChild(icon);
      }

      const span = document.createElement("span");
      span.textContent = obj.fileName;
      content.appendChild(span);

      const delBtn = document.createElement("button");
      delBtn.type = "button";
      delBtn.className = "btn btn-danger btn-sm";
      delBtn.textContent = "삭제";
      delBtn.style.display = "none"; // 업로드 후 삭제버튼 숨김
      // 필요시 삭제 이벤트 추가 가능
      // delBtn.addEventListener('click', () => { ... });

      li.appendChild(content);
      li.appendChild(delBtn);

      this.uploadList.appendChild(li);
    });
  }
}
