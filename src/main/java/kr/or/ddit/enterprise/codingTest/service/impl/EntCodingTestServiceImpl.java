package kr.or.ddit.enterprise.codingTest.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.codingTest.mapper.IEntCodingTestMapper;
import kr.or.ddit.enterprise.codingTest.service.IEntCodingTestService;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class EntCodingTestServiceImpl implements IEntCodingTestService {

	@Inject
	private IEntCodingTestMapper entCodingTestMapper;
	
	@Override
	public int selectEntCodingTestCount(PaginationInfoVO<EntPracticeQuestionVO> pagingVO) {
		return entCodingTestMapper.selectEntCodingTestCount(pagingVO);
	}

	@Override
	public List<EntPracticeQuestionVO> selectEntCodingTestList(PaginationInfoVO<EntPracticeQuestionVO> pagingVO) {
		return entCodingTestMapper.selectEntCodingTestList(pagingVO);
	}

	@Override
	public void registerEntCodingTest(EntPracticeQuestionVO epqVO) {
		entCodingTestMapper.registerEntCodingTest(epqVO);
	}

	@Override
	public EntPracticeQuestionVO selectEntCodingTestDetail(int entPqNo) {
		return entCodingTestMapper.selectEntCodingTestDetail(entPqNo);
	}

	@Override
	public void updateEntCodingTest(EntPracticeQuestionVO epqVO) {
		entCodingTestMapper.updateEntCodingTest(epqVO);
	}

	@Override
	public void deleteEntCodingTest(int entPqNo) {
		entCodingTestMapper.deleteEntCodingTest(entPqNo);
	}

}
