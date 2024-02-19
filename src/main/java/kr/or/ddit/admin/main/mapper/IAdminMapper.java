package kr.or.ddit.admin.main.mapper;

import java.util.List;

import kr.or.ddit.admin.main.vo.AdminMainGraphVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface IAdminMapper {

	public List<PrivateMemberVO> selectTopTenPrMbr();

	public List<EnterpriseMemberVO> selectTopTenEntMbr();

	public List<AdminMainGraphVO> getCountMembersList(AdminMainGraphVO graphVO);

	public List<AdminMainGraphVO> getCountEntMemberList(AdminMainGraphVO graphVO);

}
