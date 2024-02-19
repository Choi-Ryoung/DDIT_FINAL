package kr.or.ddit.admin.manage.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.manage.mapper.IAdminCodingTestManageMapper;
import kr.or.ddit.admin.manage.service.IAdminCodingTestManageService;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class AdminCodingTestManageServiceImpl implements IAdminCodingTestManageService {

	@Inject
	private IAdminCodingTestManageMapper adminCodingTestManageMapper;
	
	@Override
	public int selectCodingTestCount(PaginationInfoVO<PracticeQuestionVO> pagingVO) {
		return adminCodingTestManageMapper.selectCodingTestCount(pagingVO);
	}

	@Override
	public List<PracticeQuestionVO> selectCodingTestList(PaginationInfoVO<PracticeQuestionVO> pagingVO) {
		return adminCodingTestManageMapper.selectCodingTestList(pagingVO);
	}

	@Override
	public PracticeQuestionVO selectCodingTestDetail(int prctQuesNo) {
		return adminCodingTestManageMapper.selectCodingTestDetail(prctQuesNo);
	}

	@Override
	public int updateCodingTest(PracticeQuestionVO pqVO) {
		return adminCodingTestManageMapper.updateCodingTest(pqVO);
	}

	@Override
	public int deleteCodingTest(int prctQuesNo) {
		adminCodingTestManageMapper.deleteCodingTestSolutYn(prctQuesNo);
		return adminCodingTestManageMapper.deleteCodingTest(prctQuesNo);
	}

	@Override
	public int insertCodingTest(PracticeQuestionVO pqVO) {
		return adminCodingTestManageMapper.insertCodingTest(pqVO);
	}

}
