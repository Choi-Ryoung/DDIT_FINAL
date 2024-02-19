package kr.or.ddit.admin.answer.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AnswerFileVO {
	private int ansFileSn;
	private int ansNo;
	private String ansFileNm;
	private long ansFileSz;
	private String ansFileFancysize;
	private String ansFileMime;
	private String ansFileSavepath;
	private MultipartFile item;

	public AnswerFileVO() {
	}

	public AnswerFileVO(MultipartFile item) {
		this.item = item;
		this.ansFileNm = item.getOriginalFilename();
		this.ansFileSz = item.getSize();
		this.ansFileMime = item.getContentType();
		this.ansFileFancysize = FileUtils.byteCountToDisplaySize(ansFileSz);
	}
}
