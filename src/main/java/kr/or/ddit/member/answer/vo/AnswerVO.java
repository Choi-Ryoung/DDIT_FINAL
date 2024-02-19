package kr.or.ddit.member.answer.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AnswerVO {
	private int ansNo;
	private int qstnNo;
	private String ansTtl;
	private String ansWrtr;
	private String ansCn;
	private String ansWrtDt;
	private int ansInqCnt;
	private String ansTitle;
	private String ansContent;
	private String tag;
	private List<AnswerFileVO> answerFileList;
	private MultipartFile[] ansFIle;
	private Integer[] DelAnswerNo;

	public void setAnsFile(MultipartFile[] ansFile) {
		this.ansFIle = ansFile;
		if (ansFile != null) {
			List<AnswerFileVO> answerFileList = new ArrayList<AnswerFileVO>();
			for (MultipartFile item : ansFile) {
				if (StringUtils.isAllBlank(item.getOriginalFilename())) {
					continue;
				}
				AnswerFileVO answerFileVO = new AnswerFileVO(item);
				answerFileList.add(answerFileVO);
			}
			this.answerFileList = answerFileList;
		}
	}

}
