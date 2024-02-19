package kr.or.ddit.member.mentoring.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MentoringFileVO {
	private MultipartFile item;
	private Integer menFileSn;
	private String menNcnm;
	private String menFileNm;
	private Long menFileSz;
	private String menFileFancysize;
	private String menFileMime;
	private String menFileSavepath;
	
	public MentoringFileVO() {}
	public MentoringFileVO(MultipartFile item) {
		this.item = item;
		this.menFileNm = item.getOriginalFilename();
		this.menFileSz = item.getSize();
		this.menFileMime = item.getContentType();
		this.menFileFancysize = FileUtils.byteCountToDisplaySize(menFileSz);
	}
}
