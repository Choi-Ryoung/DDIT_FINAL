package kr.or.ddit.member.notice.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeFileVO {
	private int ntFileSn;
	private int ntPstNo;
	private String ntFileNm;
	private long ntFileSz;
	private String ntFileFancysize;
	private String ntFileMime;
	private String ntFileSavepath;
	private MultipartFile item;

	public NoticeFileVO() {
	}

	public NoticeFileVO(MultipartFile item) {
		this.item = item;
		this.ntFileNm = item.getOriginalFilename();
		this.ntFileSz = item.getSize();
		this.ntFileMime = item.getContentType();
		this.ntFileFancysize = FileUtils.byteCountToDisplaySize(ntFileSz);
	}
}
