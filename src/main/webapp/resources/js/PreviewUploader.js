class PreviewUploader {
	constructor(type, initialFiles = []) {
		this.type = type;  // "Thumbnail" or "Detail"
		this.selectedFiles = initialFiles;
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
				const radioWrapper = $("<div>").addClass("d-flex flex-column align-items-center ms-4");
				const radioBtn = $("<input type='radio'>")
					.attr("name", radioName)
					.attr("value", file.uuid)
					.addClass("form-check-input mb-1")
					.on("change", () => {
						this.selectedFiles.forEach(f => delete f.is_thumbnail_main);
						file.is_thumbnail_main = 1;
						this.updatePreviewList();
					});

				if (file.is_thumbnail_main || (idx === 0 && !this.selectedFiles.some(f => f.is_thumbnail_main))) {
					radioBtn.prop("checked", true);
					file.is_thumbnail_main = 1;
				}

				const label = $("<small>").text(file.is_thumbnail_main ? "대표 이미지" : "").addClass("text-primary fw-bold");
				radioWrapper.append(radioBtn, label);
				content.append(radioWrapper);
			}

			// 삭제 버튼
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
}