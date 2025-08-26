package app.labs.ex07.fileupload.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import app.labs.ex07.fileupload.dao.IUploadFileRepository;
import app.labs.ex07.fileupload.model.UploadFile;

@Service
public class UploadFileService implements IUploadFileService {

	@Autowired
	IUploadFileRepository uploadFileRepository;
	
	@Override
	public void uploadFile(UploadFile file) {
		int newFileId = uploadFileRepository.getMaxFileId();
		file.setFileId(newFileId);
		uploadFileRepository.uploadFile(file);
	}

	@Override
	public List<UploadFile> getFileList(String dir) {
		return uploadFileRepository.getFileList(dir);
	}

	@Override
	public List<UploadFile> getAllFileList() {
		return uploadFileRepository.getAllFileList();
	}

	@Override
	public List<UploadFile> getImageList(String dir) {
		return uploadFileRepository.getImageList(dir);
	}

	@Override
	public UploadFile getFile(int fileId) {
		return uploadFileRepository.getFile(fileId);
	}

	@Override
	public String getDirectoryName(int fileId) {
		return uploadFileRepository.getDirectoryName(fileId);
	}
	
	// @Transactional : 개수만큼 업데이트 
	@Override
	@Transactional
	public void updateDirectory(int[] fileIds, String directoryName) {
		for (int fileId : fileIds) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("directoryName", directoryName);
			map.put("fileId", fileId);
			uploadFileRepository.updateDirectory(map);
		}
	}

	@Override
	public void deleteFile(int fileId) {
		uploadFileRepository.deleteFile(fileId);
	}

}
