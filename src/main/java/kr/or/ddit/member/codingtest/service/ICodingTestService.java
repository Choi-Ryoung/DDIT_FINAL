package kr.or.ddit.member.codingtest.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionSolutionYnVO;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ICodingTestService {
	
	// 목록 갯수
	public int selectCodingTestCount(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	// 목록 가져오기
	public List<PracticeQuestionVO> selectCodingTestList(PaginationInfoVO<PracticeQuestionVO> pagingVO);

	// 상세보기
	public PracticeQuestionVO selectCodingTest(int prctQuesNo);
	public int updateSolutionYn(PracticeQuestionSolutionYnVO pqsyn);
	public int insertSolutionYn(PracticeQuestionSolutionYnVO pqsyn);
	public ServiceResult problemIsSolve(PracticeQuestionSolutionYnVO pqsyn);
	
	// 푼 문제 목록
	public List<PracticeQuestionVO> selectMyCodingTest(PaginationInfoVO<PracticeQuestionVO> pagingVO);
	
	// 내 풀이 상세보기
	public PracticeQuestionVO myCodingTestDetail(PracticeQuestionVO pqVO);
}
