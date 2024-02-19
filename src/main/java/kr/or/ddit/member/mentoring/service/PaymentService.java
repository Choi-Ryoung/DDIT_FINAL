package kr.or.ddit.member.mentoring.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.member.mentoring.vo.SettlementDescriptionVO;

public interface PaymentService {

	public int getPayment(SettlementDescriptionVO sVo);
	public SettlementDescriptionVO getPaymentDetail(int settlementNo);
	public List<SettlementDescriptionVO> getPaymentList();
	
	
	
}
