package kr.or.ddit.enterprise.freelancer.service;

import java.util.List;

import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEntFreeLancerService {
	
	public List<ProjectBoardVO> selFlListAll(PaginationInfoVO<ProjectBoardVO> pagingVO);
	public int selFlCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO);
	public int insert(ProjectBoardVO pjVo);

}
