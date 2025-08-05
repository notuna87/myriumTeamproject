class PreviewUploader {
	constructor(type, initialFiles = []) {
		this.type = type;  // "Thumbnail" or "Detail"
		this.selectedFiles = initialFiles;		
	}



// 새로운 메서드 추가
editMode() {
    // UploadManager를 다시 초기화하며 기존 selectedFiles를 넘겨줌
    const manager = this.type === "Thumbnail" ? uploadThumbnailManager : uploadDetailManager;
    manager.selectedFiles = [...this.selectedFiles];


    //manager.updatePreviewList();
    manager.updateUploadedUI();  // 미리보기 복구
    
    manager.uploadCompleted = false;
    manager["uploadCompleted" + this.type] = false;
    
    $(`#${manager.buttonId}`).show();
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
		                this.editMode();
		            });

		        btnWrapper.append(editBtn);
		        li.append(btnWrapper);

	
	  
	  list.append(li);      
    });  
  }
  
  	 updatePreviewList() {
		    const list = $("#uploadList" + this.type);
		    if (list.length === 0) return;

		    list.empty();
		    const radioName = "thumbnailMain";

		    this.selectedFiles.forEach((file, idx) => {
		        const li = $("<li>").addClass("list-group-item d-flex justify-content-between align-items-center");
		        const content = $("<div>").addClass("d-flex align-items-center");

		        const img = $("<img>").attr("src", "/upload/" + (file.img_path_thumb || file.img_path)).css({
		            width: this.type === "Detail" ? "100%" : "40px",
		            height: this.type === "Detail" ? "auto" : "40px",
		            objectFit: "cover",
		            marginRight: "10px",
		            cursor: "pointer"
		        }).on("click", () => {
		            const win = window.open();
		            win.document.write(`<img src="/upload/${file.img_path}" style="max-width:100%">`);
		        });

		        content.prepend(img);
		        content.append($("<span>").text(file.name));

		        // 대표 이미지 선택 라디오 버튼
		        if (this.type === "Thumbnail") {
			      const textWrapper = $("<div>").addClass("d-flex flex-column align-items-center ms-4");
		          const label = $("<span>").text("대표 이미지").addClass("label label-primary");	
			      textWrapper.append(label);
			      content.append(textWrapper);
		        }

		        const btnWrapper = $("<div>").addClass("text-right mt-3");

		        // 삭제 버튼 숨김
		        const delBtn = $("<button type='button'>")
		            .addClass("btn btn-sm btn-danger ml-2")
		            .text("삭제")
		            .hide();
		        btnWrapper.append(delBtn);

		        // 수정 버튼
		        const editBtn = $("<button type='button'>")
		            .addClass("btn btn-sm btn-primary ml-2")
		            .text("수정")
		            .on("click", () => {
		                this.editMode();
		            });

		        btnWrapper.append(editBtn);

		        li.append(content, btnWrapper);
		        list.append(li);
		    });
		}


}