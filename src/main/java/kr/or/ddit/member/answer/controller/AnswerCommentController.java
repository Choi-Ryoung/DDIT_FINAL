package kr.or.ddit.member.answer.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.answer.service.IAnswerService;
import kr.or.ddit.member.answer.vo.AnswerCommentVO;

@Controller
@RequestMapping("/answer")
public class AnswerCommentController {

	@Inject
	private IAnswerService answerService;
	
	// 댓글 추가
	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	public String addComment(AnswerCommentVO commentVO, RedirectAttributes ra) {
		// #################################### 필수!!!!!!!!!
		// 임시로 작성자는 a001로 하드코딩
		// 추후에 로그인 한 사용자 아이디로 대체
		// #################################### 필수!!!!!!!!!
		commentVO.setAnsCmtnWrtrId("a001"); 

		int res = answerService.addComment(commentVO);
		if(res > 0) {	// 댓글 등록 성공
			ra.addFlashAttribute("message", "댓글 등록 완료!");
		}else {	// 댓글 등록 실패
			ra.addFlashAttribute("message", "서버에서, 댓글 등록 실패!");
		}

		return "redirect:/answer/detail.do?ansNo=" + commentVO.getAnsNo();
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(int ansCmtnNo, int ansNo, RedirectAttributes ra) {
		int status = answerService.deleteComment(ansCmtnNo);
		if(status > 0) {
			ra.addFlashAttribute("message", "댓글 삭제 완료!");
		}else{
			ra.addFlashAttribute("message", "서버에러, 댓글 삭제 실패!");
		}
		return "redirect:/answer/detail.do?ansNo=" + ansNo;
	}
	
	// 댓글 수정
	@PostMapping("/modifyComment")
	public String modifyComment(AnswerCommentVO commVO, RedirectAttributes ra) {
	    int status = answerService.modifyComment(commVO); // modifyComment 메서드는 댓글을 수정하는 메서드로 가정합니다.
	    if(status > 0) {
	    	ra.addFlashAttribute("message", "댓글 수정 완료!");
	    }else {
	    	ra.addFlashAttribute("message", "서버에러, 댓글 수정 실패!");
	    }
	    return "redirect:/answer/detail.do?ansNo=" + commVO.getAnsNo();
	}
	
}
