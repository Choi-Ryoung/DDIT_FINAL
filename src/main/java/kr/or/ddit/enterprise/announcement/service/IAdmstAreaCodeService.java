package kr.or.ddit.enterprise.announcement.service;

import java.util.List;

import kr.or.ddit.vo.AdmstAreaCodeVO;

public interface IAdmstAreaCodeService {

	public List<AdmstAreaCodeVO> selCodeListAll();
	public List<AdmstAreaCodeVO> selCodeList();
	public List<AdmstAreaCodeVO> selCountyList(AdmstAreaCodeVO admstAreaCodeVO);

}
