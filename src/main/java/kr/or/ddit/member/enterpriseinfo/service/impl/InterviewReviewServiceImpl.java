package kr.or.ddit.member.enterpriseinfo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.enterpriseinfo.mapper.IInterviewReviewMapper;
import kr.or.ddit.member.enterpriseinfo.service.IInterviewReviewService;
import kr.or.ddit.member.enterpriseinfo.vo.InterviewReviewVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Service
public class InterviewReviewServiceImpl implements IInterviewReviewService {

	@Inject
	private IInterviewReviewMapper mapper;
	
	@Override
	public List<InterviewReviewVO> list() {
		return mapper.list();
	}

	@Override
	public int insert(InterviewReviewVO irVo) {
		return mapper.insert(irVo);
	}

	@Override
	public int listCnt(PaginationInfoVO<InterviewReviewVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.listCnt(pagingVO);
	}

	@Override
	public PrivateMemberVO selPmConPrMbrId(String prMbrId) {
		// TODO Auto-generated method stub
		return mapper.selPmConPrMbrId(prMbrId);
	}

	@Override
	public List<InterviewReviewVO> selIrList() {
		// TODO Auto-generated method stub
		return mapper.selIrList();
	}

}
