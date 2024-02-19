package kr.or.ddit.enterprise.talentsearch.mapper;

import java.util.List;

import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.enterprise.talentsearch.vo.ResumeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface SearchMapper {

	public int countResume(PaginationInfoVO<ResumeVO> pagingVO);
	public List<ResumeVO> selectResumeList(PaginationInfoVO<ResumeVO> pagingVO);
	public ResumeVO selectResume(int resNo);
	public int insertPrpsl(ProposalVO prps);

}
