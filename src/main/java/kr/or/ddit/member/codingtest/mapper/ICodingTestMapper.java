package kr.or.ddit.member.codingtest.mapper;

import java.util.List;

import kr.or.ddit.member.codingtest.vo.PracticeQuestionSolutionYnVO;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ICodingTestMapper {

	public int selectCodingTestCount(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	public List<PracticeQuestionVO> selectCodingTestList(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	public PracticeQuestionVO selectCodingTest(int prctQuesNo);

	public int updateSolutionYn(PracticeQuestionSolutionYnVO pqsyn);

	public int insertSolutionYn(PracticeQuestionSolutionYnVO pqsyn);

	public PracticeQuestionSolutionYnVO problemIsSolve(PracticeQuestionSolutionYnVO pqsyn);

	public List<PracticeQuestionVO> selectMyCodingTest(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	public PracticeQuestionVO selectMyCodingTest(int prctQuesNo);

	public PracticeQuestionVO myCodingTestDetail(PracticeQuestionVO pqVO);

}
