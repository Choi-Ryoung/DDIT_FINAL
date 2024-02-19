package kr.or.ddit.member.mentoring.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.mentoring.mapper.MentiMapper;
import kr.or.ddit.member.mentoring.service.MentiService;
import kr.or.ddit.member.mentoring.vo.MentiVO;

@Service
public class MentiServiceImpl implements MentiService {

	@Inject
	private MentiMapper mentiMapper;
	
	@Override
	public MentiVO selectMenti(String menNcnm) {
		return mentiMapper.selectMenti(menNcnm);
	}

	@Override
	public List<MentiVO> selectMentiList(String menNcnm) {
		return mentiMapper.selectMentiList(menNcnm);
	}

}
