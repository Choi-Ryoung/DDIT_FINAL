package kr.or.ddit.member.enterpriseinfo.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewQuestionVO;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEnterpriseReviewMapper {

	public int insert(EnterpriseReviewVO erVo);

	public int listCnt(PaginationInfoVO<EnterpriseReviewVO> pagingVO);

	public List<EnterpriseReviewVO> list(PaginationInfoVO<EnterpriseReviewVO> pagingVO);

	public int selCnt();
	
	public List<EnterpriseReviewQuestionVO> selQuesList();

	public List<EnterpriseReviewQuestionVO> selQuesCd();

	public int selColOptionCnt(Map<String, String> map);

	public List<EnterpriseMemberVO> selEmList();

	public List<EnterpriseReviewVO> selErDetail(String entMbrId);

	public int selErDetailCnt(String entMbrId);

	public String selEmConEntMbrId(String entNm);

	public Map<String, String> selDataTest(Map<String, String> map);

	public Map<String, String> selRankResult(Map<String, String> pMap);

	public Map<String, String> getCntAnnounceMent(Map<String, String> pMap);

	public List<Map<String, Object>> getEntNm(Map<String, Object> pMap) throws Exception;

}
