package kr.or.ddit.member.mentoring.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.mentoring.mapper.MentiMapper;
import kr.or.ddit.member.mentoring.mapper.PaymentMapper;
import kr.or.ddit.member.mentoring.service.PaymentService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.SettlementDescriptionVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentServiceImpl implements PaymentService {

	@Inject
	private PaymentMapper payMapper;
	
	@Override
	public int getPayment(SettlementDescriptionVO sVo) {
		

		int res = payMapper.getPayment(sVo);
		
		MentiVO mVo = new MentiVO();
		mVo.setMenNcnm(sVo.getMenNcnm());
		mVo.setPrMbrId(sVo.getPrMbrId());
		mVo.setPrMbrNcnm(sVo.getPrMbrNcnm());
		mVo.setMentiYn("Y");
		payMapper.insertMenti(mVo);
		ChatRoomVO croom = new ChatRoomVO();
		croom.setMenNcnm(sVo.getMenNcnm());
		croom.setPrMbrNcnm(sVo.getPrMbrNcnm());
		payMapper.insertChatRoom(croom);
		
		
		
		return res;
		
	}

	@Override
	public SettlementDescriptionVO getPaymentDetail(int settlementNo) {
//		select 멘토닉네임 from 결제 where  = 결제번호
//		닉네임 세팅
		
				
//		payMapper.insertMenti(settlementNo);
		return payMapper.getPaymentDetail(settlementNo);
	}

	@Override
	public List<SettlementDescriptionVO> getPaymentList() {
		return payMapper.getPaymentList();
	}

	
}
