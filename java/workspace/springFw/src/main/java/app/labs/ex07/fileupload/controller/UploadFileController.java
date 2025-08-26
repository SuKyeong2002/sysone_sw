package app.labs.ex07.fileupload.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import app.labs.ex07.fileupload.model.UploadFile;
import app.labs.ex07.fileupload.service.IUploadFileService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UploadFileController {

	@Autowired
	IUploadFileService uploadFileService;
	
	// 파일 업로드 페이지
	@GetMapping(value={"/upload/", "/upload"})
	public String getIndex(Model modle) {
		return "index";
	}
	
	// 파일 등록 입력
	@GetMapping(value="/upload/new")
	public String UploadFile(Model modle) {
		return "form";
	}
	
	// 파일 등록 요청
	@PostMapping(value="/upload/new")
	public String UploadFile(@RequestParam(value="dir", required=false, defaultValue="/") 
	String dir, @RequestParam MultipartFile file, RedirectAttributes redirectAttr) {
		
		// log.debug(file.getOriginalFilename());
		
		try {
			// uploadFileService.uploadFile(null);
			uploadFileService.uploadFile(UploadFile.builder()
	            .directoryName(dir)
	            .fileName(file.getOriginalFilename())
	            .fileSize(file.getSize())
	            .fileContentType(file.getContentType())
	            .fileData(file.getBytes())
	            .build());
			
		} catch (Exception ex) {
			log.debug(ex.getMessage());
			redirectAttr.addFlashAttribute("message", ex.getMessage());
			
			
		}
		
		return "redirect:/upload/";
	}
	
	// 전체 파일 목록 조회
	@GetMapping(value="/upload/list")
	public String getFileList(Model model) {
		model.addAttribute("fileList", uploadFileService.getAllFileList());
		return "list";
	}
	
	// 특정 파일 목록 조회
	@GetMapping(value="/upload/list/{dir}")
	public String getFileListByDir(@PathVariable String dir, Model model) {
		// db에 슬래시 들어가있기 때문에 더해줘야 함
		model.addAttribute("fileList", uploadFileService.getFileList("/" + dir));
		return "list";
	}
	
	// 특정 파일 목록 조회
	@GetMapping(value="/upload/gallery")
	public String getImageList(@RequestParam(value="dir", required=false, defaultValue="/images") 
		String dir, Model model) {
		// db에 슬래시 들어가있기 때문에 더해줘야 함
		model.addAttribute("fileList", uploadFileService.getFileList(dir));
		return "list";
	}
	
	// 바이너리 파일 조회
	@GetMapping(value="/upload/file/{fileId}")
	public ResponseEntity<byte[]> getBinaryFile(@PathVariable int fileId) {
		final HttpHeaders headers = new HttpHeaders();
		
		UploadFile file = uploadFileService.getFile(fileId);
		
		if(file != null) {
			String[] mtypes = file.getFileContentType().split("/");
			headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
			headers.setContentLength(file.getFileSize());
			
			// 운영체제마다 인코딩 처리해줘야 함 (필수)
			try {
				String fileName = URLEncoder.encode(file.getFileName(), "UTF-8");
				headers.setContentDispositionFormData("attachment", file.getFileName());
			} catch (UnsupportedEncodingException e) {
				throw new RuntimeException();
			}
			
			return  new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
		} else {
			// 400 error 리턴
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
	}
	
	// 파일 삭제
	@RequestMapping(value="/upload/delete/{fileId}")
	public String deleteFile(@PathVariable int fileId) {
		uploadFileService.deleteFile(fileId);
		return "redirect:/upload/list";
	}
	
	// 파일 수정
	@PostMapping(value="/upload/updateDir")
	public String updateDirectory(@RequestParam int[] fileIds, @RequestParam String directoryName) {
		uploadFileService.updateDirectory(fileIds, directoryName);
		return "redirect:/upload/list";
	}
}
