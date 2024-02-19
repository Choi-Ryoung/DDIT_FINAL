package kr.or.ddit.member.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface ILoginService {

	boolean registerMember(PrivateMemberVO memberVO);
//boolean registerEntMember(EnterpriseMemberVO entmemberVO);

	boolean checkDuplicateId(String memId);
	boolean checkDuplicateEntId2(String entId);
	boolean checkDuplicateNick(String memNickNm);
	
	//일반회원가입
	public int insertMember(PrivateMemberVO memberVO);
	//기업회원가입
	public int entinsertMember(EnterpriseMemberVO memberVO,HttpServletRequest req);
	

	public PrivateMemberVO selectMember(String prMbrId, String prMbrPswd);
	public EnterpriseMemberVO selectentMember(String id, String pw);
	
	// 정지일자 업데이트
	public int updateStopStatus(String id);
	public int updateEntStopStatus(String id);
	
	//일반회원 아이디/비밀번호 찾기
	PrivateMemberVO findMemberId(Map<String, Object> map);
	void updateMemberPw(Map<String, Object> map);
	//기업회원 아이디/비밀번호 찾기
	EnterpriseMemberVO findEntId(Map<String, Object> map);
	void updateEntPw(Map<String, Object> map);

	public String selectEntId(Map<String, Object> map);
	
	//네이버 로그인및회원가입
	public int selectSSId(String id);
	int insertSSMember(Map<String,String> pMap);





	

}
