package kr.or.ddit.member.mypage.vo;

import java.util.List;

import lombok.Data;

@Data
public class RecordVO {
	private String provPhoto;
	private String rprsvResYn;
	private String resTtl;
	private String resNo;
	private String careerCd;
	private String dutyCd;
	private String resMemo;
	private List<CareerVO> careerList;
    private List<AcademicBackgroundVO> acdbgList;
    private List<ProjectCareerVO> pjCareerList;
    private List<PreferenceVO> prefList;
    private List<CertificateVO> certifList;
    private List<StudyAndTrainningVO> stdatList;
    private List<SelfIntroductionVO> selfintList;
}
