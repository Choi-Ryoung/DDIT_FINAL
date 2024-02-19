package kr.or.ddit.admin.login.mapper;

import kr.or.ddit.vo.AdminVO;

public interface AdminLoginMapper {

	/*
	 * int signup(PrivateMemberVO memberVO); int entsignup(EnterpriseMemberVO
	 * entmemberVO);
	 * 
	 * Integer selectOverlappedID(String memId); Integer
	 * selectOverlappedEntID(String entId);
	 * 
	 * public int insertMember(PrivateMemberVO memberVO); public int
	 * entinsertMember(EnterpriseMemberVO entmemberVO);
	 * 
	 * PrivateMemberVO selectNormalMember(Map<String, Object> info);
	 * 
	 * EnterpriseMemberVO selectentMember(Map<String, Object> info);
	 */
	AdminVO adminLogin(AdminVO admin);


}
