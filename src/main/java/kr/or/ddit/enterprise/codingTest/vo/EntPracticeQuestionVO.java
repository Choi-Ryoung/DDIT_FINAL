package kr.or.ddit.enterprise.codingTest.vo;

import lombok.Data;

@Data
public class EntPracticeQuestionVO {
	private int entPqNo;
	private String entPqTtl;
	private String entPqCn;
	private String entLmtMttr;
	private String ex;
	private String ans;
	private String entMbrId;
	
	private int rnum;
	private String prMbrId;
	private String entPqSolutYmd;
	private String entPqAns;
	private int empmnPbancNo;
}
