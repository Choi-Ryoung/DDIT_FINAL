package kr.or.ddit.member.employment.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEmpService {
	public int selectEmpCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public List<EmploymentAnnouncementVO> selectEmpList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	

	
	// 기업회원 채용공고
	public int insertAnnouncement(EmploymentAnnouncementVO empVO);
	public List<EmploymentAnnouncementVO> selectAnnouncementList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public EmploymentAnnouncementVO selectEmployment(int empmnPbancNo);
	public ServiceResult deleteAnnouncement(HttpServletRequest req, int empmnPbancNo);
	public ServiceResult updateAnnouncement(HttpServletRequest req, EmploymentAnnouncementVO empVO);
	public int selectAnnouncementCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO);
	public int getApplicantCnt(Map<String, String> pMap);
	public int getApplicantAllPassCnt(Map<String, String> pMap);
	
}
