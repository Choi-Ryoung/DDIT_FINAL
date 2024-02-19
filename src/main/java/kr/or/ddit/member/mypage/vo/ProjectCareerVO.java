package kr.or.ddit.member.mypage.vo;

import lombok.Data;

@Data
public class ProjectCareerVO {
	private int    pjCareerNo;
	private int resNo;
	private String ordererNm;
	private String pjNm;
	private String orderBgngYmd;
	private String orderEndYmd;
	private String mainTask;
}
