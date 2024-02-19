package kr.or.ddit.member.apply.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.apply.mapper.IApplyMapper;
import kr.or.ddit.member.apply.service.IApplyService;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mypage.vo.ResumeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class ApplyServiceImpl implements IApplyService {

	@Inject
	private IApplyMapper applyMapper;
	
	@Override
	public int selectApplyCount(PaginationInfoVO<ApplyVO> pagingVO) {
		return applyMapper.selectApplyCount(pagingVO);
	}

	@Override
	public List<ApplyVO> selectApplyList(PaginationInfoVO<ApplyVO> pagingVO) {
		return applyMapper.selectApplyList(pagingVO);
	}

	
	
	
	@Override
	public int insertApply(ApplyVO applyVO, MultipartHttpServletRequest req) {
		try {
			applyFileUpload(applyVO, req);
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return applyMapper.insertApply(applyVO);
	}

	public void applyFileUpload(ApplyVO applyVO, MultipartHttpServletRequest req) throws IllegalStateException, IOException {
		String savePath = "/resources/profile";
		
		MultipartFile multipartFile = req.getFile("resumeFiles");
		
		
		if(multipartFile != null) {	// 넘겨받은 파일 데이터가 존재할 때
	
			String saveName = UUID.randomUUID().toString();	// UUID의 랜덤 파일명 생성

			saveName = saveName + "." + multipartFile.getOriginalFilename().split("\\.")[1];
			
			String saveLocate = req.getServletContext().getRealPath(savePath);
			File file = new File(saveLocate);
			if(!file.exists()) {
				file.mkdirs();
			}
			saveLocate += "/" + saveName;
			
			File saveFile = new File(saveLocate);
			// 방법 1
//					InputStream is = noticeFileVO.getItem().getInputStream();
//					FileUtils.copyInputStreamToFile(is, saveFile);
			
			// 방법 2
			multipartFile.transferTo(saveFile);	// 파일 복사
			applyVO.setResumeFile(savePath + "/" + saveName);
		}
	}
	
	
	
	@Override
	public List<ApplyVO> selectApply(int empmnPbancNo) {
		return applyMapper.selectApply(empmnPbancNo);
	}

	@Override
	public int resumeOpen(ResumeVO resVO, ApplyVO applyVO) {
//		applyMapper.deleteN(applyVO);
//		return applyMapper.resumeOpen(resVO);
		return applyMapper.updateDocChkYn(applyVO);
	}


	@Override
	public int updateResumeOKCheck(ApplyVO applyVO) {
		return applyMapper.updateResumeOKCheck(applyVO);
	}

	@Override
	public int updateResumeNOCheck(ApplyVO applyVO) {
		return applyMapper.updateResumeNOCheck(applyVO);
	}
	
	@Override
	public List<ApplyVO> selectNewApplyCnt(EnterpriseMemberVO memVO) {
		return applyMapper.selectNewApplyCnt(memVO);
	}

	@Override
	public List<ApplyVO> selectAllList(PaginationInfoVO<ApplyVO> pagingVO) {
		return applyMapper.selectAllList(pagingVO);
	}

	@Override
	public ResumeVO selectResNo(String prMbrId) {
		return applyMapper.selectResNo(prMbrId);
	}

	@Override
	public int getResNo(String prMbrId) {
		return applyMapper.getResNo(prMbrId);
	}

	@Override
	public List<EntPracticeQuestionVO> getCodingTestList(String entMbrId) {
		return applyMapper.getCodingTestList(entMbrId);
	}

	@Override
	public EntPracticeQuestionVO getCodingTest(EntPracticeQuestionVO eqVO) {
		return applyMapper.getCodingTest(eqVO);
	}

	@Override
	public void submitCodingTest(EntPracticeQuestionYnVO epqVO) {
		applyMapper.submitCodingTest(epqVO);
	}

	


}
