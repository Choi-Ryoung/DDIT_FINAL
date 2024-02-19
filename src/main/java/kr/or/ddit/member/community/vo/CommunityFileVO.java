package kr.or.ddit.member.community.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CommunityFileVO {
	private int comntFileSn;
	private int comntPstNo;
	private String comntFileNm;
	private long comntFileSz;
	private String comntFileFancysize;
	private String comntFileMime;
	private String comntFileSavepath;
	private MultipartFile item;

	public CommunityFileVO() {
	}

	public CommunityFileVO(MultipartFile item) {
		this.item = item;
		this.comntFileNm = item.getOriginalFilename();
		this.comntFileSz = item.getSize();
		this.comntFileMime = item.getContentType();
		this.comntFileFancysize = FileUtils.byteCountToDisplaySize(comntFileSz);
	}
}
