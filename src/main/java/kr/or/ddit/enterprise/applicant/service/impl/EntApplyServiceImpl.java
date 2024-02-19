package kr.or.ddit.enterprise.applicant.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.applicant.mapper.IEntApplyMapper;
import kr.or.ddit.enterprise.applicant.service.IEntApplyService;
import kr.or.ddit.enterprise.applicant.vo.EvalueQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Service
public class EntApplyServiceImpl implements IEntApplyService {
	
	@Inject
	private IEntApplyMapper entApplyMapper;

	@Override
	public List<Map<String, Object>> selApplyList(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.selApplyList(pMap);
	}

	@Override
	public int setDocPass(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.setDocPass(pMap);
	}

	@Override
	public int setDocChkY(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.setDocChkY(pMap);
	}

	@Override
	public int setCtPass(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.setCtPass(pMap);
	}

	@Override
	public int setIvPass(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.setIvPass(pMap);
	}

	@Override
	public EmploymentAnnouncementVO getEmpmnPbancTtl(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.getEmpmnPbancTtl(pMap);
	}

	@Override
	public PrivateMemberVO getMemberTelNo(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.getMemberTelNo(pMap);
	}

	@Override
	public List<Map<String,String>> getEvalueQuestion() {
		// TODO Auto-generated method stub
		return entApplyMapper.getEvalueQuestion();
	}

	@Override
	public List<EntPracticeQuestionYnVO> getCtResult(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.getCtResult(pMap);
	}

	@Override
	public List<EntPracticeQuestionVO> getCtQuestionInfo(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.getCtQuestionInfo(pMap);
	}

	@Override
	public int disQualifyCt(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return entApplyMapper.disQualifyCt(pMap);
	}


}
