package kr.or.ddit.admin.community.service.impl;

import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.admin.community.mapper.AdminFreeMapper;
import kr.or.ddit.admin.community.service.AdminFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityFileVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;

@Service
public class AdminFreeServiceImpl implements AdminFreeService {

	@Inject
	private AdminFreeMapper adminFreeMapper;
	
	@Override
	public int selectBoardCount(PaginationInfoVO<CommunityVO> pagingVO) {
		return adminFreeMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO) {
		return adminFreeMapper.selectFreeBoardList(pagingVO);
	}

	@Override
	public CommunityVO selectFreeBoard(int comntPstNo) {
		adminFreeMapper.incrementHit(comntPstNo); // 게시글 조회수 증가
		return adminFreeMapper.selectFreeBoard(comntPstNo); // 게시글 번호에 해당하는 게시글 정보 가져오기
	}

	@Override
	public List<CommunityCommentVO> selectFreeBoardCommentList(int comntPstNo) {
		return adminFreeMapper.selectFreeBoardCommentList(comntPstNo);
	}

	@Override
	public List<CommunityTagVO> selectFreeBoardTagList(int comntPstNo) {
		return adminFreeMapper.selectFreeBoardTagList(comntPstNo);
	}

	@Override
	public ServiceResult deleteFreeBoard(HttpServletRequest req, int comntPstNo) {
		ServiceResult result = null;

		// 공지사항 파일 데이터를 삭제하기 위한 준비(파일 적용시)
		CommunityVO communityVO = adminFreeMapper.selectFreeBoard(comntPstNo); // 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기
		adminFreeMapper.deleteFreeBoardFileByNo(comntPstNo); // 게시글 번호에 해당하는 파일 데이터 삭제
		adminFreeMapper.deleteFreeBoardComment(comntPstNo);	// 댓글 삭제
		adminFreeMapper.deleteFreeBoardTag(comntPstNo);

		int status = adminFreeMapper.deleteFreeBoard(comntPstNo); // 일반적인 게시글 삭제
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
	public int deleteComment(int comntCmtnNo) {
		return adminFreeMapper.deleteComment(comntCmtnNo);
	}

}
