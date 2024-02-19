package kr.or.ddit.enterprise.entpage.mapper;

import kr.or.ddit.vo.EnterpriseMemberVO;

public interface IEntpageMapper {

	public EnterpriseMemberVO getEntAccount(String entmemberId);

	public EnterpriseMemberVO getEntManage(String entmemberId);
	
	public int entManageUpdate(EnterpriseMemberVO entmemberVO);

	public EnterpriseMemberVO getEntAccountAll(String entmemberId);

	public int entAccountUpdate(EnterpriseMemberVO entmemberVO);

}
