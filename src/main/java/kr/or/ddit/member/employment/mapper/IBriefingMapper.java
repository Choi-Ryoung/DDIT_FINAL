package kr.or.ddit.member.employment.mapper;

import java.util.List;

import kr.or.ddit.member.employment.vo.EmploymentBriefingVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IBriefingMapper {

	public int selectBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public List<EmploymentBriefingVO> selectBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO);

	
	
	
	
	public int selectEntBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public List<EmploymentBriefingVO> selectEntBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO);
	public int deleteBriefing(int empmnBrfNo);
	public int insertBriefing(EmploymentBriefingVO briefingVO);
	public EmploymentBriefingVO selectBriefing(int empmnBrfNo);
	public int updateBriefing(EmploymentBriefingVO briefingVO);

}
