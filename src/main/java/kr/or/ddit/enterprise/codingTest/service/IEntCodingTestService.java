package kr.or.ddit.enterprise.codingTest.service;

import java.util.List;

import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEntCodingTestService {

	public int selectEntCodingTestCount(PaginationInfoVO<EntPracticeQuestionVO> pagingVO);

	public List<EntPracticeQuestionVO> selectEntCodingTestList(PaginationInfoVO<EntPracticeQuestionVO> pagingVO);

	public void registerEntCodingTest(EntPracticeQuestionVO epqVO);

	public EntPracticeQuestionVO selectEntCodingTestDetail(int entPqNo);

	public void updateEntCodingTest(EntPracticeQuestionVO epqVO);

	public void deleteEntCodingTest(int entPqNo);

}
