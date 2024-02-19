package kr.or.ddit.member.faq.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.faq.mapper.IFaqMapper;
import kr.or.ddit.member.faq.service.IFaqService;
import kr.or.ddit.member.faq.vo.FaqVO;

@Service
public class FaqServiceImpl implements IFaqService {
	@Inject
	private IFaqMapper mapper;

	@Override
	public List<FaqVO> list() {
		return mapper.list();
	}

	@Override
	public int insert(FaqVO faqVO) {
		return mapper.insert(faqVO);
	}

	@Override
	public int update(FaqVO faqVO) {
		return mapper.update(faqVO);
	}

	@Override
	public FaqVO detail(int faqPstNo) {
		return mapper.detail(faqPstNo);
	}

	@Override
	public int delete(int faqPstNo) {
		return mapper.delete(faqPstNo);
	}

}
