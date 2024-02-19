package kr.or.ddit.member.employment.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.mapper.IBriefingMapper;
import kr.or.ddit.member.employment.service.IBriefingService;
import kr.or.ddit.member.employment.vo.EmploymentBriefingVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class BriefingServiceImpl implements IBriefingService {

	@Inject
	private IBriefingMapper briefingMapper;
	
	
	@Override
	public int selectBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO) {
		return briefingMapper.selectBriefingCount(pagingVO);
	}

	@Override
	public List<EmploymentBriefingVO> selectBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO) {
		return briefingMapper.selectBriefingList(pagingVO);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	// 기업회원
	
	@Override
	public int selectEntBriefingCount(PaginationInfoVO<EmploymentBriefingVO> pagingVO) {
		return briefingMapper.selectEntBriefingCount(pagingVO);
	}

	@Override
	public List<EmploymentBriefingVO> selectEntBriefingList(PaginationInfoVO<EmploymentBriefingVO> pagingVO) {
		return briefingMapper.selectEntBriefingList(pagingVO);
	}

	@Override
	public ServiceResult deleteBriefing(HttpServletRequest req, int empmnBrfNo) {
		ServiceResult result = null;
		

		int status = briefingMapper.deleteBriefing(empmnBrfNo);	
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int insertBriefing(EmploymentBriefingVO briefingVO) {
		return briefingMapper.insertBriefing(briefingVO);
	}

	@Override
	public EmploymentBriefingVO selectBriefing(int empmnBrfNo) {
		return briefingMapper.selectBriefing(empmnBrfNo);
	}

	@Override
	public ServiceResult updateBriefing(EmploymentBriefingVO briefingVO) {
		ServiceResult result = null;
		
		int status = briefingMapper.updateBriefing(briefingVO);	// 게시글 수정	
		
		if(status > 0) {	// 게시글 수정 완료
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
}
