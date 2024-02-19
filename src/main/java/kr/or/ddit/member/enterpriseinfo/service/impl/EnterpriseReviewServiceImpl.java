package kr.or.ddit.member.enterpriseinfo.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.enterpriseinfo.mapper.IEnterpriseReviewMapper;
import kr.or.ddit.member.enterpriseinfo.service.IEnterpriseReviewService;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewQuestionVO;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class EnterpriseReviewServiceImpl implements IEnterpriseReviewService {

	@Inject
	private IEnterpriseReviewMapper mapper;

	@Override
	public int listCnt(PaginationInfoVO<EnterpriseReviewVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.listCnt(pagingVO);
	}

	@Override
	public List<EnterpriseReviewVO> list(PaginationInfoVO<EnterpriseReviewVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.list(pagingVO);
	}

	@Override
	public int insert(EnterpriseReviewVO erVo) {
		// TODO Auto-generated method stub
		return mapper.insert(erVo);
	}

	

	@Override
	public int selCnt() {
		// TODO Auto-generated method stub
		return mapper.selCnt();
	}

	@Override
	public List<EnterpriseReviewQuestionVO> selQuesList() {
		// TODO Auto-generated method stub
		return mapper.selQuesList();
	}

	@Override
	public List<EnterpriseReviewQuestionVO> selQuesCd() {
		// TODO Auto-generated method stub
		return mapper.selQuesCd();
	}

	@Override
	public int selColOptionCnt(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.selColOptionCnt(map);
	}

	@Override
	public List<EnterpriseMemberVO> selEmList() {
		// TODO Auto-generated method stub
		return mapper.selEmList();
	}

	@Override
	public List<EnterpriseReviewVO> selErDetail(String entMbrId) {
		// TODO Auto-generated method stub
		return mapper.selErDetail(entMbrId);
	}

	@Override
	public int selErDetailCnt(String entMbrId) {
		// TODO Auto-generated method stub
		return mapper.selErDetailCnt(entMbrId);
	}

	@Override
	public String selEmConEntMbrId(String entNm) {
		// TODO Auto-generated method stub
		return mapper.selEmConEntMbrId(entNm);
	}

	@Override
	public Map<String, String> selDataTest(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.selDataTest(map);
	}

	@Override
	public Map<String, String> selRankResult(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.selRankResult(pMap);
	}

	@Override
	public Map<String, String> getCntAnnounceMent(Map<String, String> pMap) {
		// TODO Auto-generated method stub
		return mapper.getCntAnnounceMent(pMap);
	}

	@Override
	public List<Map<String, Object>> getEntNm(Map<String, Object> pMap) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getEntNm(pMap);
	}


}
