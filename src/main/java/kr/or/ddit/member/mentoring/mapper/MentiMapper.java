package kr.or.ddit.member.mentoring.mapper;

import java.util.List;

import kr.or.ddit.member.mentoring.vo.MentiVO;

public interface MentiMapper {

	public List<MentiVO> selectMentiList(String menNcnm);
	public MentiVO selectMenti(String menNcnm);

}
