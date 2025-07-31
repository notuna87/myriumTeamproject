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
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();

		log.info("update ajax post.........");

		String uploadFolder = "C:\\upload";

		File uploadPath = new File(uploadFolder, getFolder()); // C:\\upload\2024\02\12
		log.info("upload path : " + uploadPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		String uploadFolderPath = getFolder(); // 2024/02/12

		for (MultipartFile multipartFile : uploadFile) {

			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			AttachFileDTO attachDTO = new AttachFileDTO();

			String uploadFileName = multipartFile.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			// log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();
			String uuidUploadFileName = uuid.toString() + "_" + uploadFileName;

			//File saveFile = new File(uploadPath, uploadFileName);

			try {
				//File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
				File savefile = new File(uploadFolder, uuidUploadFileName);
				// multipartFile.transferTo(saveFile);
				multipartFile.transferTo(savefile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// if (checkImageType(saveFile)) {
				if (checkImageType(savefile)) {

					attachDTO.setImage(1);

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uuidUploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}

				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			} // end catch

		} // end for

		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date); // 2024-02-12
		return str.replace("-", File.separator);
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
	    //String fullPath = "c:\\upload\\" + path + "\\" + uuid + "_" + filename;
	    String fullPath = "c:\\upload\\" + uuid + "_" + filename;
	    Resource resource = new FileSystemResource(fullPath);

	    if (!resource.exists()) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    String encodedName = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");

	    return ResponseEntity.ok()
	        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedName + "\"")
	        .body(resource);
	}
	
	@PostMapping("/deleteUploadedFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(
			String datePath,
			String fileName,
			String uuid,
			String type,
			@RequestParam(required = false, defaultValue = "false") boolean isUpdate) {
	    try {
	    	
	    	String decodedDatePath = URLDecoder.decode(datePath, "UTF-8");
	    	String decodedFileName = URLDecoder.decode(fileName, "UTF-8");
	    		    	
	        // 1. 원본 파일 삭제
	    	File file = new File("C:/upload/" + uuid + "_" + decodedFileName);
	        log.info("delete file_path :" + file);
	        if (file.exists()) {
	            file.delete();
	        }

	        // 2. 썸네일 삭제
	        if ("image".equals(type)) {
	        	File thumb = new File("C:/upload/" + decodedDatePath + "s_" + uuid + "_" + decodedFileName);
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
