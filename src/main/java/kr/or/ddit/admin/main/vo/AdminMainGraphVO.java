package kr.or.ddit.admin.main.vo;

import java.util.List;

import kr.or.ddit.vo.AuthVO;
import lombok.Data;

@Data
public class AdminMainGraphVO {
	private String entMbrId;
	private String brno;
	private String entMbrPswd;
	private String entNm;
	private String entSe;
	private String entMbrEmail;
	private String entRprsTelno;
	private String entPicTelno;
	private String entAprvYn;
	private String entZip;
	private String entBscAddr;
	private String entDaddr;
	private int empCnt;
	private String rprsvNm;
	private String scdPswdUseYn;
	private String scdPswd;
	private String entMbrWhdwlYmd;
	private int useStopCnt;
	private String useStopEndYmd;
	private String logoImg;
	private String trmsAgreCd;
	private String hmpgAddr;
	private String bizCn;
	private String intrcnCn;
	private List<AuthVO> authList;
	private String enabled;
	private String entJoinYmd;
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
	private String prMbrWhdwlYmd;
	private String prMbrActno;
	private String bankCd;
	
	private String count;
}
