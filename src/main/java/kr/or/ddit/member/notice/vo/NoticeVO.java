package kr.or.ddit.member.notice.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
	private int ntPstNo;
	private String ntPstTtl;
	private String ntWrtrNm;
	private String ntPstCn;
	private String ntWrtDt;
	private int ntInqCnt;
	private String ntTitle;
	private String ntContent;
	private String tag;
	private List<NoticeFileVO> noticeFileList; 
	private MultipartFile[] ntFile;
	private Integer[] DelNoticeNo;

	// 세터 이름과 충돌 나지 않게
	public void setNtFile(MultipartFile[] ntFile) {
		this.ntFile = ntFile;
		if (ntFile != null) {
			List<NoticeFileVO> noticeFileList = new ArrayList<NoticeFileVO>();
			for (MultipartFile item : ntFile) {
				if (StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				NoticeFileVO noticeFileVO = new NoticeFileVO(item);
				noticeFileList.add(noticeFileVO);
			}
			this.noticeFileList = noticeFileList;
		}
	}

}

