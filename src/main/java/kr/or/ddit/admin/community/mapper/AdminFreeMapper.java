package kr.or.ddit.admin.community.mapper;

import java.util.List;

import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;

public interface AdminFreeMapper {

	public int selectBoardCount(PaginationInfoVO<CommunityVO> pagingVO);
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO);
	public void incrementHit(int comntPstNo);
	public CommunityVO selectFreeBoard(int comntPstNo);
	public List<CommunityCommentVO> selectFreeBoardCommentList(int comntPstNo);
	public List<CommunityTagVO> selectFreeBoardTagList(int comntPstNo);
	public void deleteFreeBoardFileByNo(int comntPstNo);
	public void deleteFreeBoardTag(int comntPstNo);
	public int deleteFreeBoard(int comntPstNo);
	public int deleteComment(int comntCmtnNo);
	public void deleteFreeBoardComment(int comntPstNo);

}
