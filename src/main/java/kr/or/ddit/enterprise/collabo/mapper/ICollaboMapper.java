package kr.or.ddit.enterprise.collabo.mapper;

import java.util.List;

import kr.or.ddit.enterprise.collabo.vo.CollaboVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ICollaboMapper {

	public int selectCollaboCount(PaginationInfoVO<CollaboVO> pagingVO);

	public List<CollaboVO> selectCollaboList(PaginationInfoVO<CollaboVO> pagingVO);

	public int insertCollabo(CollaboVO collaboVO);

}
