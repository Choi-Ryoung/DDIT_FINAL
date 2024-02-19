package kr.or.ddit.member.community.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.community.controller.FileUploadUtils;
//import kr.or.ddit.member.community.controller.TelegramSendController;
import kr.or.ddit.member.community.mapper.IFreeMapper;
import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityFileVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FreeServiceImpl implements IFreeService {

	@Inject
	private IFreeMapper mapper;

	@Override
	public int selectFreeBoardCount(PaginationInfoVO<CommunityVO> pagingVO) {
		return mapper.selectFreeBoardCount(pagingVO);
	}

	@Override
	public CommunityVO selectFreeBoard(int comntPstNo) {
		mapper.incrementHit(comntPstNo); // 게시글 조회수 증가
		return mapper.selectFreeBoard(comntPstNo); // 게시글 번호에 해당하는 게시글 정보 가져오기
	}

	@Override
	public ServiceResult updateFreeBoard(HttpServletRequest req, CommunityVO communityVO) {
		ServiceResult result = null;
		int status = mapper.updateFreeBoard(communityVO); // 게시글 수정
		if (status > 0) { // 게시글 수정 완료
			// 게시글 정보에서 파일 목록 가져오기
			List<CommunityFileVO> communityFileList = communityVO.getCommunityFileList();
			try {
				// 공지사항 파일 업로드
				communityFileUpload(communityFileList, communityVO.getComntPstNo(), req);

				// 기존에 등록되어 있는 파일 목록들 중, 수정하기 위해서 X버튼을 눌러 삭제 처리로 넘겨준 파일 번호들
				Integer[] delFreeBoardeNo = communityVO.getDelFreeBoardNo();
				if (delFreeBoardeNo != null) {
					for (int i = 0; i < delFreeBoardeNo.length; i++) {
						// 삭제할 파일 번호 목록들 중, 파일 번호에 해당하는 공지사항 파일정보를 가져온다.
						CommunityFileVO communityFileVO = mapper.selectFreeBoardFile(delFreeBoardeNo[i]);
						mapper.deleteFreeBoardFile(delFreeBoardeNo[i]); // 파일번호에 해당하는 파일 데이터를 삭제
						File file = new File(communityFileVO.getComntFileSavepath());
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

	private void communityFileUpload(List<CommunityFileVO> communityFileList, int comntPstNo, HttpServletRequest req)
			throws IOException {
		String savePath = "/resources/freeboard/";

		if (communityFileList != null) { // 넘겨받은 파일 데이터가 존재할 때
			if (communityFileList.size() > 0) {
				for (CommunityFileVO communityFileVO : communityFileList) {
					String saveName = UUID.randomUUID().toString(); // UUID의 랜덤 파일명 생성

					// 파일명을 설정할 때, 원본 파일명의 공백을 '_' 로 변경한다.
					saveName = saveName + "_" + communityFileVO.getComntFileNm().replaceAll(" ", "_");
					// 디버깅 및 확장자 추출 참고
					String endFilename = communityFileVO.getComntFileNm().split("\\.")[1];

					String saveLocate = req.getServletContext().getRealPath(savePath + comntPstNo);
					File file = new File(saveLocate);
					if (!file.exists()) {
						file.mkdirs();
					}
					saveLocate += "/" + saveName;

					communityFileVO.setComntPstNo(comntPstNo); // 게시글 번호 설정
					communityFileVO.setComntFileSavepath(saveLocate); // 파일 업로드 경로 설정
					mapper.insertFreeBoardFile(communityFileVO); // 게시글 파일 데이터 추가

					File saveFile = new File(saveLocate);
					// 방법 1
					/*
					 * InputStream is = communityFileVO.getItem().getInputStream();
					 * FileUtils.copyInputStreamToFile(is, saveFile);
					 */

					// 방법 2
					communityFileVO.getItem().transferTo(saveFile); // 파일 복사

				}
			}
		}
	}

	@Override
	public ServiceResult deleteFreeBoard(HttpServletRequest req, int comntPstNo) {
		ServiceResult result = null;

		// 공지사항 파일 데이터를 삭제하기 위한 준비(파일 적용시)
		CommunityVO communityVO = mapper.selectFreeBoard(comntPstNo); // 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기
		mapper.deleteFreeBoardFileByNo(comntPstNo); // 게시글 번호에 해당하는 파일 데이터 삭제
		mapper.deleteFreeBoardComment(comntPstNo);	// 댓글 삭제
		mapper.deleteFreeBoardTag(comntPstNo);

		int status = mapper.deleteFreeBoard(comntPstNo); // 일반적인 게시글 삭제
		if (status > 0) {
			List<CommunityFileVO> communityFileList = communityVO.getCommunityFileList();
			if (communityFileList != null && communityFileList.size() > 0) {
				if(communityFileList.get(0).getComntFileSavepath() != null) {
					// D:\99_Class.....\workspace\.metadata\.plugins.....\Project명\resources\notice\comntPstNo
					// 2or8u238r23oi23e23ep23e.jpg
					// '/'기준으로 잘라준다.
					String[] filePath = communityFileList.get(0).getComntFileSavepath().split("/");
					
					String path = filePath[0];
					deleteFolder(req, path);
				}
			}

			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	private void deleteFolder(HttpServletRequest req, String path) {
		// UUID+원본파일명 전 폴더경로를 folder 파일객체로 잡는다.
		File folder = new File(path);

		if (folder.exists()) { // 경로가 존재한다면
			File[] folderList = folder.listFiles(); // 폴더 안에 있는 파일들의 목록을 가져온다.

			for (int i = 0; i < folderList.length; i++) {
				if (folderList[i].isFile()) { // 폴더안의 있는 파일이 파일일때
					// 폴더 안에 파일을 차레대로 삭제
					folderList[i].delete();
				} else {
					// 폴더안에 있는 파일이 폴더일때 재귀함수 호출(폴더안으로 들어가서 재 처리할 수 있도록)
					deleteFolder(req, folderList[i].getPath());
				}
			}
			folder.delete(); // 폴더 삭제
		}
	}

	@Override
	public CommunityFileVO communityDownload(int fileNo) {
		CommunityFileVO communityFileVO = mapper.communityDownload(fileNo);
		if (communityFileVO == null) {
			throw new RuntimeException();
		}
		return communityFileVO;
	}

	@Override
	public ServiceResult insertFreeBoard(HttpServletRequest req, CommunityVO communityVO) throws Exception {
		ServiceResult result = null;

		int status = mapper.insertFreeBoard(communityVO);

		if (status > 0) {
			// 태그를 등록
			String[] tags = communityVO.getTags().split(" ");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			for(int i = 0; i < tags.length; i++) {
//				(#{comntPstNo}, #{comntTag})
				paramMap.put("comntPstNo", communityVO.getComntPstNo());
				paramMap.put("comntTag", tags[i]);
				mapper.insertFreeTag(paramMap);
			}
			
			List<CommunityFileVO> communityFileList = communityVO.getCommunityFileList();
			log.info("communityFileList : " + communityFileList);
			FileUploadUtils.comntFileUpload(communityFileList, communityVO.getComntPstNo(), req, mapper);
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO) {
		return mapper.selectFreeBoardList(pagingVO);
	}
	
	@Override
	public int deleteComment(int comntCmtnNo) {
		return mapper.deleteComment(comntCmtnNo);
	}

	@Override
	public int addComment(CommunityCommentVO commentVO) {
		return mapper.addComment(commentVO);
	}

	@Override
	public CommunityCommentVO anoyDetail(int comntCmtnNo) {
		return mapper.anoyDetail(comntCmtnNo);
	}

	@Override
	public List<CommunityCommentVO> getAnonComments(int comntCmtnNo) {
		 return mapper.getAnonComments(comntCmtnNo);
	}

	@Override
	public List<CommunityCommentVO> selectFreeBoardCommentList(Integer comntPstNo) {
		return mapper.selectFreeBoardCommentList(comntPstNo);
	}

	@Override
	public int modifyComment(CommunityCommentVO communityVO) {
		return mapper.updateComment(communityVO); // 댓글 업데이트
	}

	@Override
	public List<CommunityTagVO> selectFreeBoardTagList(Integer comntPstNo) {
		return mapper.selectFreeBoardTagList(comntPstNo);
	}

	
	
	
}
