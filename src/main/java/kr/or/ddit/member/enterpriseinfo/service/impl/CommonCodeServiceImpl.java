package kr.or.ddit.member.enterpriseinfo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.enterpriseinfo.mapper.ICommonCodeMapper;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.vo.CommonCodeGroupVO;
import kr.or.ddit.vo.CommonCodeVO;

@Service
public class CommonCodeServiceImpl implements ICommonCodeService {
	@Inject
	private ICommonCodeMapper mapper;

	@Override
	public List<CommonCodeGroupVO> selCommonCodeGroupList() {
		// TODO Auto-generated method stub
		return mapper.selCommonCodeGroupList();
	}

	@Override
	public CommonCodeGroupVO selCommonCodeGroupOne(String cmcdGroup) {
		// TODO Auto-generated method stub
		return mapper.selCommonCodeGroupOne(cmcdGroup);
	}

	@Override
	public List<CommonCodeVO> selCodeList(String cmcdGroup) {
		// TODO Auto-generated method stub
		return mapper.selCodeList(cmcdGroup);
	}

	@Override
	public List<CommonCodeVO> selCodeListAll() {
		// TODO Auto-generated method stub
		return mapper.selCodeListAll();
	}
	
}
