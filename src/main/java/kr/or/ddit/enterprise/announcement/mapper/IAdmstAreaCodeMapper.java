package kr.or.ddit.enterprise.announcement.mapper;

import java.util.List;

import kr.or.ddit.vo.AdmstAreaCodeVO;

public interface IAdmstAreaCodeMapper {

	public List<AdmstAreaCodeVO> selCodeList();
	public List<AdmstAreaCodeVO> selCodeListAll();
	public List<AdmstAreaCodeVO> selCountyList(AdmstAreaCodeVO admstAreaCodeVO);

}
