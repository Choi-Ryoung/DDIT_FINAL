package kr.or.ddit.member.codingtest.vo;

import lombok.Data;

@Data
public class PracticeQuestionSolutionYnVO {
	private String prMbrId;
	private int prctQuesNo;
	private String solutYn;
	private String solutYmd;
	private String prctQuesAns;
}
