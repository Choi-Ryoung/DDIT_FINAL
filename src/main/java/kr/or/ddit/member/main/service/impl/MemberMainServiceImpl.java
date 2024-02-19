package kr.or.ddit.member.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.main.mapper.IMemberMainMapper;
import kr.or.ddit.member.main.service.IMemberMainService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.FaqVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.QuestionVO;

@Service
public class MemberMainServiceImpl implements IMemberMainService {

	@Inject
	private IMemberMainMapper memberMainMapper;
	
	@Override
	public List<EmploymentAnnouncementVO> selectEmpList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO) {
		return memberMainMapper.selectEmpList(pagingVO);
	}

	@Override
	public List<NoticeVO> selectTwoNotice() {
		return memberMainMapper.selectTwoNotice();
	}

	@Override
	public List<QuestionVO> selectTwoQuestion() {
		return memberMainMapper.selectTwoQuestion();
	}

	@Override
	public List<FaqVO> selectTwoFaq() {
		return memberMainMapper.selectTwoFaq();
	}

	@Override
	public List<CommunityVO> selectTwoCommunity() {
		return memberMainMapper.selectTwoCommunity();
	}

	@Override
	public int resumeChk(Map<String,String> pMap) {
		// TODO Auto-generated method stub
		return memberMainMapper.resumeChk(pMap);
	}

}
