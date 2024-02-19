package kr.or.ddit.member.mypage.vo;



import lombok.Data;

@Data
public class ResumeVO {
	private int resNo;
	private String sexdstnCd;
	private String prMbrId;
	private String resTtl;
	private String prMbrNm;
	private String prMbrTelno;
	private String prMbrEmail;
	private String prMbrBirthdy;
	private String prMbrZip;
	private String prMbrBscAddr;
	private String prMbrDaddr;
	private String rprsvResYn;
	private String trmsAgreCd;
	private String provPhoto;
	private String careerCd;
	private String resMemo;
	
	//희망 근무조건 
	private String careerYearCd;
	private String salaryCd;
	private String workCd;
	private String dutyCd;

}
