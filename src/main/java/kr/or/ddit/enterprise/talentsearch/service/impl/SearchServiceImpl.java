package kr.or.ddit.enterprise.talentsearch.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.talentsearch.mapper.SearchMapper;
import kr.or.ddit.enterprise.talentsearch.service.SearchService;
import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.enterprise.talentsearch.vo.ResumeVO;
import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class SearchServiceImpl implements SearchService {

	@Inject
	private SearchMapper searchMapper;
	
	@Override
	public int countResume(PaginationInfoVO<ResumeVO> pagingVO) {
		return searchMapper.countResume(pagingVO);
	}

	@Override
	public List<ResumeVO> selectResumeList(PaginationInfoVO<ResumeVO> pagingVO) {
		return searchMapper.selectResumeList(pagingVO);
	}

	@Override
	public ResumeVO selectResume(int resNo) {
		return searchMapper.selectResume(resNo);
	}

	@Override
	public int insertPrpsl(ProposalVO prps) {
		return searchMapper.insertPrpsl(prps);
	}



}
