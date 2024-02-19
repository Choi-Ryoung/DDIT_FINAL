package kr.or.ddit.member.mentoring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.mentoring.service.MentiService;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mento")
public class MentiController {

	@Inject
	private ChatService chatService;
	
	@Inject
	private MentiService mentiService;
	
	@GetMapping("/mentilist")
	public String mentiList(HttpSession session, @RequestParam String menNcnm,  Model model) {
		log.info("mentiList() 실행!");
		// 개인회원과 멘토의 세션값 불러오기
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		
		if(memberVO == null) {
			return "redirect:/member/loginform";
		}
		
		// 멘토닉네임 개인회원 닉네임
		Map<String, String> map = new HashMap<String, String>();
		map.put("menNcnm", menNcnm);
		map.put("prMbrNcnm", memberVO.getPrMbrNcnm());
		
		// 멘티 리스트
		List<MentiVO> mentiList = mentiService.selectMentiList(menNcnm);
		// 멘티 정보 확인
		MentiVO mentiVO = mentiService.selectMenti(menNcnm);
		session.setAttribute("mentiInfo", mentiVO);
		ChatRoomVO roomVO = chatService.selectChatRoom(map);
		session.setAttribute("roomVO", roomVO);
		log.info(String.valueOf("roomNO" + roomVO.getRoomNo()));
		
		log.debug("체킁:{}",memberVO);
		log.debug("mentoVO : " + mentoVO);
		log.info("mentiList : " + mentiList);
		log.info("mentiVO : " + mentiVO);
		log.info("roomVO : " + roomVO);
		
		model.addAttribute("mentiVO", mentiVO);
		model.addAttribute("mentiList", mentiList);
		model.addAttribute("roomVO", roomVO);
		return "member/mentoring/mentilist";
	}
	
}
