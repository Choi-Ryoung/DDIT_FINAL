package kr.or.ddit.enterprise.applicant.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.enterprise.applicant.vo.EvalueQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.PrivateMemberVO;


public interface IEntApplyMapper {

	List<Map<String, Object>> selApplyList(Map<String, Object> pMap);

	int setDocPass(Map<String, String> pMap);

	int setDocChkY(Map<String, String> pMap);

	int setCtPass(Map<String, String> pMap);

	int setIvPass(Map<String, String> pMap);

	EmploymentAnnouncementVO getEmpmnPbancTtl(Map<String, String> pMap);

	PrivateMemberVO getMemberTelNo(Map<String, String> pMap);

	List<Map<String, String>> getEvalueQuestion();

	List<EntPracticeQuestionYnVO> getCtResult(Map<String, String> pMap);

	List<EntPracticeQuestionVO> getCtQuestionInfo(Map<String, String> pMap);

	int disQualifyCt(Map<String, String> pMap);

}
