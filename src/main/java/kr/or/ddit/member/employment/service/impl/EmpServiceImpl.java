package kr.or.ddit.member.employment.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.mapper.IEmpMapper;
import kr.or.ddit.member.employment.service.IEmpService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.PaginationInfoVO;


@Service
public class EmpServiceImpl implements IEmpService {

	@Inject
	private IEmpMapper empMapper;
	
	@Override
	public int selectEmpCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO) {
		return empMapper.selectEmpCount(pagingVO);
	}

	@Override
	public List<EmploymentAnnouncementVO> selectEmpList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO) {
		return empMapper.selectEmpList(pagingVO);
	}


	
	
	
	
	
	
	

	// 기업회원
	@Override
	public int selectAnnouncementCount(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO) {
		return empMapper.selectAnnouncementCount(pagingVO);
	}
	
	
	
	// 채용공고등록
	@Override
	public int insertAnnouncement(EmploymentAnnouncementVO empVO) {
		 return empMapper.insertAnnouncement(empVO);
	}

	// 채용공고 리스트
	@Override
	public List<EmploymentAnnouncementVO> selectAnnouncementList(PaginationInfoVO<EmploymentAnnouncementVO> pagingVO) {
		return empMapper.selectAnnouncementList(pagingVO);
	}

	// 채용공고 상세보기
	@Override
	public EmploymentAnnouncementVO selectEmployment(int empmnPbancNo) {
		empMapper.incrementHit(empmnPbancNo);					// 채용공고 조회수 증가
		return empMapper.selectEmployment(empmnPbancNo); 		// 채용공고 번호에 해당하는 채용공고 정보 가져오기
	}
	
	// 채용공고 삭제
	@Override
	public ServiceResult deleteAnnouncement(HttpServletRequest req, int empmnPbancNo) {
		ServiceResult result = null;

		int status = empMapper.deleteAnnouncement(empmnPbancNo);	// 일반적인 게시글 삭제
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult updateAnnouncement(HttpServletRequest req, EmploymentAnnouncementVO empVO) {
		ServiceResult result = null;
		
		int status = empMapper.updateAnnouncement(empVO);	// 게시글 수정	
		
		if(status > 0) {	// 게시글 수정 완료
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int getApplicantCnt(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return empMapper.getApplicantCnt(pMap);
	}

	@Override
	public int getApplicantAllPassCnt(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return empMapper.getApplicantAllPassCnt(pMap);
	}


	
	

}
