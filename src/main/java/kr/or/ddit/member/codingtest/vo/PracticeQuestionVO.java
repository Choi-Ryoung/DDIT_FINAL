package kr.or.ddit.member.codingtest.vo;

import lombok.Data;

@Data
public class PracticeQuestionVO {
	private int prctQuesNo;
	private String prMbrId;
	private String prctQuesTtl;
	private String prctQuesCn;
	private String prctQuesDfflyCd;
	private String lmtMttr;
	private String ans;
	private String ex;
	
	private String solutYn;
	private String solutYmd;
	private String prctQuesAns;
}
