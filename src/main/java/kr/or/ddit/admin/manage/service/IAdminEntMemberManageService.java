package kr.or.ddit.admin.manage.service;

import java.util.List;

import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminEntMemberManageService {

	public int selectEntMemberCount(PaginationInfoVO<EnterpriseMemberVO> pagingVO);

	public List<EnterpriseMemberVO> selectEntMemberList(PaginationInfoVO<EnterpriseMemberVO> pagingVO);

	public EnterpriseMemberVO selectEntMemberDetail(String entMbrId);

	public int updateEntMemberInfo(EnterpriseMemberVO entMemberVO);

	public void updateUseStopEndYmd(EnterpriseMemberVO entMemberVO);



}
