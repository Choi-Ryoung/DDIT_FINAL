package kr.or.ddit.member.community.vo;

import lombok.Data;

@Data
public class CommunityCommentVO {
	private int comntCmtnNo;  // x
	private String comntCmtnWrtrId; // x
	private int comntPstNo; // hidden
	private String comntCmtnCn; // o
	private String comntCmtnWrtDt; // x 
}
