package kr.or.ddit.member.codingtest.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.codingtest.mapper.ICodingTestMapper;
import kr.or.ddit.member.codingtest.service.ICodingTestService;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionSolutionYnVO;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class CodingTestServiceImpl implements ICodingTestService {

	@Inject
	private ICodingTestMapper codingTestMapper;
	
	@Override
	public int selectCodingTestCount(PaginationInfoVO<PracticeQuestionVO> pagingVO) {
		return codingTestMapper.selectCodingTestCount(pagingVO);
	}

	@Override
	public List<PracticeQuestionVO> selectCodingTestList(PaginationInfoVO<PracticeQuestionVO> pagingVO) {
		return codingTestMapper.selectCodingTestList(pagingVO);
	}

	@Override
	public PracticeQuestionVO selectCodingTest(int prctQuesNo) {
		return codingTestMapper.selectCodingTest(prctQuesNo);
	}

	@Override
	public int updateSolutionYn(PracticeQuestionSolutionYnVO pqsyn) {
		return codingTestMapper.updateSolutionYn(pqsyn);
	}

	@Override
	public ServiceResult problemIsSolve(PracticeQuestionSolutionYnVO pqsyn) {
		ServiceResult result = null;
		PracticeQuestionSolutionYnVO pqsyVO = codingTestMapper.problemIsSolve(pqsyn);
		if(pqsyVO != null) {
			result = ServiceResult.SOLVE;
		}else {
			result = ServiceResult.NOTSOLVE;
		}
		return result;
	}

	@Override
	public int insertSolutionYn(PracticeQuestionSolutionYnVO pqsyn) {
		return codingTestMapper.insertSolutionYn(pqsyn);
	}

	@Override
	public List<PracticeQuestionVO> selectMyCodingTest(PaginationInfoVO<PracticeQuestionVO> pagingVO) {
		return codingTestMapper.selectMyCodingTest(pagingVO);
	}

	@Override
	public PracticeQuestionVO myCodingTestDetail(PracticeQuestionVO pqVO) {
		return codingTestMapper.myCodingTestDetail(pqVO);
	}

	
}
