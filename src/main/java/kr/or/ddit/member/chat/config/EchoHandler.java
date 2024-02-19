package kr.or.ddit.member.chat.config;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mvel2.sh.command.basic.ShowVars;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.chat.vo.ChatVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class EchoHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Inject
	private ChatService chatService;

	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	// 사용자가 접속 했을 때 호출되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		String year1 = year + "년 ";
		String month = today.getMonth().toString();
		int monthValue = today.getMonthValue();
		int dayOfMonth = today.getDayOfMonth();
		String dayOfMonth1 = today.getDayOfMonth() + "일 ";
		String dayOfWeek = today.getDayOfWeek().toString();
		int dayOfWeekValue = today.getDayOfWeek().getValue();
		
		switch(month) {
		case "JANUARY" :
			month = "1월 ";
			break;
		case "FEBRUARY" :
			month = "2월 ";
			break;
		case "MARCH" :
			month = "3월 ";
			break;
		case "APRIL" :
			month = "4월 ";
			break;
		case "MAY" :
			month = "5월 ";
			break;
		case "JUNE" :
			month = "6월 ";
			break;
		case "JULY" :
			month = "7월 ";
			break;
		case "AUGUST" :
			month = "8월 ";
			break;
		case "SEPTEMBER" :
			month = "9월 ";
			break;
		case "OCTOBER" :
			month = "10월 ";
			break;
		case "NOVEMBER" :
			month = "11월 ";
			break;
		case "DECEMBER" :
			month = "12월 ";
			break;
		}
		
		switch(dayOfWeek) {
		case "MONDAY" :
			dayOfWeek = "월요일";
    		break;
    	case "TUESDAY" :
    		dayOfWeek = "화요일";
    		break;
    	case "WEDNESDAY" :
    		dayOfWeek = "수요일";
    		break;
    	case "THURSDAY" :
    		dayOfWeek = "목요일";
    		break;
    	case "FRIDAY" :
    		dayOfWeek = "금요일";
    		break;
    	case "SATURDAY" :
    		dayOfWeek = "토요일";
    		break;
    	case "SUNDAY" :
    		dayOfWeek = "일요일";
    		break;
		}
		
		String todays = year1 + month + dayOfMonth1 + dayOfWeek;
		
		logger.info("year : " + year);
		logger.info("year1 : " + year1);
		logger.info("month : " + month);
		logger.info("monthValue : " + monthValue);
		logger.info("dayOfMonth : " + dayOfMonth);
		logger.info("dayOfWeek : " + dayOfWeek);
		logger.info("dayOfWeekValue : " + dayOfWeekValue);
		logger.info("현재 날짜 : " + todays);
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttributes().get("SessionInfo");
		log.debug("memberVO : " + memberVO);
		ChatRoomVO roomVO = (ChatRoomVO)session.getAttributes().get("roomVO");
		log.debug("roomVO : " + roomVO);
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttributes().get("mentoInfo");
		log.debug("mentoVO : " + mentoVO);
		
		sessionList.add(session);
		logger.info("{} 연결 됨 : ", session.getId());
		session.sendMessage(new TextMessage("<div style='text-align:center;'>" + todays + "</div><br>"));
//		for (WebSocketSession sess : sessionList) {
//			if(!session.getId().equals(sess.getId())) {
//				sess.sendMessage(new TextMessage("<div style='text-align:center;'>" + memberVO.getPrMbrNcnm() + "님이 입장하셨습니다</div><br>"));
//			} else {
//				sess.sendMessage(new TextMessage("<div style='text-align:center;'>" + memberVO.getPrMbrNcnm() + "님이 입장하셨습니다</div><br>"));
//			}
//		}
		
	}

	// 사용자가 메세지를 보냈을 때 호출되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		LocalTime time = LocalTime.now();
		logger.info("time : " + time);
		int hour = time.getHour();
		int minute = time.getMinute();
		int second = time.getSecond();
		String apm = "";
		
		logger.info("minute : " + minute);
		
		if(hour > 12) {
    		apm = "오후 " + (hour - 12) + ":" + minute;
    	} else {
    		apm = "오전" + hour + ":" + minute;
    	}
		
		logger.info("apm : " + apm);
		
		logger.info("{}로부터 {} 받음", session.getId(), message.getPayload());
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttributes().get("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttributes().get("mentoInfo");
		ChatRoomVO roomVO = (ChatRoomVO)session.getAttributes().get("roomVO");
		
		log.debug("memberVO : " + memberVO);
		log.debug("mentoVO : " + mentoVO);
		log.debug("roomVO : " + roomVO);
		
		
		String sender = memberVO.getPrMbrNcnm();
		
		ChatVO chat = new ChatVO();
		chat.setRoomNo(roomVO.getRoomNo());
		chat.setPrMbrId(memberVO.getPrMbrId());
		chat.setMsg(message.getPayload());
		chat.setPrMbrNcnm(sender);
		
		log.info("방번호 : " + chat.getRoomNo());
		log.info("아이디 : " + chat.getPrMbrId());
		log.info("메세지 : " + chat.getMsg());
		log.info("닉네임 : " + chat.getPrMbrNcnm());
		
		int cnt = chatService.chat(chat);
		
	    
		
		
		 // 메시지 전송
		if(cnt > 0) {
	    for (WebSocketSession sess : sessionList) {
	        String formattedMessage;
	        int roomNo = roomVO.getRoomNo();
	        log.info("roomNo : " + roomNo);
	        if(chat.getRoomNo() == roomNo) {
		        if (!session.getId().equals(sess.getId())) {
		            // 상대방에게 받은 메시지는 왼쪽 정렬
		            formattedMessage = "<div style='text-align:left;'>" + sender + "<br>" + "<div class='message-box'>" + message.getPayload() +  "</div></div>";
		        } else {
		            // 자신이 보낸 메시지는 오른쪽 정렬
		            formattedMessage = "<div style='text-align:right;'><div class='message-box'>" + message.getPayload() + "<div></div>";
		        }
	        
	        // 메시지 전송
	        sess.sendMessage(new TextMessage(formattedMessage));
	        
	        
	    	}
	    
		}
	    
		}
//		for (WebSocketSession sess : sessionList) {
//			System.out.println("msg : " + message.getPayload());
//			if(!session.getId().equals(sess.getId())) {
//				sess.sendMessage(new TextMessage(sender + "<br>" + message.getPayload()));
//			} else {
//				sess.sendMessage(new TextMessage(message.getPayload()));
//			}
//		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
	    // 세션이 이미 닫혔는지 확인
//	    if (session.isOpen()) {
//	        logger.info("{} 연결 끊김 : ", session.getId());
//	        
//
//	        // 퇴장 메시지를 보낼 내용
//	        String exitMessage = session.getId() + "님이 퇴장하셨습니다<br>";
//
//	        // 나머지 세션에게 퇴장 메시지를 보냄
//	        for (WebSocketSession sess : sessionList) {
//	            // 닫힌 세션에게는 메시지를 보내지 않도록 수정
//	            if (sess.isOpen()) {
//	                sess.sendMessage(new TextMessage(exitMessage));
//	            }
//	            sessionList.remove(session);
//	        }
//	    }
	}

}
