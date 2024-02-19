package kr.or.ddit.member.login.mapper;

import java.util.Map;

import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;

public interface ILoginMapper {

	int signup(PrivateMemberVO memberVO);
	int entsignup(EnterpriseMemberVO entmemberVO);
	
	
	Integer selectOverlappedID(String memId);
	Integer selectOverlappedEntID(String entId);
	Integer selectOverlappedNick(String memNickNm);
	
	public int insertMember(PrivateMemberVO memberVO);
	public int entinsertMember(EnterpriseMemberVO entmemberVO);
	
	PrivateMemberVO selectNormalMember(Map<String, Object> info);
	
	EnterpriseMemberVO selectentMember(Map<String, Object> info);
	
	public int updateStopStatus(String id);
	public int updateEntStopStatus(String id);
	//일반회원 아이디/비밀번호 찾기
	PrivateMemberVO findMemberId(Map<String, Object> map);
	void updateMemberPw(Map<String, Object> map);
	//기업회원 아이디/비밀번호 찾기
	EnterpriseMemberVO findEntId(Map<String, Object> map);
	void updateEntPw(Map<String, Object> map);
	public String selectEntId(Map<String, Object> map);
	//네이버로그인및회원가입
	int selectSSId(String id);
	int insertSSMember(Map<String, String> pMap);

}
