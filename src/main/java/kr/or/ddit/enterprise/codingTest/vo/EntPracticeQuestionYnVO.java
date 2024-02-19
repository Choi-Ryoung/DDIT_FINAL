package kr.or.ddit.enterprise.codingTest.vo;

import lombok.Data;

@Data
public class EntPracticeQuestionYnVO {
	private String prMbrId;
	private int entPqNo;
	private String entPqSolutYmd;
	private String entPqAns;
	private int empmnPbancNo;
	
	private int rnum;
	private String entPqTtl;
	private String entPqCn;
	private String entLmtMttr;
	private String ex;
	private String ans;
}
