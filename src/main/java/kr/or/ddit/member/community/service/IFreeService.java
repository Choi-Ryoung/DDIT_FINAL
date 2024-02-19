package kr.or.ddit.member.community.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityFileVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IFreeService {
	

	public int selectFreeBoardCount(PaginationInfoVO<CommunityVO> pagingVO);


	public CommunityVO selectFreeBoard(int comntPstNo);

	public ServiceResult deleteFreeBoard(HttpServletRequest req, int comntPstNo);

	public ServiceResult updateFreeBoard(HttpServletRequest req, CommunityVO communityVO);

	public CommunityFileVO communityDownload(int fileNo);

	public ServiceResult insertFreeBoard(HttpServletRequest req ,CommunityVO communityVO) throws Exception;
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO);


	//댓글
	public int deleteComment(int comntCmtnNo);


	public int addComment(CommunityCommentVO commentVO);


	public CommunityCommentVO anoyDetail(int comntCmtnNo);


	public List<CommunityCommentVO> getAnonComments(int comntCmtnNo);


	public List<CommunityCommentVO> selectFreeBoardCommentList(Integer comntPstNo);


	public int modifyComment(CommunityCommentVO communityVO);


	public List<CommunityTagVO> selectFreeBoardTagList(Integer comntPstNo);



	












	
	
	

}
