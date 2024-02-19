package kr.or.ddit.member.enterpriseinfo.service;

import java.util.List;

import kr.or.ddit.member.enterpriseinfo.vo.InterviewReviewVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface IInterviewReviewService {
	
	public List<InterviewReviewVO> list();
	public int listCnt(PaginationInfoVO<InterviewReviewVO> pagingVO);
	public int insert(InterviewReviewVO irVo);
	public PrivateMemberVO selPmConPrMbrId(String prMbrId);
	public List<InterviewReviewVO> selIrList();
	
	
	
}
