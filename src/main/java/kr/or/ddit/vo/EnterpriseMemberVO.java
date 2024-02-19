package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EnterpriseMemberVO {
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
	private String trmsAgreCd;
	private String hmpgAddr;
	private String bizCn;
	private String intrcnCn;
	private List<AuthVO> authList;
	private String enabled;
	private String entJoinYmd;
	private String logoImg;
	
	
	//기업로고 등록
	private MultipartFile entFile;

}
