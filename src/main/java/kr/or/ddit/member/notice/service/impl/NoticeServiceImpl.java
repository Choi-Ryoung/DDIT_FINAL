package kr.or.ddit.member.notice.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.notice.controller.FileUploadUtils;
import kr.or.ddit.member.notice.mapper.INoticeMapper;
import kr.or.ddit.member.notice.service.INoticeService;
import kr.or.ddit.member.notice.vo.NoticeFileVO;
import kr.or.ddit.member.notice.vo.NoticeTagVO;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.member.notice.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements INoticeService {
	
	@Inject
	private INoticeMapper mapper;

	// NoticeRetreiveContoller
	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectNoticeCount(pagingVO);
	}
	
	@Override
	public NoticeVO selectNotice(int ntPstNo) {
		mapper.incrementHit(ntPstNo); 	// 게시글 조회수 증가
		return mapper.selectNotice(ntPstNo); //게시글 번호에 해당하는 게시글 정보 가져오기
	}
	
	@Override
	public ServiceResult updateNotice(HttpServletRequest req, NoticeVO noticeVO) {
		ServiceResult result = null;
		int status = mapper.updateNotice(noticeVO); // 게시글 수정
		if (status > 0) { // 게시글 수정 완료
			// 게시글 정보에서 파일 목록 가져오기
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				// 공지사항 파일 업로드
				noticeFileUpload(noticeFileList, noticeVO.getNtPstNo(), req);

				// 기존에 등록되어 있는 파일 목록들 중, 수정하기 위해서 X버튼을 눌러 삭제 처리로 넘겨준 파일 번호들
				Integer[] delNoticeNo = noticeVO.getDelNoticeNo();
				if (delNoticeNo != null) {
					for (int i = 0; i < delNoticeNo.length; i++) {
						// 삭제할 파일 번호 목록들 중, 파일 번호에 해당하는 공지사항 파일정보를 가져온다.
						NoticeFileVO noticeFileVO = mapper.selectNoticeFile(delNoticeNo[i]);
						mapper.deleteNoticeFile(delNoticeNo[i]); // 파일번호에 해당하는 파일 데이터를 삭제
						File file = new File(noticeFileVO.getNtFileSavepath());
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
	
		private void noticeFileUpload(List<NoticeFileVO> noticeFileList, int ntPstNo, HttpServletRequest req)
			throws IOException {
		String savePath = "/resources/notice/";

		if (noticeFileList != null) { // 넘겨받은 파일 데이터가 존재할 때
			if (noticeFileList.size() > 0) {
				for (NoticeFileVO noticeFileVO : noticeFileList) {
					String saveName = UUID.randomUUID().toString(); // UUID의 랜덤 파일명 생성

					// 파일명을 설정할 때, 원본 파일명의 공백을 '_' 로 변경한다.
					saveName = saveName + "_" + noticeFileVO.getNtFileNm().replaceAll(" ", "_");
					// 디버깅 및 확장자 추출 참고
					String endFilename = noticeFileVO.getNtFileNm().split("\\.")[1];

					String saveLocate = req.getServletContext().getRealPath(savePath + ntPstNo);
					File file = new File(saveLocate);
					if (!file.exists()) {
						file.mkdirs();
					}
					saveLocate += "/" + saveName;

					noticeFileVO.setNtPstNo(ntPstNo); // 게시글 번호 설정
					noticeFileVO.setNtFileSavepath(saveLocate); // 파일 업로드 경로 설정
					mapper.insertNoticeFile(noticeFileVO); // 게시글 파일 데이터 추가

					File saveFile = new File(saveLocate);
					
					
					noticeFileVO.getItem().transferTo(saveFile); // 파일 복사

				}
			}
		}
	}

		@Override
		public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) throws Exception {
			ServiceResult result = null;

			int status = mapper.insertNotice(noticeVO);

			if (status > 0) {
				List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
				log.info("noticeFileList : " + noticeFileList);
				FileUploadUtils.ntFileUpload(noticeFileList, noticeVO.getNtPstNo(), req, mapper);
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}

			return result;
	}
		
		

		@Override
		public ServiceResult deleteNotice(HttpServletRequest req, int ntPstNo) {
			ServiceResult result = null;

			// 공지사항 파일 데이터를 삭제하기 위한 준비(파일 적용시)
			NoticeVO noticeVO = mapper.selectNotice(ntPstNo); // 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기
			mapper.deleteNoticeFileByNo(ntPstNo); // 게시글 번호에 해당하는 파일 데이터 삭제

			int status = mapper.deleteNotice(ntPstNo); // 일반적인 게시글 삭제
			if (status > 0) {
				List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
				if (noticeFileList != null && noticeFileList.size() > 0) {
					// D:\99_Class.....\workspace\.metadata\.plugins.....\Project명\resources\notice\ntPstNo
					// 2or8u238r23oi23e23ep23e.jpg
					// '/'기준으로 잘라준다.
					String[] filePath = noticeFileList.get(0).getNtFileSavepath().split("/");

					String path = filePath[0];
					deleteFolder(req, path);
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
		public NoticeFileVO noticeDownload(int fileNo) {
			NoticeFileVO noticeFileVO = mapper.noticeDownload(fileNo);
			if(noticeFileVO == null) {
				throw new RuntimeException();
			}
			return noticeFileVO;
		}




		@Override
		public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
			return mapper.selectNoticeList(pagingVO);
		}
		
		
		//tag
		@Override
		public ServiceResult insertNoticeTag(HttpServletRequest req, NoticeVO noticeVO) throws Exception {
			ServiceResult result = null;
			int status = mapper.insertNotice(noticeVO);
			if(status > 0 ) {
				List<NoticeFileVO>  noticeFileList = noticeVO.getNoticeFileList();
				FileUploadUtils.ntFileUpload(noticeFileList, noticeVO.getNtPstNo(), req, mapper);
				if(!noticeVO.getTag().equals("")) {
					String[] tags = noticeVO.getTag().split(" ");
					for(int i = 0; i < tags.length; i++) {
						NoticeTagVO tagVO = new NoticeTagVO();
						tagVO.setNtPstNo(noticeVO.getNtPstNo());
						tagVO.setNtTag(tags[i]);
						mapper.insertNoticeTag("tagVO : " + tagVO);
						System.out.println("tagVO :" + tagVO);
						log.info("tagVO:" + tagVO);
					}
				}
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
			
			return result;
		}
		






		
		

}
