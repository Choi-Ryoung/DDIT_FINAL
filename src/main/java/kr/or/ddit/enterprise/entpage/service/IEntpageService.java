package kr.or.ddit.enterprise.entpage.service;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.EnterpriseMemberVO;

public interface IEntpageService {

	
	EnterpriseMemberVO getEntAccountAll(String entmemberId);
	EnterpriseMemberVO getEntAccount(String entmemberId);

	EnterpriseMemberVO getEntManage(String entmemberId);

	int entManageUpdate(HttpServletRequest req, EnterpriseMemberVO entmember);

	int entAccountUpdate(HttpServletRequest req, EnterpriseMemberVO entmemberVO);
}
