package kr.or.ddit.member.answer.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.answer.service.IAnswerService;
import kr.or.ddit.member.answer.vo.AnswerVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/answer")
public class AnswerController {

	@Inject
	private IAnswerService answerService;

	@GetMapping(value = "/form.do")
	public String answerInsertForm() {
		return "member/answer/answerform";
	}

	
	
	@PostMapping("/insert.do")
		
	public String answerInsert(AnswerVO answerVO, HttpServletRequest req, Model model, RedirectAttributes ra) throws Exception {
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		log.debug("너머온 값:{}",answerVO);
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		
		if(StringUtils.isBlank(answerVO.getAnsTtl())) {
			errors.put("ttl", "제목을 입력해주세요");
		}
		
		if(StringUtils.isBlank(answerVO.getAnsTtl())) {
			errors.put("cn", "내용을 입력해주세요");
		}
		
		if(errors.size() > 0) {		// 에러가 있음
			model.addAttribute("errors", errors);
			model.addAttribute("answerVO", answerVO);
			goPage = "member/answer/answerform";
		} else {			// 에러 없음
			answerVO.setAnsWrtr(memberVO.getPrMbrNcnm());
			
			answerVO.setAnsFile(answerVO.getAnsFIle());
			log.info("체킁: answerVO {}", answerVO);
			
			
				ServiceResult result = answerService.insertAnswer(req, answerVO);
			
			if(result.equals(ServiceResult.OK)) {
				goPage = "redirect:/answer/detail.do?ansNo=" + answerVO.getAnsNo();
			} else {
				model.addAttribute("message", "서버 에러, 다시 시도해주세요");
				goPage = "member/answer/answerform";
			}
		}
		
		return goPage;
		
	}
}
	