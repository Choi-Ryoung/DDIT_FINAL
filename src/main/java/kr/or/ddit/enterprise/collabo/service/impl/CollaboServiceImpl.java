package kr.or.ddit.enterprise.collabo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.collabo.mapper.ICollaboMapper;
import kr.or.ddit.enterprise.collabo.service.ICollaboService;
import kr.or.ddit.enterprise.collabo.vo.CollaboVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class CollaboServiceImpl implements ICollaboService {
	
	@Inject
	private ICollaboMapper collaboMapper;
	
	@Override
	public int selectCollaboCount(PaginationInfoVO<CollaboVO> pagingVO) {
		return collaboMapper.selectCollaboCount(pagingVO);
	}

	@Override
	public List<CollaboVO> selectCollaboList(PaginationInfoVO<CollaboVO> pagingVO) {
		return collaboMapper.selectCollaboList(pagingVO);
	}

	@Override
	public int insertCollabo(CollaboVO collaboVO) {
		return collaboMapper.insertCollabo(collaboVO);
	}

}
