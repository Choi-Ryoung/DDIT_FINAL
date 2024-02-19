package kr.or.ddit.member.apply.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ApplyFileVO {
	private MultipartFile item;
	private Integer boNo;
	private Integer fileNo;
	private String fileName;
	private long fileSize;
	private String fileFancysize;
	private String fileMime;
	private String fileSavepath;
	private int fileDowncount;
	
	public ApplyFileVO() {}
	
	public ApplyFileVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}
}
