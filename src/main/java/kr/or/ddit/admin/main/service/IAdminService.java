package kr.or.ddit.admin.main.service;

import java.util.List;

import kr.or.ddit.admin.main.vo.AdminMainGraphVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface IAdminService {

	// 최신 가입 10명(일반회원)	
	public List<PrivateMemberVO> selectTopTenPrMbr();
	
	// 최신 가입 10명(기업회원)
	public List<EnterpriseMemberVO> selectTopTenEntMbr();

	public List<AdminMainGraphVO> getCountMembersList(AdminMainGraphVO graphVO);

	public List<AdminMainGraphVO> getCountEntMemberList(AdminMainGraphVO graphVO);

}
