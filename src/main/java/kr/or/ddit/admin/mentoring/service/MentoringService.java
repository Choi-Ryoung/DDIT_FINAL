package kr.or.ddit.admin.mentoring.service;

import java.util.List;

import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;

public interface MentoringService {

	public List<MentoringProfileVO> selMtList(PaginationInfoVO<MentoringProfileVO> pagingVO);

	public int selMentoCount(PaginationInfoVO<MentoringProfileVO> pagingVO);
	public MentoringProfileVO selectMento(String menNcnm);
	public int updateProcCd(MentoringProfileVO mentoVo);
	public String insertRjctRsn(MentoringProfileVO mentoVo);

}
