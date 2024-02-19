package kr.or.ddit.admin.manage.service;

import java.util.List;

import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminCodingTestManageService {

	public int selectCodingTestCount(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	public List<PracticeQuestionVO> selectCodingTestList(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	public PracticeQuestionVO selectCodingTestDetail(int prctQuesNo);

	public int updateCodingTest(PracticeQuestionVO pqVO);

	public int deleteCodingTest(int prctQuesNo);

	public int insertCodingTest(PracticeQuestionVO pqVO);

}
