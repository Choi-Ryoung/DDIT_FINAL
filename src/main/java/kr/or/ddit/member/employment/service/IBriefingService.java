package kr.or.ddit.member.employment.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.vo.EmploymentBriefingVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IBriefingService {

	public int selectBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public List<EmploymentBriefingVO> selectBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO);

	
	
	
	public int selectEntBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public List<EmploymentBriefingVO> selectEntBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public ServiceResult deleteBriefing(HttpServletRequest req, int empmnBrfNo);
	public int insertBriefing(EmploymentBriefingVO briefingVO);
	public EmploymentBriefingVO selectBriefing(int empmnBrfNo);
	public ServiceResult updateBriefing(EmploymentBriefingVO briefingVO);


}
