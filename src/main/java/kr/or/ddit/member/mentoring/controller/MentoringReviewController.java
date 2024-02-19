package kr.or.ddit.member.mentoring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.service.ReviewService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
@RequestMapping("/mento")
public class MentoringReviewController {

	@Inject
	private MentoService mentoService;
	
	@Inject
	private ReviewService reviewService;
	
	
	@RequestMapping(value = "/addReview", method = RequestMethod.POST)
	public String addComment(MentoringReviewVO reviewVO, @RequestParam String menNcnm, HttpSession session, RedirectAttributes ra) throws Exception {
	PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
	log.info("memberVO : " + memberVO);
	log.info("menNcnm : " + menNcnm);

	String encodedParam = URLEncoder.encode(menNcnm, "UTF-8");
	
	reviewVO.setPrMbrNcnm(memberVO.getPrMbrNcnm());
	reviewVO.setMenNcnm(menNcnm);
	
	int res = reviewService.addReview(reviewVO);
	if(res > 0) {
		ra.addFlashAttribute("message", "등록 성공");
	} else {
		ra.addFlashAttribute("message", "등록 실패");
	}
	
	return "redirect:/mento/review?menNcnm=" + encodedParam;
	}
	
	@PostMapping("/updateReview")
	public String updateReview(MentoringReviewVO reviewVO, RedirectAttributes ra) throws Exception {
		log.info("reviewVO : " + reviewVO);
		
		String menNcnm = reviewVO.getMenNcnm();
		String encodedParam = URLEncoder.encode(menNcnm, "UTF-8");
		
		log.info("menNcnm : " + menNcnm);
		
		int res = reviewService.updateReview(reviewVO);
		if(res > 0) {
			ra.addFlashAttribute("message", "수정 성공");
		} else {
			ra.addFlashAttribute("message", "수정 실패");
		}
		
		return "redirect:/mento/review?menNcnm=" + encodedParam;
		
	}
	
	// 리뷰 삭제
	@PostMapping("/deleteReview")
	public String deleteReview(MentoringReviewVO reviewVO, RedirectAttributes ra) throws Exception {
		log.info("reviewVO : " + reviewVO);
		
		String menNcnm = reviewVO.getMenNcnm();
		log.info("menNcnm : " + menNcnm);
		
		String encodedParam = URLEncoder.encode(menNcnm, "UTF-8");
		
		int res = reviewService.deleteReview(reviewVO);
		
		if(res > 0) {
			ra.addFlashAttribute("message", "삭제 성공");
		} else {
			ra.addFlashAttribute("message", "삭제 실패");
		}
		
		return "redirect:/mento/review?menNcnm=" + encodedParam;
	}
	
}
