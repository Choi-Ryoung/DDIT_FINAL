package kr.or.ddit.member.enterpriseinfo.mapper;

import java.util.List;

import kr.or.ddit.vo.CommonCodeGroupVO;
import kr.or.ddit.vo.CommonCodeVO;

public interface ICommonCodeMapper {

	public List<CommonCodeGroupVO> selCommonCodeGroupList();
	public CommonCodeGroupVO selCommonCodeGroupOne(String cmcdGroup);
	public List<CommonCodeVO> selCodeList(String cmcdGroup); 
	public List<CommonCodeVO> selCodeListAll();
	


}
