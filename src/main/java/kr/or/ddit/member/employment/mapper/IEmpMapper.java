package kr.or.ddit.member.employment.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEmpMapper {
	public int selectEmpCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public List<EmploymentAnnouncementVO> selectEmpList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public void incrementHit(int empmnPbancNo);

	
	// 기업회원
	public int insertAnnouncement(EmploymentAnnouncementVO empVO);
	public List<EmploymentAnnouncementVO> selectAnnouncementList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	
	public EmploymentAnnouncementVO selectEmployment(int empmnPbancNo);
	public int deleteAnnouncement(int empmnPbancNo);
	public int updateAnnouncement(EmploymentAnnouncementVO empVO);
	public int selectAnnouncementCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public int getApplicantCnt(Map<String, String> pMap);
	public int getApplicantAllPassCnt(Map<String, String> pMap);

}
