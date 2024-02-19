package kr.or.ddit.member.mentoring.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;

public interface MentoService {
	
	public int selectMentoCount(PaginationInfoVO<MentoringProfileVO> pagingVO);
	public List<MentoringProfileVO> selectMentoList(PaginationInfoVO<MentoringProfileVO> pagingVO);
	public MentoringProfileVO selectMento(String menNcnm);
	public ServiceResult insertMento(HttpServletRequest req, MentoringProfileVO mentoVO) throws Exception;
	public ServiceResult idCheck(String menNcnm);
	public ServiceResult deleteMento(String menNcnm);
	public ServiceResult updateMento(HttpServletRequest req, MentoringProfileVO mentoVO) throws Exception;
	public MentiVO selMt(Map<String, String> map);
	public List<MentoringReviewVO> selectReviewList(String menNcnm);
	public MentiVO selectMenti(Map<String, Object> map);

}
