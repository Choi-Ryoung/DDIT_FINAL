package kr.or.ddit.member.main.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.FaqVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.QuestionVO;

public interface IMemberMainMapper {

	public List<EmploymentAnnouncementVO> selectEmpList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);

	public List<NoticeVO> selectTwoNotice();

	public List<QuestionVO> selectTwoQuestion();

	public List<FaqVO> selectTwoFaq();

	public List<CommunityVO> selectTwoCommunity();

	public int resumeChk(Map<String, String> pMap);

}
