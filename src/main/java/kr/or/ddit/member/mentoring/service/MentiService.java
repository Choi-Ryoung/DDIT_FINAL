package kr.or.ddit.member.mentoring.service;

import java.util.List;

import kr.or.ddit.member.mentoring.vo.MentiVO;

public interface MentiService {

	public List<MentiVO> selectMentiList(String menNcnm);
	public MentiVO selectMenti(String menNcnm);

}
