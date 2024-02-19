package kr.or.ddit.vo;

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
}
