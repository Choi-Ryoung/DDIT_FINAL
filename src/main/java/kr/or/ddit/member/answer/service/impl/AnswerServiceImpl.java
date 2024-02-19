package kr.or.ddit.member.answer.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.answer.controller.AnswerUploadUtils;
import kr.or.ddit.member.answer.mapper.IAnswerMapper;
import kr.or.ddit.member.answer.service.IAnswerService;
import kr.or.ddit.member.answer.vo.AnswerCommentVO;
import kr.or.ddit.member.answer.vo.AnswerFileVO;
import kr.or.ddit.member.answer.vo.AnswerTagVO;
import kr.or.ddit.member.answer.vo.AnswerVO;
import kr.or.ddit.member.answer.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AnswerServiceImpl implements IAnswerService {
	
	@Inject
	private IAnswerMapper mapper;
	

	@Override
	public int selectAnswerCount(PaginationInfoVO<AnswerVO> pagingVO) {
		return mapper.selectAnswerCount(pagingVO);
	}
	@Override
	public AnswerVO selectAnswer(int ansNo) {
		mapper.incrementHit(ansNo); 	// 게시글 조회수 증가
		return mapper.selectAnswer(ansNo); //게시글 번호에 해당하는 게시글 정보 가져오기
	}

	@Override
	public List<AnswerVO> selectAnswerList(PaginationInfoVO<AnswerVO> pagingVO) {
		return mapper.selectAnswerList(pagingVO);
	}



	/*
	 * @Override public ServiceResult updateAnswer(HttpServletRequest req, AnswerVO
	 * answerVO) { ServiceResult result = null; int status =
	 * mapper.updateAnswer(answerVO); // 게시글 수정 if (status > 0) { // 게시글 수정 완료 // 파일
	 * 업로드 관련 코드 삭제
	 * 
	 * result = ServiceResult.OK; } else { result = ServiceResult.FAILED; } return
	 * result; }
	 */
	
	
	@Override
	public ServiceResult updateAnswer(HttpServletRequest req, AnswerVO answerVO) {
	    ServiceResult result = null;
	    int status = mapper.updateAnswer(answerVO); // 게시글 수정
	    if (status > 0) { // 게시글 수정 완료
	        // 게시글 정보에서 파일 목록 가져오기
	        List<AnswerFileVO> answerFileList = answerVO.getAnswerFileList();
	        try {
	            // 공지사항 파일 업로드
	            answerFileUpload(answerFileList, answerVO.getAnsNo(), req);

	            // 기존에 등록되어 있는 파일 목록들 중, 수정하기 위해서 X버튼을 눌러 삭제 처리로 넘겨준 파일 번호들
	            Integer[] delAnswerNo = answerVO.getDelAnswerNo();
	            if (delAnswerNo != null) {
	                for (int i = 0; i < delAnswerNo.length; i++) {
	                    // 삭제할 파일 번호 목록들 중, 파일 번호에 해당하는 공지사항 파일정보를 가져온다.
	                	AnswerFileVO answerFileVO = mapper.selectAnswerFile(delAnswerNo[i]);
	                    mapper.deleteAnswerFile(delAnswerNo[i]); // 파일번호에 해당하는 파일 데이터를 삭제
	                    File file = new File(answerFileVO.getAnsFileSavepath());
	                    file.delete(); // 기존 파일이 업로드 되어 있던 경로에 파일 삭제
	                }
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        result = ServiceResult.OK;
	    } else {
	        result = ServiceResult.FAILED;
	    }
	    return result;
	}
	
	private void answerFileUpload(List<AnswerFileVO> answerFileList, int ansNo, HttpServletRequest req)
			throws IOException {
			String savePath = "/resources/answer/";

			if (answerFileList != null) { // 넘겨받은 파일 데이터가 존재할 때
				if (answerFileList.size() > 0) {
					for (AnswerFileVO answerFileVO : answerFileList) {
						String saveName = UUID.randomUUID().toString(); // UUID의 랜덤 파일명 생성

						// 파일명을 설정할 때, 원본 파일명의 공백을 '_' 로 변경한다.
						saveName = saveName + "_" + answerFileVO.getAnsFileNm().replaceAll(" ", "_");
						// 디버깅 및 확장자 추출 참고
						String endFilename = answerFileVO.getAnsFileNm().split("\\.")[1];

						String saveLocate = req.getServletContext().getRealPath(savePath + ansNo);
						File file = new File(saveLocate);
						if (!file.exists()) {
							file.mkdirs();
						}
						saveLocate += "/" + saveName;

						answerFileVO.setAnsNo(ansNo); // 게시글 번호 설정
						answerFileVO.setAnsFileSavepath(saveLocate); // 파일 업로드 경로 설정
						mapper.insertAnsFile(answerFileVO); // 게시글 파일 데이터 추가

						File saveFile = new File(saveLocate);
						
						
						answerFileVO.getItem().transferTo(saveFile); // 파일 복사

					}
				}
			}
		}
	

	@Override
	public ServiceResult deleteAnswer(HttpServletRequest req, int ansNo) {
	    ServiceResult result = null;

	    // 공지사항 파일 데이터를 삭제하기 위한 준비(파일 적용시)
	    AnswerVO answerVO = mapper.selectAnswer(ansNo); // 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기
	    mapper.deleteAnswerFileByNo(ansNo); // 게시글 번호에 해당하는 파일 데이터 삭제
	    mapper.deleteAnswerComment(ansNo);//댓글삭제랑께
	    

	    int status = mapper.deleteAnswer(ansNo); // 일반적인 게시글 삭제
	    if (status > 0) {
	        // 파일 삭제 관련 코드 삭제
	    List<AnswerFileVO> answerFileList = answerVO.getAnswerFileList();
	    if(answerFileList != null && answerFileList.size() > 0 ) {
	    	String[] filePath = answerFileList.get(0).getAnsFileSavepath().split("/");
	    	
	    	String path = filePath[0];
	    	deleteFolder(req,path);
	    }
	    
	    

	        result = ServiceResult.OK;
	    } else {
	        result = ServiceResult.FAILED;
	    }
	    return result;
	}
	



	
	
	private void deleteFolder(HttpServletRequest req, String path) {
		// TODO Auto-generated method stub
		
	}
	//tag
	/*
	 * @Override public ServiceResult insertAnswerTag(HttpServletRequest req,
	 * AnswerVO answerVO) throws Exception { ServiceResult result = null; int status
	 * = mapper.insertAnswer(answerVO); if(status > 0 ) { List<AnswerFileVO>
	 * answerFileList = answerVO.getAnswerFileList();
	 * AnswerUploadUtils.ansFileUpload(answerFileList, answerVO.getAnsNo(), req,
	 * mapper); if(!answerVO.getTag().equals("")) { String[] tags =
	 * answerVO.getTag().split(" "); for(int i = 0; i < tags.length; i++) {
	 * AnswerTagVO tagVO = new AnswerTagVO(); tagVO.setAnsNo(answerVO.getAnsNo());
	 * tagVO.setAnsTag(tags[i]); mapper.insertAnswerTag("tagVO : " + tagVO);
	 * System.out.println("tagVO :" + tagVO); log.info("tagVO:" + tagVO); } } result
	 * = ServiceResult.OK; } else { result = ServiceResult.FAILED; }
	 * 
	 * return result; }
	 */
	
	@Override
	public ServiceResult insertAnswer(HttpServletRequest req, AnswerVO answerVO) throws Exception {
	    ServiceResult result = null;

	    int status = mapper.insertAnswer(answerVO);

	    if (status > 0) {
	        List<AnswerFileVO> answerFileList = answerVO.getAnswerFileList();
	        log.info("answerFileList : " + answerFileList);
	        AnswerUploadUtils.ansFileUpload(answerFileList, answerVO.getAnsNo(), req, mapper);
	        result = ServiceResult.OK;
	    } else {
	        result = ServiceResult.FAILED;
	    }

	    return result;
	}
	
			@Override
			public AnswerFileVO answerDownload(int fileNo) {
				AnswerFileVO answerFileVO = mapper.answerDownload(fileNo);
				if(answerFileVO == null) {
					throw new RuntimeException();
				}
				return answerFileVO;

	
			}
			@Override
			public int addComment(AnswerCommentVO commentVO) {
				return mapper.addComment(commentVO);
			}
			@Override
			public int deleteComment(int ansCmtnNo) {
				return mapper.deleteComment(ansCmtnNo);
			}
			@Override
			public int modifyComment(AnswerCommentVO commVO) {
				return mapper.modifyComment(commVO);
			}

}
