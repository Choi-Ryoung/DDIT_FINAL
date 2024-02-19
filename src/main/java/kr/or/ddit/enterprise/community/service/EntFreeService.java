package kr.or.ddit.enterprise.community.service;

import java.util.List;

import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;

public interface EntFreeService {
	public int selectBoardCount(PaginationInfoVO<CommunityVO> pagingVO);
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO);
	public CommunityVO selectFreeBoard(int comntPstNo);
	public List<CommunityCommentVO> selectFreeBoardCommentList(Integer comntPstNo);
	public List<CommunityTagVO> selectFreeBoardTagList(Integer comntPstNo);

}
