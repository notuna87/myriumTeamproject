/**
 * UploadManager 모듈 (STS3 호환)
 */

console.log("file_upload Module........");

(function () {
  function UploadManager(config) {
    var defaultOptions = {
      maxFiles: 3,
      uploadUrl: "/uploadAjaxAction",
      deleteUrl: "/deleteFile",
      generateThumbnail: false,
      // uploadListSelector는 존재하지 않을 수 있으므로 기본값 설정 권장
      uploadInputSelector: "#uploadInput",
      uploadListSelector: "#uploadList",
      uploadBtnSelector: "#uploadBtn",
      attachListJsonSelector: "#attachListJson",
    };

    // 사용자 config 병합
    this.options = Object.assign({}, defaultOptions, config);

    this.uploadInput = document.querySelector(this.options.uploadInputSelector);
    this.uploadBtn = document.querySelector(this.options.uploadBtnSelector);
    this.attachListJson = document.querySelector(this.options.attachListJsonSelector);

    // uploadList는 동적 생성 가능하므로 초기에는 찾되 없으면 null 허용
    this.uploadList = document.querySelector(this.options.uploadListSelector) || null;

    this.maxFiles = this.options.maxFiles;
    this.uploadUrl = this.options.uploadUrl;
    this.deleteUrl = this.options.deleteUrl;
    this.generateThumbnail = this.options.generateThumbnail;

    var csrfHeaderMeta = document.querySelector("meta[name='_csrf_header']");
    var csrfTokenMeta = document.querySelector("meta[name='_csrf']");
    this.csrfHeader = csrfHeaderMeta ? csrfHeaderMeta.content : null;
    this.csrfToken = csrfTokenMeta ? csrfTokenMeta.content : null;

    this.regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$", "i");
    this.maxSize = 5 * 1024 * 1024;

    this.selectedFiles = [];
    this.uploadedFileList = [];
    this.uploadCompleted = false;

    this.init();
  }

  UploadManager.prototype.init = function () {
    var self = this;
    if (!self.uploadInput || !self.uploadBtn) {
      console.error("UploadManager: 필수 DOM 요소(uploadInput, uploadBtn)가 없습니다.");
      return;
    }

    // uploadList는 없을 수 있으므로 없어도 에러 안냄
    if (!self.uploadList) {
      console.warn("UploadManager: uploadList 요소가 아직 존재하지 않습니다. 동적 생성시 재할당 필요.");
    }

    self.bindEvents();
  };

  UploadManager.prototype.bindEvents = function () {
    var self = this;

    self.uploadInput.addEventListener("change", function (e) {
      self.handleFileSelect(e);
    });

    self.uploadBtn.addEventListener("click", function (e) {
      self.handleUpload(e);
    });

    var resetBtn = document.querySelector('button[type="reset"]');
    if (resetBtn) {
      resetBtn.addEventListener("click", function (e) {
        self.handleReset(e);
      });
    }
  };

  UploadManager.prototype.handleReset = function (e) {
    e.preventDefault();
    var self = this;

    if (self.uploadedFileList.length > 0) {
      var deletePromises = self.uploadedFileList.map(function (fileObj) {
        var fileCallPath = encodeURIComponent(
          fileObj.uploadPath.replace(/\\/g, "/") + "/" + fileObj.uuid + "_" + fileObj.fileName
        );
        return self.deleteFileOnServer(fileCallPath, fileObj.image ? "image" : "file");
      });

      Promise.all(deletePromises).catch(function (err) {
        console.error("서버 파일 삭제 중 오류:", err);
        alert("업로드된 파일 삭제 중 오류가 발생했습니다.");
      });
    }

    self.selectedFiles = [];
    self.uploadedFileList = [];
    self.uploadCompleted = false;

    // uploadList가 없으면 다시 찾음 or 생성 (선택적)
    self.uploadList = document.querySelector(self.options.uploadListSelector);
    if (self.uploadList) {
      self.uploadList.innerHTML = "";
    }

    if (self.uploadInput) self.uploadInput.value = "";
    if (self.attachListJson) self.attachListJson.value = "";
  };

  UploadManager.prototype.deleteFileOnServer = function (fileName, type) {
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    if (this.csrfHeader && this.csrfToken) {
      headers[this.csrfHeader] = this.csrfToken;
    }

    return fetch(this.deleteUrl, {
      method: "POST",
      headers: headers,
      body: new URLSearchParams({ fileName: fileName, type: type }),
    }).then(function (response) {
      if (!response.ok) throw new Error("파일 삭제 실패");
      return response.text();
    });
  };

  UploadManager.prototype.checkExtension = function (file) {
    if (this.regex.test(file.name)) {
      alert("❗ 허용되지 않는 확장자입니다: " + file.name);
      return false;
    }
    if (file.size >= this.maxSize) {
      alert("❗ 파일이 너무 큽니다: " + file.name);
      return false;
    }
    return true;
  };

  UploadManager.prototype.handleFileSelect = function (e) {
    var files = Array.prototype.slice.call(e.target.files);
    var self = this;

    if (self.selectedFiles.length + files.length > self.maxFiles) {
      alert("❗ 최대 " + self.maxFiles + "개까지 파일을 업로드할 수 있습니다.");
      self.uploadInput.value = "";
      return;
    }

    files.forEach(function (file) {
      if (self.checkExtension(file)) {
        self.selectedFiles.push(file);
      }
    });

    self.updateFileListUI();
    self.uploadInput.value = "";
  };

  UploadManager.prototype.updateFileListUI = function () {
    var self = this;

    // uploadList가 없으면 동적으로 찾기 시도
    if (!self.uploadList) {
      self.uploadList = document.querySelector(self.options.uploadListSelector);
      if (!self.uploadList) {
        // 동적으로 uploadList 생성 필요하면 여기서 생성 가능
        // 예) form-group 내부 적당한 위치에 ul#uploadList 생성
        var container = document.querySelector(".form-group"); // 필요에 따라 적절히 수정
        if (container) {
          self.uploadList = document.createElement("ul");
          self.uploadList.id = self.options.uploadListSelector.replace("#", "");
          self.uploadList.className = "list-group";
          container.appendChild(self.uploadList);
        } else {
          console.warn("UploadManager: uploadList를 생성할 컨테이너를 찾을 수 없습니다.");
          return;
        }
      }
    }

    self.uploadList.innerHTML = "";

    self.selectedFiles.forEach(function (file, index) {
      var li = document.createElement("li");
      li.className = "list-group-item d-flex align-items-center justify-content-between";

      var content = document.createElement("div");
      content.className = "d-flex align-items-center";

      if (file.type.indexOf("image/") === 0) {
        var reader = new FileReader();
        reader.onload = function (e) {
          var img = document.createElement("img");
          img.src = e.target.result;
          img.style.width = "40px";
          img.style.height = "40px";
          img.style.objectFit = "cover";
          img.style.marginRight = "10px";
          content.prepend(img);
        };
        reader.readAsDataURL(file);
      } else {
        var icon = document.createElement("i");
        icon.className = "fas fa-file-alt mr-2";
        content.appendChild(icon);
      }

      var span = document.createElement("span");
      span.textContent = file.name;
      content.appendChild(span);

      var delBtn = document.createElement("button");
      delBtn.type = "button";
      delBtn.className = "btn btn-sm btn-danger ml-2";
      delBtn.textContent = "삭제";
      delBtn.addEventListener("click", function () {
        self.selectedFiles.splice(index, 1);
        self.updateFileListUI();
      });

      li.appendChild(content);
      li.appendChild(delBtn);
      self.uploadList.appendChild(li);
    });
  };

  UploadManager.prototype.handleUpload = function (e) {
    e.preventDefault();
    var self = this;

    if (self.selectedFiles.length === 0) {
      alert("업로드할 파일을 먼저 선택해주세요.");
      return;
    }

    var formData = new FormData();
    self.selectedFiles.forEach(function (file) {
      formData.append("uploadFile", file);
    });

    var headers = {};
    if (self.csrfHeader && self.csrfToken) {
      headers[self.csrfHeader] = self.csrfToken;
    }

    fetch(self.uploadUrl, {
      method: "POST",
      body: formData,
      headers: headers,
    })
      .then(function (response) {
        if (!response.ok) throw new Error("업로드 실패");
        return response.json();
      })
      .then(function (result) {
        console.log("Attach result:", result);
        self.showUploadedFiles(result);
        self.uploadedFileList = result;
        self.selectedFiles = [];
        self.uploadCompleted = true;
        self.updateFileListUI();
        if (self.attachListJson) {
          self.attachListJson.value = JSON.stringify(result);
        }
      })
      .catch(function (error) {
        alert("파일 업로드 중 오류가 발생했습니다.");
        console.error(error);
      });
  };

  UploadManager.prototype.showUploadedFiles = function (uploadResultArr) {
    var self = this;

    // uploadList가 없으면 다시 찾기 시도
    if (!self.uploadList) {
      self.uploadList = document.querySelector(self.options.uploadListSelector);
      if (!self.uploadList) {
        console.warn("UploadManager: 업로드된 파일 표시용 uploadList를 찾을 수 없습니다.");
        return;
      }
    }

    self.uploadList.innerHTML = "";

    uploadResultArr.forEach(function (obj) {
      var li = document.createElement("li");
      li.className = "list-group-item d-flex justify-content-between align-items-center";

      var content = document.createElement("div");
      content.className = "d-flex align-items-center";

      if (obj.image) {
        var img = document.createElement("img");
        img.src =
          "/display?fileName=" +
          encodeURIComponent(obj.uploadPath.replace(/\\/g, "/") + "/s_" + obj.uuid + "_" + obj.fileName);
        img.style.width = "40px";
        img.style.height = "40px";
        img.style.objectFit = "cover";
        img.style.marginRight = "10px";
        content.appendChild(img);
      } else {
        var icon = document.createElement("i");
        icon.className = "fas fa-file-alt mr-2";
        content.appendChild(icon);
      }

      var span = document.createElement("span");
      span.textContent = obj.fileName;
      content.appendChild(span);

      var delBtn = document.createElement("button");
      delBtn.type = "button";
      delBtn.className = "btn btn-danger btn-sm";
      delBtn.textContent = "삭제";
      delBtn.style.display = "none"; // 업로드 후 삭제 숨김

      li.appendChild(content);
      li.appendChild(delBtn);
      self.uploadList.appendChild(li);
    });
  };

  // 전역 등록
  window.UploadManager = UploadManager;
})();
