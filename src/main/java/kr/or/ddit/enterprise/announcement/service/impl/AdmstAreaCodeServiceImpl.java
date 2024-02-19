package kr.or.ddit.enterprise.announcement.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.announcement.mapper.IAdmstAreaCodeMapper;
import kr.or.ddit.enterprise.announcement.service.IAdmstAreaCodeService;
import kr.or.ddit.vo.AdmstAreaCodeVO;

@Service
public class AdmstAreaCodeServiceImpl implements IAdmstAreaCodeService {

	@Inject
	private IAdmstAreaCodeMapper mapper;
	
	@Override
	public List<AdmstAreaCodeVO> selCodeList() {
		return mapper.selCodeList();
	}

	@Override
	public List<AdmstAreaCodeVO> selCodeListAll() {
		return mapper.selCodeListAll();
	}

	@Override
	public List<AdmstAreaCodeVO> selCountyList(AdmstAreaCodeVO admstAreaCodeVO) {
		return mapper.selCountyList(admstAreaCodeVO);
	}

}
