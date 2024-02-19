package kr.or.ddit.member.employment.vo;

import lombok.Data;

@Data
public class EmploymentBriefingVO {
	private String empmnBrfNo;
	private String entMbrId;
	private String empmnBrfTtl;
	private String empmnBrfBgngYmd;
	private String empmnBrfHr;
	private String empmnBrfPlcNm;
	private String empmnBrfUrl;
	private String empmnBrfType;
	
	// enterprisemember
	private String entNm;
}
