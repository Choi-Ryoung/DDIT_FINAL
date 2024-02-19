package kr.or.ddit.member.freelancer.mapper;

import java.util.List;

import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;


public interface IMemFreeLancerMapper {


	public int selPjCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

	public List<ProjectBoardVO> selPjListAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

}
