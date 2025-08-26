package app.labs.ex07.fileupload.dao;

import java.util.HashMap;
import java.util.List;

import app.labs.ex07.fileupload.model.UploadFile;

public interface IUploadFileRepository {
	int getMaxFileId();
    void uploadFile(UploadFile file);

    List<UploadFile> getFileList(String directoryName);
    List<UploadFile> getAllFileList();
    List<UploadFile> getImageList(String directoryName);

    UploadFile getFile(int fileId);

    String getDirectoryName(int fileId);
    void updateDirectory(HashMap<String, Object> map);

    void deleteFile(int fileId);
}
