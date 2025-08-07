package com.myrium.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.myrium.domain.AttachFileDTO;
import com.myrium.service.NoticeService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@Autowired
	private NoticeService noticeService;

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "c:\\upload";

		for (MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------");
			log.info("upload File Name : " + multipartFile.getOriginalFilename());
			log.info("upload File Size : " + multipartFile.getSize());

			File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(savefile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(
	        @RequestParam(required = false, defaultValue = "File") String type,
	        @RequestParam("uploadFile") MultipartFile[] uploadFile,
	        @RequestParam Map<String, String> params
	) {
	    List<AttachFileDTO> list = new ArrayList<>();
	    String baseFolder = "C:\\upload";
	    String dateFolder = getFolder(); // 예: 2025/08/02
	    String subFolder;

	    // 타입별 하위경로 결정
	    if (type.equalsIgnoreCase("thumbnail")) {
	        subFolder = "product/img/thumbnail";
	    } else if (type.equalsIgnoreCase("detail")) {
	        subFolder = "product/img/detail";
	    } else {
	        subFolder = "file"; // file 또는 기타
	    }

	    File uploadPath = new File(baseFolder, subFolder + "/" + dateFolder);
	    if (!uploadPath.exists()) {
	        uploadPath.mkdirs();
	    }

	    for (int i = 0; i < uploadFile.length; i++) {
	        MultipartFile multipartFile = uploadFile[i];
	        String originalFilename = multipartFile.getOriginalFilename();
	        if (originalFilename == null) continue;

	        originalFilename = originalFilename.substring(originalFilename.lastIndexOf("\\") + 1);
	        UUID uuid = UUID.randomUUID();
	        String uuidFileName = uuid + "_" + originalFilename;

	        File saveFile = new File(uploadPath, uuidFileName);
	        try {
	            multipartFile.transferTo(saveFile);

	            AttachFileDTO dto = new AttachFileDTO();
	            dto.setFileName(originalFilename);
	            dto.setUuid(uuid.toString());
	            dto.setUploadPath(subFolder + "/" + dateFolder);

	            // 타입별 처리
	            if (type.equalsIgnoreCase("detail")) {
	                dto.setIsThumbnail(0);
	                dto.setIsThumbnailMain(0);
	                dto.setIsDetail(1);
	                dto.setImage(1);
	                // 썸네일 생략	            
	            } else if (type.equalsIgnoreCase("thumbnail") || checkImageType(saveFile)) {
	                dto.setIsThumbnail(1);
	                dto.setIsThumbnailMain(parseFlag(params, "isThumbnailMain_" + i));
	                dto.setIsDetail(0);

	                // 썸네일 생성 (100x100) => s_파일명
	                FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uuidFileName));
	                Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
	                thumbnail.close();

	                dto.setImage(1); // 이미지 여부
	            } else {
	                // file type (기존 로직 유지)
	                dto.setImage(checkImageType(saveFile) ? 1 : 0);
	            }

	            list.add(dto);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
		// is_thumbnail_main 등의 boolean 플래그 처리 도우미
	private int parseFlag(Map<String, String> params, String key) {
	    return "1".equals(params.getOrDefault(key, "0")) ? 1 : 0;
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date); // 2024-02-12
		//return str.replace("-", File.separator);
		return str.replace("-", "/");
	}

	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("display _fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	@GetMapping("/download")
	public ResponseEntity<Resource> downloadFile(String uuid, String path, String filename) throws Exception {
		// String fullPath = "c:\\upload\\" + path + "\\" + uuid + "_" + filename;
		String fullPath = "c:\\upload\\" + uuid + "_" + filename;
		Resource resource = new FileSystemResource(fullPath);

		if (!resource.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String encodedName = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedName + "\"").body(resource);
	}

	@PostMapping("/deleteUploadedFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String datePath, String fileName,
			@RequestParam(required = false) String uuid,
			@RequestParam(required = false) String type,
			@RequestParam(required = false, defaultValue = "false") boolean isUpdate
			) {
		
		try {

			String decodedDatePath = URLDecoder.decode(datePath, "UTF-8");
			String decodedFileName = URLDecoder.decode(fileName, "UTF-8");

			// 1. 원본 파일 삭제
			File file = new File("C:/upload/" + decodedDatePath + "\\" + uuid + "_" + decodedFileName);
			log.info("delete file_path :" + file);
			if (file.exists()) {
				file.delete();
			}

			// 2. 썸네일 삭제
			if ("image".equals(type)) {
				File thumb = new File("C:/upload/" + decodedDatePath + "\\s_" + uuid + "_" + decodedFileName);
				log.info("delete thumb_path :" + thumb);
				if (thumb.exists()) {
					thumb.delete();
				}
			}

			// 3. DB 삭제는 수정 페이지일 때만
			if (isUpdate) {
				int deletedCount = noticeService.deleteAttachByUuid(uuid);
				log.info("DB에서 삭제된 파일 개수: " + deletedCount);
			}

			return ResponseEntity.ok("deleted");

		} catch (Exception e) {
			log.error("파일 삭제 중 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}

}
