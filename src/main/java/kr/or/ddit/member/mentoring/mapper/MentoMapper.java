package kr.or.ddit.member.mentoring.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringFileVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;
import kr.or.ddit.member.mentoring.vo.MentoringTagVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;

public interface MentoMapper {

	public int selectMentoCount(PaginationInfoVO<MentoringProfileVO> pagingVO);
	public List<MentoringProfileVO> selectMentoList(PaginationInfoVO<MentoringProfileVO> pagingVO);
	public MentoringProfileVO selectMento(String menNcnm);
	public int insertMento(MentoringProfileVO mentoVO);
	public MentoringProfileVO idCheck(String menNcnm);
	public void insertTag(MentoringTagVO tagVO);
	public int updateMento(MentoringProfileVO mentoVO);
	public void deleteTag(String menNcnm);
	public int deleteMento(String menNcnm);
	public void insertMentoFile(MentoringFileVO mentoFileVO);
	public void deleteMentoFileList(String[] delmenNcnm);
	public void deleteMentoFile(String menNcnm);
	public MentiVO selMt(Map<String, String> map);
	public List<MentoringReviewVO> selectReviewList(String menNcnm);
	public MentiVO selectMenti(Map<String, Object> map);

}
