package kr.or.ddit.member.mypage.mapper;

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
import kr.or.ddit.vo.PrivateMemberVO;
import kr.or.ddit.vo.CommonCodeGroupVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;

public interface IMypageMapper {

	
	public int profileUpdate(PrivateMemberVO memberVO);
	public PrivateMemberVO getMemberInfo(String memId);
	public MentoringProfileVO getMentoInfo(String memberId);
	public int mentoUpdate(MentoringProfileVO mentoVO);
	
	public int insRes(ResumeVO rVo);
	public int insC(CareerVO cVo);
	public int insAcbg(AcademicBackgroundVO acbgVo);
	public int insPc(ProjectCareerVO pcVo);
	public int insSat(StudyAndTrainningVO satVo);
	public int insCrt(CertificateVO crtVo);
	public int insP(PreferenceVO pVo);
	public int insSI(SelfIntroductionVO sIVo);
	
	// 이력서 선택
	public List<ResumeVO> selResList(String prMbrId);
	public ResumeVO selResOne(Map<String, String> pMap);
	public List<ProjectCareerVO> selPc(String prMbrId);

	
	public List<CareerVO> selCOne(Map<String, String> pMap);
	public List<AcademicBackgroundVO> selAcbgOne(Map<String, String> pMap);
	public List<ProjectCareerVO> selPcOne(Map<String, String> pMap);
	public List<StudyAndTrainningVO> selSatOne(Map<String, String> pMap);
	public List<CertificateVO> selCrtOne(Map<String, String> pMap);
	public List<PreferenceVO> selPOne(Map<String, String> pMap);
	public List<SelfIntroductionVO> selSIOne(Map<String, String> pMap);
	
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
	public int delP(Map<String, String> pMap);
	public int delCrt(Map<String, String> pMap);
	public int delSI(Map<String, String> pMap);
	
	
	public int rprsvResCheck(String prMbrId);
	public int rprsvAllN(String prMbrId);
	public int delResOne(Map<String, String> pMap);
	public int updRprsvRes(Map<String, String> pMap);
	public int saveResMemo(Map<String, String> pMap);
	public int saveWorkCondition(Map<String, String> pMap);
	public List<ApplyVO> myApplyList(ApplyVO applyVO);
	public List<ApplyVO> myApplyDetail(ApplyVO applyVO);
	public List<ProposalVO> selectProposalList(PaginationInfoVO<ProposalVO> pagingVO);
	public int countProposal(PaginationInfoVO<ProposalVO> pagingVO);
	public ProposalVO selectPrpsList(int prpslNo);
//	public void deleteMenNcnm(String menNcnm);
//	public void insertMenNcnm(MentoringProfileVO mentoVO);
	
	

}