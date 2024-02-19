package kr.or.ddit.admin.manage.mapper;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface IAdminMemberManageMapper {

	public int selectMemberCount(PaginationInfoVO<PrivateMemberVO> pagingVO);

	public List<PrivateMemberVO> selectMemberList(PaginationInfoVO<PrivateMemberVO> pagingVO);

	public PrivateMemberVO selectMemberDetail(String prMbrId);

	public int updateMemberInfo(PrivateMemberVO pqVO);

	public void updateUseStopEndYmd(PrivateMemberVO pqVO);

}
