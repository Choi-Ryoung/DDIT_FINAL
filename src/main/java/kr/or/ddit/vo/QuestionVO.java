package kr.or.ddit.vo;

import lombok.Data;

@Data
public class QuestionVO {
	private int qstnNo;
	private String qstnTtl;
	private String qstnWrtr;
	private String qstnCn;
	private String qstnWrtDt;
	private int qstnInqCnt;
}
