package kr.or.ddit.member.enterpriseinfo.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class InterviewReviewVO {
	
	private long ivPstNo;
	private String prMbrId;
	private String entNm;
	private String applyTaskCd;
	private String applyCareerCd;
	private Date ivWrtDt;
	private String ivDfflyCd;
	private String ivWrtrNm;
	private String ivTypeCd;
	private String ivQues;
	private String ivPstSft;
	private String sexdstnCd;
	private String passYn;
	private String serveYn;
	private String pstgYn;
	private String ivCareerCd;
	private String ivEvalueCd;
	private String ivPcntCd;
	private String ivTypeCn;
	
}
