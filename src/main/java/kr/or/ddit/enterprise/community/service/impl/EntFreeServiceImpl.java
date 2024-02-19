package kr.or.ddit.enterprise.community.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.community.mapper.EntFreeMapper;
import kr.or.ddit.enterprise.community.service.EntFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;

@Service
public class EntFreeServiceImpl implements EntFreeService {

	@Inject
	private EntFreeMapper entFreeMapper;
	
	@Override
	public int selectBoardCount(PaginationInfoVO<CommunityVO> pagingVO) {
		return entFreeMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<CommunityVO> selectFreeBoardList(PaginationInfoVO<CommunityVO> pagingVO) {
		return entFreeMapper.selectFreeBoardList(pagingVO);
	}

	@Override
	public CommunityVO selectFreeBoard(int comntPstNo) {
		entFreeMapper.incrementHit(comntPstNo); // 게시글 조회수 증가
		return entFreeMapper.selectFreeBoard(comntPstNo); // 게시글 번호에 해당하는 게시글 정보 가져오기
	}

	@Override
	public List<CommunityCommentVO> selectFreeBoardCommentList(Integer comntPstNo) {
		return entFreeMapper.selectFreeBoardCommentList(comntPstNo);
	}

	@Override
	public List<CommunityTagVO> selectFreeBoardTagList(Integer comntPstNo) {
		return entFreeMapper.selectFreeBoardTagList(comntPstNo);
	}

}
