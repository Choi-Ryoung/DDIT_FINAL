package kr.or.ddit.admin.mentoring.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mentoring.mapper.MentoringMapper;
import kr.or.ddit.admin.mentoring.service.MentoringService;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;

@Service
public class MentoringServiceImpl implements MentoringService {

	@Inject
	private MentoringMapper mentoringMapper;
	
	@Override
	public List<MentoringProfileVO> selMtList(PaginationInfoVO<MentoringProfileVO> pagingVO) {
		return mentoringMapper.selMtList(pagingVO);
	}

	@Override
	public int selMentoCount(PaginationInfoVO<MentoringProfileVO> pagingVO) {
		return mentoringMapper.selMentoCount(pagingVO);
	}

	@Override
	public MentoringProfileVO selectMento(String menNcnm) {
		return mentoringMapper.selectMento(menNcnm);
	}

	@Override
	public int updateProcCd(MentoringProfileVO mentoVo) {
		return mentoringMapper.updateProcCd(mentoVo);
	}

	@Override
	public String insertRjctRsn(MentoringProfileVO mentoVo) {
		return mentoringMapper.insertRjctRsn(mentoVo);
	}


}
