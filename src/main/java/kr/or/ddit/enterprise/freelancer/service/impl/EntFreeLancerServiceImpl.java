package kr.or.ddit.enterprise.freelancer.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.freelancer.mapper.IEntFreeLancerMapper;
import kr.or.ddit.enterprise.freelancer.service.IEntFreeLancerService;
import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class EntFreeLancerServiceImpl implements IEntFreeLancerService {

	@Inject
	private IEntFreeLancerMapper mapper;
	
	@Override
	public List<ProjectBoardVO> selFlListAll(PaginationInfoVO<ProjectBoardVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.selFlListAll(pagingVO);
	}

	@Override
	public int selFlCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.selFlCntAll(pagingVO);
	}

	@Override
	public int insert(ProjectBoardVO pjVo) {
		// TODO Auto-generated method stub
		return mapper.insert(pjVo);
	}
	
	
}
