package kr.or.ddit.enterprise.talentsearch.service;

import java.util.List;

import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.enterprise.talentsearch.vo.ResumeVO;
import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface SearchService {

	public int countResume(PaginationInfoVO<ResumeVO> pagingVO);
	public List<ResumeVO> selectResumeList(PaginationInfoVO<ResumeVO> pagingVO);
	public ResumeVO selectResume(int resNo);
	public int insertPrpsl(ProposalVO prps);

}
