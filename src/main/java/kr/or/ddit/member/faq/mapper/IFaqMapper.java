package kr.or.ddit.member.faq.mapper;

import java.util.List;

import kr.or.ddit.member.faq.vo.FaqVO;

public interface IFaqMapper {

	public List<FaqVO> list();

	public int insert(FaqVO faqVO);

	public int update(FaqVO faqVO);

	public FaqVO detail(int faqPstNo);

	public int delete(int faqPstNo);

}
