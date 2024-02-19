package kr.or.ddit.member.chat.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.chat.vo.ChatVO;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mento")
@Controller
public class ChatController {

	@Inject
	private ChatService chatService;
	
	@GetMapping("/chat")
	public String chatForm(@RequestParam("roomNo") int roomNo, Model model, HttpSession session) {
		String goPage = "";
		//세션에서 로그인정보 가져오기
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		MentiVO mentiVO = (MentiVO) session.getAttribute("mentiInfo");
		ChatRoomVO roomVO = (ChatRoomVO) session.getAttribute("roomVO");
		log.info("memberVO : " + memberVO);
		log.info("mentoVO : " + mentoVO);
		log.info("mentiVO : " + mentiVO);
		log.info("roomNo : " + roomVO);
		log.info("roomNo : " + roomNo);
		
		if(memberVO.getPrMbrNcnm().equals(roomVO.getPrMbrNcnm()) || memberVO.getPrMbrNcnm().equals(roomVO.getMenNcnm())) {
			if(roomVO != null) {
				// 채팅 기록이 담겨있는 리스트
				List<ChatVO> chatList = chatService.chatLog(roomNo);
				log.info("chatList : " + chatList);
				model.addAttribute("roomNo", roomNo);
				model.addAttribute("chatList", chatList);
				goPage = "chat/chat";
			} 
		} else {
			goPage = "redirect:/mento/list";
		}
		return goPage;
		
		
		
		//ChatRoomVO chatRoomVO = ;
		
		// 로그인 정보에서 멘토나 멘티 정보 같은지 확인
		
		//같으면 체팅방으로
		//다르면 홈페이지로
		
		//List<ChatVO> chatList = chatService.chatLog(roomNo);
		//model.addAttribute("chatList", chatList);
		
		
		
	}
	
	@GetMapping("/chatlist")
	public String mentoChatList(HttpSession session, Model model) {
		log.info("mentoChatList() 실행!");
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		
		
		
		List<ChatRoomVO> chatRoomList = chatService.selectChatList();
		model.addAttribute("chatRoomList", chatRoomList);
		return "chat/chatlist";
	}
	
}
