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

        // 대표 이미지
        if (file.is_thumbnail_main === 1) {
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
        li.append(content, btnWrapper);
        list.append(li);
    });
    
    // 수정 버튼
    const labelBox = $(".labelBox" + this.type);
    const editBtn = $("<button type='button'>")
        .addClass("btn btn-success ml-2")
        .text("수정")
        .on("click", () => {
            this.editMode();
        });
    labelBox.prepend(editBtn);
}


}