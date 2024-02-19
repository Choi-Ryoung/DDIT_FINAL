package kr.or.ddit.member.answer.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.answer.service.IAnswerService;
import kr.or.ddit.member.answer.vo.AnswerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/answer")
public class AnswerModifyController {
	
	@Inject
	private IAnswerService answerService;
	
	@RequestMapping(value = "/update.do",method = RequestMethod.GET)
	public String answerUpdateForm(@RequestParam int ansNo, Model model) {
		
		log.info("ansNo"+ansNo);
		AnswerVO answerVO = answerService.selectAnswer(ansNo);
		log.info(answerVO.toString());
		model.addAttribute("answer",answerVO);
		model.addAttribute("status","u"); //수정입니당당당
		return "member/answer/answerform";
	}
	@RequestMapping(value="/update.do", method = RequestMethod.POST) 
	public String answerUpdate(
			HttpServletRequest req, AnswerVO answerVO, Model model, RedirectAttributes ra
			) {
		String goPage = "";
		ServiceResult result = answerService.updateAnswer(req, answerVO);
		if(result.equals(ServiceResult.OK)) {//수정 성공해쓩
			
			goPage = "redirect:/answer/detail.do?ansNo="+answerVO.getAnsNo();
			ra.addFlashAttribute("message","게시글 수정이 완료되었당 헤헤");
		}else {//수정 실패햇떠
			
			model.addAttribute("answer",answerVO);
			model.addAttribute("message","수정에 실패했구려");
			model.addAttribute("status","u");
			
		}
		return goPage;
	}
	
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	public String answerDelete(
			HttpServletRequest req, int ansNo,
			Model model, RedirectAttributes ra) {
		String goPage = "";
		
		ServiceResult result = answerService.deleteAnswer(req,ansNo);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/answer/list.do";
			ra.addFlashAttribute("message","게시글 삭제가 완료되었습니다!");
		}else {
			
			goPage = "redirect:/answer/detail.do?ansNo=" + ansNo;
			ra.addFlashAttribute("message","게시글 삭제 실패함!");
		}
		return goPage;
	}
	
			
}
