package kr.or.ddit.member.faq.service;

import java.util.List;

import kr.or.ddit.member.faq.vo.FaqVO;

public interface IFaqService {

	public List<FaqVO> list();

	public int insert(FaqVO faqVO);

	public int update(FaqVO faqVO);

	public FaqVO detail(int faqPstNo);

	public int delete(int faqPstNo);

}
