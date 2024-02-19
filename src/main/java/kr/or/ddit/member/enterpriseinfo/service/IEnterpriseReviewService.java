package kr.or.ddit.member.enterpriseinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewQuestionVO;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IEnterpriseReviewService {
	
	public int listCnt(PaginationInfoVO<EnterpriseReviewVO> pagingVO);
	
	public int selCnt();

	public List<EnterpriseReviewVO> list(PaginationInfoVO<EnterpriseReviewVO> pagingVO);

	public int insert(EnterpriseReviewVO erVo);
	
	//기업리뷰 질문
	public List<EnterpriseReviewQuestionVO> selQuesList();
	public List<EnterpriseReviewQuestionVO> selQuesCd();

	public int selColOptionCnt(Map<String, String> map);
	
	public Map<String, String> selDataTest(Map<String, String> map);


	public List<EnterpriseReviewVO> selErDetail(String entMbrId);

	public List<EnterpriseMemberVO> selEmList();

	public int selErDetailCnt(String entMbrId);

	public String selEmConEntMbrId(String entNm);

	public Map<String,String> selRankResult(Map<String, String> pMap);

	public Map<String, String> getCntAnnounceMent(Map<String, String> pMap);

	public List<Map<String, Object>> getEntNm(Map<String, Object> pMap) throws Exception;
	
	
}
