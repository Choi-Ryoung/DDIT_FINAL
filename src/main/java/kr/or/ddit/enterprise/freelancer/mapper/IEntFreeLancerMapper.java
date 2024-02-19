package kr.or.ddit.enterprise.freelancer.mapper;

import java.util.List;

import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.CommonCodeGroupVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEntFreeLancerMapper {

	public List<ProjectBoardVO> selFlListAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

	public int selFlCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO);

	public int insert(ProjectBoardVO pjVo);
	


}
