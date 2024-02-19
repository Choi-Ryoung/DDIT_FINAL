package kr.or.ddit.admin.community.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;

public interface AdminFreeService {

	public int selectBoardCount(PaginationInfoVO<CommunityVO> pagingVO);
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO);
	public CommunityVO selectFreeBoard(int comntPstNo);
	public List<CommunityCommentVO> selectFreeBoardCommentList(int comntPstNo);
	public List<CommunityTagVO> selectFreeBoardTagList(int comntPstNo);
	public ServiceResult deleteFreeBoard(HttpServletRequest req, int comntPstNo);
	public int deleteComment(int comntCmtnNo);

}
