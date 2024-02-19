package kr.or.ddit.member.freelancer.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ProjectBoardVO {
	private int pjtPstNo;
	private String entMbrId;
	private String pjtNm;
	private String estPrd;
	private String estSalary;
	private String workWay;
	private String careerCd;
	private String pjtBgngEstYmd;
	private Date pstWrtDt;
	private Date pstEndDt;
	private String dutyCd;
	private String pstCn;
	private String picTelno;
	private String pstgYn;
}
