package com.myrium.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.myrium.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}

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

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload Ajax");
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
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			//File saveFile = new File(uploadPath, uploadFileName);

			try {
				File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
				// multipartFile.transferTo(saveFile);
				multipartFile.transferTo(savefile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// if (checkImageType(saveFile)) {
				if (checkImageType(savefile)) {

					attachDTO.setImage(true);

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
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
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
	    log.info("deleteFile: " + fileName);

	    try {
	        // 1. 파일명 디코딩
	        String decodedFileName = URLDecoder.decode(fileName, "UTF-8");
	        log.info("decodedFileName: " + decodedFileName);

	        // 2. 업로드 기본 경로
	        String basePath = "c:" + File.separator + "upload";

	        // 3. 전체 경로 생성 (썸네일 경로 혹은 일반 파일 경로)
	        String fullPath = basePath + File.separator + decodedFileName.replace("/", File.separator);
	        log.info("fullPath: " + fullPath);
	        
	        originalFilePath = basePath + 

	        // 4. 해당 파일(썸네일 또는 일반 파일) 삭제
	        File file = new File(fullPath);
	        boolean result = false;
	        if (file.exists()) {
	            result = file.delete();
	        }
	        log.info("file deleted: " + result);

	        // 5. 이미지일 경우, 원본 이미지도 삭제
	        if ("image".equals(type)) {
	            // 썸네일이라면 's_' 접두사를 제거한 파일명을 만들어 원본 이미지 경로 생성
	            String originalFileName = new File(decodedFileName).getName().replace("s_", "");
	            String uploadFolder = new File(decodedFileName).getParent(); // 예: 2025/07/28
	            String originalPath = basePath + File.separator + uploadFolder.replace("/", File.separator)
	                    + File.separator + originalFileName;

	            log.info("original image path: " + originalPath);

	            File originalFile = new File(originalPath);
	            if (originalFile.exists()) {
	                boolean originDeleted = originalFile.delete();
	                log.info("original image deleted: " + originDeleted);
	            }
	        }

	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    return new ResponseEntity<>("deleted", HttpStatus.OK);
	}

}
