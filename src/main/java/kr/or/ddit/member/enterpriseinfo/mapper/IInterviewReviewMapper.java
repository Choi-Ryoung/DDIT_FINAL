package kr.or.ddit.member.enterpriseinfo.mapper;

import java.util.List;

import kr.or.ddit.member.enterpriseinfo.vo.InterviewReviewVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface IInterviewReviewMapper {

	public List<InterviewReviewVO> list();

	public int listCnt(PaginationInfoVO<InterviewReviewVO> pagingV);

	public int insert(InterviewReviewVO irVo);

	public PrivateMemberVO selPmConPrMbrId(String prMbrId);

	public List<InterviewReviewVO> selIrList();

}
