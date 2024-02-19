package kr.or.ddit.admin.answer.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.maven.doxia.logging.Log;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.admin.answer.service.AdminIAnswerService;
import kr.or.ddit.admin.answer.vo.AnswerCommentVO;
import kr.or.ddit.vo.AdminVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/answer")
public class AdminAnswerCommentController {

    @Inject
    private AdminIAnswerService answerService;
    
 // 댓글 추가
 	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
 	public String addComment(AnswerCommentVO commentVO, HttpSession session, RedirectAttributes ra) {
 		// #################################### 필수!!!!!!!!!
 		// 임시로 작성자는 a001로 하드코딩
 		// 추후에 로그인 한 사용자 아이디로 대체
 		// #################################### 필수!!!!!!!!!
 		AdminVO adminVO = (AdminVO)session.getAttribute("SessionInfo");
 		log.info("adminVO : " + adminVO);
 		commentVO.setAnsCmtnWrtrId(adminVO.getAdminId()); 

 		int res = answerService.addComment(commentVO);
 		if(res > 0) {	// 댓글 등록 성공
 			ra.addFlashAttribute("message", "댓글 등록 완료!");
 		}else {	// 댓글 등록 실패
 			ra.addFlashAttribute("message", "서버에서, 댓글 등록 실패!");
 		}

 		return "redirect:/admin/answer/detail.do?ansNo=" + commentVO.getAnsNo();
 	}
    

 	// 댓글 삭제
 	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
 	public String deleteComment(AnswerCommentVO commentVO, RedirectAttributes ra) {
 		int status = answerService.deleteComment(commentVO);
 		if(status > 0) {
 			ra.addFlashAttribute("message", "댓글 삭제 완료!");
 		}else{
 			ra.addFlashAttribute("message", "서버에러, 댓글 삭제 실패!");
 		}
 		return "redirect:/answer/detail.do?ansNo=" + commentVO.getAnsNo();
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
 	    return "redirect:/admin/answer/detail.do?ansNo=" + commVO.getAnsNo();
 	}
    
}
