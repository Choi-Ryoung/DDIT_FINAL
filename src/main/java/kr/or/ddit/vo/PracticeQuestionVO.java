package kr.or.ddit.vo;

import lombok.Data;

@Data
public class PracticeQuestionVO {
	private int prctQuesNo;
	private int adminNo;
	private String prctQuesTtl;
	private String prctQuesCn;
	private String prctQuesDfflyCd;
	private String lmtMttr;
	private String ans;
	private String ex;
}
