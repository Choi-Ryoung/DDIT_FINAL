

package kr.or.ddit.member.mypage.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mypage.mapper.IMypageMapper;
import kr.or.ddit.member.mypage.service.IMypageService;
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

@Service
public class MypageServiceImpl implements IMypageService {
	@Inject
	private IMypageMapper mapper;
	
	
	@Override
	
	public int profileUpdate(PrivateMemberVO memberVO) {
	    int status = mapper.profileUpdate(memberVO);
	    
	    return status;
	}

	@Override
	public PrivateMemberVO getMemberInfo(String memId) {
		   // 회원 정보 조회 로직
        PrivateMemberVO member = mapper.getMemberInfo(memId);
        return member;
	}
	
	//멘토링 정보조회
	@Override
	public MentoringProfileVO getMentoInfo(String menNcnm) {
	        return mapper.getMentoInfo(menNcnm);
	}
	@Override
	public int mentoUpdate(MentoringProfileVO mentoVO) {
		int status = mapper.mentoUpdate(mentoVO);
		return status;
	}
	
	
//  트랜 잭션처리 나중에
//	@Override
//	@Transactional(rollbackFor = Exception.class)
//	public int insRecord(ResumeVO rVo) {
//		// TODO Auto-generated method stub
//		return mapper.insRes(rVo);
//	}

	@Override
	public int insRes(ResumeVO rVo) {
		// TODO Auto-generated method stub
		return mapper.insRes(rVo);
	}

	@Override
	public int insC(CareerVO cVo) {
		// TODO Auto-generated method stub
		return mapper.insC(cVo);
	}

	@Override
	public int insAcbg(AcademicBackgroundVO acbgVo) {
		// TODO Auto-generated method stub
		return mapper.insAcbg(acbgVo);
	}

	@Override
	public int insPc(ProjectCareerVO pcVo) {
		// TODO Auto-generated method stub
		return mapper.insPc(pcVo);
	}

	@Override
	public int insSat(StudyAndTrainningVO satVo) {
		// TODO Auto-generated method stub
		return mapper.insSat(satVo);
	}

	@Override
	public int insCrt(CertificateVO crtVo) {
		// TODO Auto-generated method stub
		return mapper.insCrt(crtVo);
	}

	@Override
	public int insP(PreferenceVO pVo) {
		// TODO Auto-generated method stub
		return mapper.insP(pVo);
	}
	
	@Override
	public int insSI(SelfIntroductionVO sIVo) {
		// TODO Auto-generated method stub
		return mapper.insSI(sIVo);
	}
	

	@Override
	public List<CareerVO> selCOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selCOne(pMap);
	}

	@Override
	public List<AcademicBackgroundVO> selAcbgOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selAcbgOne(pMap);
	}

	@Override
	public List<ProjectCareerVO> selPcOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selPcOne(pMap);
	}

	@Override
	public List<StudyAndTrainningVO> selSatOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selSatOne(pMap);
	}

	@Override
	public List<CertificateVO> selCrtOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selCrtOne(pMap);
	}

	@Override
	public List<PreferenceVO> selPOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selPOne(pMap);
	}
	
	@Override
	public List<SelfIntroductionVO> selSIOne(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selSIOne(pMap);
	}


	@Override
	public int updRes(ResumeVO rVo) {
		// TODO Auto-generated method stub
		return mapper.updRes(rVo);
	}

	@Override
	public int updC(CareerVO cVo) {
		// TODO Auto-generated method stub
		return mapper.updC(cVo);
	}

	@Override
	public int updAcbg(AcademicBackgroundVO acbgVo) {
		// TODO Auto-generated method stub
		return mapper.updAcbg(acbgVo);
	}

	@Override
	public int updPc(ProjectCareerVO pcVo) {
		// TODO Auto-generated method stub
		return mapper.updPc(pcVo);
	}

	@Override
	public int updSat(StudyAndTrainningVO satVo) {
		// TODO Auto-generated method stub
		return mapper.updSat(satVo);
	}

	@Override
	public int updCrt(CertificateVO crtVo) {
		// TODO Auto-generated method stub
		return mapper.updCrt(crtVo);
	}

	@Override
	public int updP(PreferenceVO pVo) {
		// TODO Auto-generated method stub
		return mapper.updP(pVo);
	}
	
	@Override
	public int updSI(SelfIntroductionVO pVo) {
		// TODO Auto-generated method stub
		return mapper.updSI(pVo);
	}


	@Override
	public List<ResumeVO> selResList(String prMbrId) {
		// TODO Auto-generated method stub
		return  mapper.selResList(prMbrId);
	}


	@Override
	public ResumeVO selResOne(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selResOne(pMap);
	}

	@Override
	public int delC(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delC(pMap);
	}

	@Override
	public int delAcbg(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delAcbg(pMap);
	}

	@Override
	public int delPc(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delPc(pMap);
	}

	@Override
	public int delSat(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delSat(pMap);
	}

	@Override
	public int delCrt(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delCrt(pMap);
	}

	@Override
	public int delP(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delP(pMap);
	}
	
	@Override
	public int delSI(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delSI(pMap);
	}

	@Override
	public int rprsvAllN(String prMbrId) {
		// TODO Auto-generated method stub
		return mapper.rprsvAllN(prMbrId);
	}

	@Override
	public int delResOne(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.delResOne(pMap);
	}

	@Override
	public int updRprsvRes(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.updRprsvRes(pMap);
	}

	@Override
	public int saveResMemo(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.saveResMemo(pMap);
	}

	@Override
	public int saveWorkCondition(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.saveWorkCondition(pMap);
	}
	@Override
	public List<ApplyVO> myApplyList(ApplyVO applyVO) {
		// TODO Auto-generated method stub
		return mapper.myApplyList(applyVO);
	}

	@Override
	public List<ApplyVO> myApplyDetail(ApplyVO applyVO) {
		return mapper.myApplyDetail(applyVO);
	}
	@Override
	public List<ProposalVO> selectProposalList(PaginationInfoVO<ProposalVO> pagingVO) {
		return mapper.selectProposalList(pagingVO);
	}

	@Override
	public int countProposal(PaginationInfoVO<ProposalVO> pagingVO) {
		return mapper.countProposal(pagingVO);
	}

	@Override
	public ProposalVO selectPrpsList(int prpslNo) {
		return mapper.selectPrpsList(prpslNo);
	}

	
	
}
