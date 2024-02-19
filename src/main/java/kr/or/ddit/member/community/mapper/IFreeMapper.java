package kr.or.ddit.member.community.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityFileVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.vo.PaginationInfoVO;


public interface IFreeMapper {

	public int selectFreeBoardCount(PaginationInfoVO<CommunityVO> pagingVO);
	public void incrementHit(int comntPstNo);
	public CommunityVO selectFreeBoard(int comntPstNo);
	public int updateFreeBoard(CommunityVO communityVO);
	public int deleteFreeBoard(int comntPstNo);
	public CommunityFileVO communityDownload(int fileNo);
	public CommunityFileVO selectFreeBoardFile(Integer integer);
	public void deleteFreeBoardFile(Integer integer);
	public void deleteFreeBoardFileByNo(int comntPstNo);
	public void incerementFreeBoardDowncount(int fileNo);
	public int insertFreeBoard(CommunityVO communityVO);
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO);
	public void insertFreeBoardFile(CommunityFileVO communityFileVO);
	public void insertComntFile(CommunityFileVO comntFileVO);
	public int insertFreeTag(Map<String, Object> paramMap);
	public int insertCommunity(CommunityVO communityVO);
	public int addComment(CommunityCommentVO commentVO);
	public CommunityCommentVO anoyDetail(int comntCmtnNo);
	public int deleteComment(int comntCmtnNo);
	public List<CommunityCommentVO> getAnonComments(int comntCmtnNo);
	public List<CommunityCommentVO> selectFreeBoardCommentList(Integer comntPstNo);
	public int updateComment(CommunityCommentVO commentVO);
	public List<CommunityTagVO> selectFreeBoardTagList(Integer comntPstNo);
	public void deleteFreeBoardComment(int comntPstNo);
	public void deleteFreeBoardTag(int comntPstNo);

}


