package app.labs.ex07.fileupload.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude= {"fileData"})
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UploadFile {
	private int fileId;
    private String directoryName;
    private String fileName;
    private long fileSize;
    private String fileContentType;
    private Timestamp fileUploadDate;
    private byte[] fileData;
}
