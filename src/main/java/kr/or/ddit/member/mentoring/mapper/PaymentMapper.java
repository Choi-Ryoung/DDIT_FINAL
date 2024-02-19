package kr.or.ddit.member.mentoring.mapper;

import java.util.List;

import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.SettlementDescriptionVO;

public interface PaymentMapper {

	public int getPayment(SettlementDescriptionVO sVo);
	public SettlementDescriptionVO getPaymentDetail(int settlementNo);
	public List<SettlementDescriptionVO> getPaymentList();
	public void insertMenti(MentiVO mVo);
	public void insertChatRoom(ChatRoomVO croom);

}
