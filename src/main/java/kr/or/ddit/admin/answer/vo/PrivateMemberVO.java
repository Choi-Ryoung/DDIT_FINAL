package kr.or.ddit.admin.answer.vo;

import java.util.List;

import lombok.Data;

@Data
public class PrivateMemberVO {
	private String prMbrId;
	private String prMbrPswd;
	private String prMbrNm;
	private String prMbrNcnm;
	private String prMbrTelno;
	private String prMbrEmail;
	private String sexdstnCd;
	private String prMbrBirthdy;
	private String prMbrZip;
	private String prMbrBscAddr;
	private String prMbrDaddr;
	private String prMbrJoinYmd;
	private String socialLoginMbrYn;
	private String mentoRegYn;
	private String freelancerRegYn;
	private int useStopCnt;
	private String useStopEndYmd;
	private String prMbrWhdwlYmd;
	private String trmsAgreCd;
	private String prMbrActno;
	private String bankCd;
	private List<AuthVO> authList;
	private String enabled;
}
