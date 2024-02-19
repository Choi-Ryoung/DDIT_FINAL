package kr.or.ddit.enterprise.talentsearch.vo;



import java.util.List;

import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.PreferenceVO;
import kr.or.ddit.member.mypage.vo.ProjectCareerVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
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
	private String[] careerYearCdList;
	private String salaryCd;
	private String[] salaryCdList;
	private String workCd;
	private String[] workCdList;
	private String dutyCd;
	private String[] dutyCdList;
	
	private List<CareerVO> careerList;				// 경력
	private List<AcademicBackgroundVO> abgList;		// 학력
	private List<CertificateVO> certificateList;	// 자격증
	private List<StudyAndTrainningVO> studyList;	// 연수
	private List<SelfIntroductionVO> selfList;		// 자기소개서
	private List<ProjectCareerVO> procarList;		// 프로젝트 경력
	private List<PreferenceVO> preList;				// 취업우대 사항
	

}
