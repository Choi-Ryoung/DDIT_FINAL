package kr.or.ddit.member.community.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Controller
@RequestMapping("/freeboard")
public class FreeBoardCommentController {

	@Inject
	private IFreeService freeService;
	
	// 댓글 추가
	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	public String addComment(CommunityCommentVO commentVO, HttpSession session, RedirectAttributes ra) {
		// #################################### 필수!!!!!!!!!
		// 임시로 작성자는 a001로 하드코딩
		// 추후에 로그인 한 사용자 아이디로 대체
		// #################################### 필수!!!!!!!!!
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo"); 
		commentVO.setComntCmtnWrtrId(memberVO.getPrMbrNcnm()); 

		int res = freeService.addComment(commentVO);
		if(res > 0) {	// 댓글 등록 성공
			ra.addFlashAttribute("message", "댓글 등록 완료!");
		}else {	// 댓글 등록 실패
			ra.addFlashAttribute("message", "서버에서, 댓글 등록 실패!");
		}

		return "redirect:/freeboard/detail.do?comntPstNo=" + commentVO.getComntPstNo();
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(int comntCmtnNo, int comntPstNo, RedirectAttributes ra) {
		int status = freeService.deleteComment(comntCmtnNo);
		if(status > 0) {
			ra.addFlashAttribute("message", "댓글 삭제 완료!");
		}else{
			ra.addFlashAttribute("message", "서버에러, 댓글 삭제 실패!");
		}
		return "redirect:/freeboard/detail.do?comntPstNo=" + comntPstNo;
	}
	
	// 댓글 수정
	@PostMapping("/modifyComment")
	public String modifyComment(CommunityCommentVO commVO, RedirectAttributes ra) {
	    int status = freeService.modifyComment(commVO); // modifyComment 메서드는 댓글을 수정하는 메서드로 가정합니다.
	    if(status > 0) {
	    	ra.addFlashAttribute("message", "댓글 수정 완료!");
	    }else {
	    	ra.addFlashAttribute("message", "서버에러, 댓글 수정 실패!");
	    }
	    return "redirect:/freeboard/detail.do?comntPstNo=" + commVO.getComntPstNo();
	}
	
}
