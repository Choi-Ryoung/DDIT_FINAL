package kr.or.ddit.member.mentoring.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.mentoring.controller.utils.FileUploadUtils;
import kr.or.ddit.member.mentoring.mapper.MentoMapper;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringFileVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;
import kr.or.ddit.member.mentoring.vo.MentoringTagVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MentoServiceImpl implements MentoService {

	@Inject
	private MentoMapper mentoMapper;
	
	@Override
	public int selectMentoCount(PaginationInfoVO<MentoringProfileVO> pagingVO) {
		return mentoMapper.selectMentoCount(pagingVO);
	}

	@Override
	public List<MentoringProfileVO> selectMentoList(PaginationInfoVO<MentoringProfileVO> pagingVO) {
		return mentoMapper.selectMentoList(pagingVO);
	}

	@Override
	public MentoringProfileVO selectMento(String menNcnm) {
		return mentoMapper.selectMento(menNcnm);
	}

	@Override
	public ServiceResult insertMento(HttpServletRequest req, MentoringProfileVO mentoVO) throws Exception {
		ServiceResult result = null;
		int status = mentoMapper.insertMento(mentoVO);
		if(status > 0) {
			List<MentoringFileVO> mentoFileList = mentoVO.getMenFileList();
			FileUploadUtils.mentoFileUpload(mentoFileList, mentoVO.getMenNcnm(), req, mentoMapper);
			
			if(!mentoVO.getTag().equals("")) {
				String[] tags = mentoVO.getTag().split(" ");
				for(int i = 0; i < tags.length; i++) {
					MentoringTagVO tagVO = new MentoringTagVO();
					tagVO.setMenNcnm(mentoVO.getMenNcnm());
					tagVO.setMenTag(tags[i]);
					mentoMapper.insertTag(tagVO);
					System.out.println("tagVO : " + tagVO);
					log.info("tagVO : " + tagVO);
				}
			}
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult idCheck(String menNcnm) {
		ServiceResult result = null;
		MentoringProfileVO mentoVO = mentoMapper.idCheck(menNcnm);
		if(mentoVO != null) {
			result = ServiceResult.EXIST;
		} else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

	@Override
	public ServiceResult updateMento(HttpServletRequest req, MentoringProfileVO mentoVO) throws Exception {
		ServiceResult result = null;
		int status = mentoMapper.updateMento(mentoVO);
		if(status > 0) {		// 수정 성공
			List<MentoringFileVO> mentoFileList = mentoVO.getMenFileList();
			// 파일 업로드 진행
			FileUploadUtils.mentoFileUpload(mentoFileList, mentoVO.getMenNcnm(), req, mentoMapper);
			if(mentoVO.getTag() != null || !mentoVO.getTag().equals("")) {
				mentoMapper.deleteTag(mentoVO.getMenNcnm());
				String[] tags = mentoVO.getTag().split(" ");
				for(int i = 0; i < tags.length; i++) {
					MentoringTagVO tagVO = new MentoringTagVO();
					tagVO.setMenNcnm(mentoVO.getMenNcnm());
					tagVO.setMenTag(tags[i]);
					mentoMapper.insertTag(tagVO);
					System.out.println("tagVO 수정 : " + tagVO);
					log.info("tagVO 수정 : " + tagVO);
				}
			}
			
			String[] delmenNcnm = mentoVO.getDelmenNcnm();
			if(delmenNcnm != null) {
				// 넘겨받은 배열 형태의 menNcnm 집합 데이터를 삭제 처리하기 위해 전달
				mentoMapper.deleteMentoFileList(delmenNcnm);	// 닉네임에 해당하는 파일 데이터 삭제
			}
			result = ServiceResult.OK;
		} else {				// 수정 실패
			result = ServiceResult.FAILED;
		}
		return result;
		
		
	}

	@Override
	public ServiceResult deleteMento(String menNcnm) {
		ServiceResult result = null;
		mentoMapper.deleteMentoFile(menNcnm);
		mentoMapper.deleteTag(menNcnm);
		
		int status = mentoMapper.deleteMento(menNcnm);
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
		
	}

	

	@Override
	public MentiVO selMt(Map<String, String> map) {
		return mentoMapper.selMt(map);
	}
	
	@Override
	public List<MentoringReviewVO> selectReviewList(String menNcnm) {
		return mentoMapper.selectReviewList(menNcnm);
	}

	@Override
	public MentiVO selectMenti(Map<String, Object> map) {
		return mentoMapper.selectMenti(map);
	}
	 

	

}
