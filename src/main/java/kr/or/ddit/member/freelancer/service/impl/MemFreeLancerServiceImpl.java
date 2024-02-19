package kr.or.ddit.member.freelancer.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.freelancer.mapper.IMemFreeLancerMapper;
import kr.or.ddit.member.freelancer.service.IMemFreeLancerService;
import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class MemFreeLancerServiceImpl implements IMemFreeLancerService {

	@Inject
	private IMemFreeLancerMapper projectMapper;
	
	
	@Override
	public int selPjCntAll(PaginationInfoVO<ProjectBoardVO> pagingVO) {
		return projectMapper.selPjCntAll(pagingVO);
	}

	@Override
	public List<ProjectBoardVO> selPjListAll(PaginationInfoVO<ProjectBoardVO> pagingVO) {
		return projectMapper.selPjListAll(pagingVO);
	}

}
