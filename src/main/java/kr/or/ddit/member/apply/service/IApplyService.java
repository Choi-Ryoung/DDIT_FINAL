package kr.or.ddit.member.apply.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mypage.vo.ResumeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IApplyService {

	public int selectApplyCount(PaginationInfoVO<ApplyVO> pagingVO);

	public List<ApplyVO> selectApplyList(PaginationInfoVO<ApplyVO> pagingVO);

	public int insertApply(ApplyVO applyVO, MultipartHttpServletRequest req);

	public List<ApplyVO> selectApply(int empmnPbancNo);

	public int resumeOpen(ResumeVO resVO, ApplyVO applyVO);

	public int updateResumeOKCheck(ApplyVO applyVO);
	
	public int updateResumeNOCheck(ApplyVO applyVO);

	public List<ApplyVO> selectNewApplyCnt(EnterpriseMemberVO memVO);

	public List<ApplyVO> selectAllList(PaginationInfoVO<ApplyVO> pagingVO);

	public ResumeVO selectResNo(String prMbrId);

	public int getResNo(String prMbrId);

	public List<EntPracticeQuestionVO> getCodingTestList(String entMbrId);

	public EntPracticeQuestionVO getCodingTest(EntPracticeQuestionVO eqVO);

	public void submitCodingTest(EntPracticeQuestionYnVO epqVO);

}
