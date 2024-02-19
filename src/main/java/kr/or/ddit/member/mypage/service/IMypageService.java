package kr.or.ddit.member.mypage.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.PreferenceVO;
import kr.or.ddit.member.mypage.vo.ProjectCareerVO;
import kr.or.ddit.member.mypage.vo.ResumeVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;


public interface IMypageService {
	public int insRes(ResumeVO rVo);
	
	public int insC(CareerVO cVo);
	public int insAcbg(AcademicBackgroundVO acbgVo);
	public int insPc(ProjectCareerVO pcVo);
	public int insSat(StudyAndTrainningVO satVo);
	public int insCrt(CertificateVO crtVo);
	public int insP(PreferenceVO pVo);
	public int insSI(SelfIntroductionVO sIVo);
	
//	public int insC(List<Object> cList);
//	public int insAcbg(List<Object> acbgList);
//	public int insPc(List<Object> pcList);
//	public int insSat(List<Object> satList);
//	public int insCrt(List<Object> crtList);
	
	
	int profileUpdate(PrivateMemberVO memberVO);

	PrivateMemberVO getMemberInfo(String memId);

	public ResumeVO selResOne(Map<String,String> pMap);
	public List<ResumeVO> selResList(String prMbrId);
	
	public List<CareerVO> selCOne(Map<String,String> pMap);
	public List<AcademicBackgroundVO> selAcbgOne(Map<String,String> pMap);
	public List<ProjectCareerVO> selPcOne(Map<String,String> pMap);
	public List<StudyAndTrainningVO> selSatOne(Map<String,String> pMap);
	public List<CertificateVO> selCrtOne(Map<String,String> pMap);
	public List<PreferenceVO> selPOne(Map<String,String> pMap);
	public List<SelfIntroductionVO> selSIOne(Map<String,String> pMap);

	public int updRes(ResumeVO rVo);
	
	public int updC(CareerVO cVo);
	public int updAcbg(AcademicBackgroundVO acbgVo);
	public int updPc(ProjectCareerVO pcVo);
	public int updSat(StudyAndTrainningVO satVo);
	public int updCrt(CertificateVO crtVo);
	public int updP(PreferenceVO pVo);
	public int updSI(SelfIntroductionVO pVo);
	
	public int delC(Map<String, String> pMap);
	public int delAcbg(Map<String, String> pMap);
	public int delPc(Map<String, String> pMap);
	public int delSat(Map<String, String> pMap);
	public int delCrt(Map<String, String> pMap);
	public int delP(Map<String, String> pMap);
	public int delSI(Map<String, String> pMap);

	public int rprsvAllN(String prMbrId);

	public int delResOne(Map<String, String> pMap);

	public int updRprsvRes(Map<String, String> pMap);

	public int saveResMemo(Map<String, String> pMap);

	public int saveWorkCondition(Map<String, String> pMap);

	public List<ApplyVO> myApplyList(ApplyVO applyVO);

	//멘토링 정보수정
	public MentoringProfileVO getMentoInfo(String menNcnm);
	public int mentoUpdate(MentoringProfileVO mentoVO);

	public List<ApplyVO> myApplyDetail(ApplyVO applyVO);
	//마이페이지 지원내역조회
	public List<ProposalVO> selectProposalList(PaginationInfoVO<ProposalVO> pagingVO);
	public int countProposal(PaginationInfoVO<ProposalVO> pagingVO);
	public ProposalVO selectPrpsList(int prpslNo);


	
	
}