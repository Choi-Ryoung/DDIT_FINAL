package kr.or.ddit.member.answer.vo;

import lombok.Data;

@Data
public class AnswerCommentVO {
	private int ansCmtnNo;  // x
	private String ansCmtnWrtrId; // x
	private int ansNo; // hidden
	private String ansCmtnCn; // o
	private String ansCmtnWrtDt; // x 
}
