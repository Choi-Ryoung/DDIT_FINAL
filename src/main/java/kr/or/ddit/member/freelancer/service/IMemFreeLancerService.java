package kr.or.ddit.member.freelancer.service;

import java.util.List;

import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IMemFreeLancerService {

	public int selPjCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

	public List<ProjectBoardVO> selPjListAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

}
