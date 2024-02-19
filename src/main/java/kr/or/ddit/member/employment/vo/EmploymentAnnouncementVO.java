package kr.or.ddit.member.employment.vo;




import lombok.Data;

@Data
public class EmploymentAnnouncementVO {
	private int empmnPbancNo;
	private String entMbrId;
	private String empmnPbancTtl;
	private String empmnPbancWrtrNm;
	private String empmnPbancCn;
	private String empmnPbancWrtYmd;
	private String empmnPbancDdlnYmd;
	private int empmnPbancInqCnt;
	private String careerCd;
	private String acbgCd;
	private String powkNm;
	private String salary;
	private String workType;
	private String workHr;
	private String rgnCd;
	private String rgn;
	private String sigungu;
	private String dutyCd;
	private String genderCd;
	private String docPassYmd;
	private String codingPassYmd;
	private String interviewPassYmd;
	
	// enterprisemember
	private String entPicTelno;
	private String logoImg;
	private int rnum;
}
