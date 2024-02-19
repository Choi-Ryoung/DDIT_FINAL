package kr.or.ddit.admin.answer.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.admin.answer.service.AdminIAnswerService;
import kr.or.ddit.admin.answer.vo.AnswerCommentVO;
import kr.or.ddit.admin.answer.vo.AnswerVO;
import kr.or.ddit.admin.answer.vo.PaginationInfoVO;
import kr.or.ddit.vo.AdminVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/answer")
public class AdminAnswerRetreiveController {

	@Inject
	private AdminIAnswerService answerService;
	
	@GetMapping(value = "/list.do")
	public String answerList(HttpServletRequest req, RedirectAttributes ra, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "ntPstTtl") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		
		/*
		 * public String someMethod(HttpServletRequest req, Model model) { HttpSession
		 * session = req.getSession(); Object sessionInfo =
		 * session.getAttribute("SessionInfo");
		 * 
		 * if (sessionInfo instanceof AdminVO) { AdminVO adminVO = (AdminVO)
		 * sessionInfo; // 이제 adminVO를 사용할 수 있습니다. // 나머지 로직을 추가하세요. } else if
		 * (sessionInfo instanceof PrivateMemberVO) { PrivateMemberVO privateMemberVO =
		 * (PrivateMemberVO) sessionInfo; // 이제 privateMemberVO를 사용할 수 있습니다. // 나머지 로직을
		 * 추가하세요. } else { // 세션에 저장된 객체가 AdminVO나 PrivateMemberVO가 아닌 경우에 대한 처리 // 예를
		 * 들어 로그인 페이지로 리다이렉트 등 }
		 * 
		 * // 나머지 로직을 추가하세요. return "someView"; }
		 */

		HttpSession session = req.getSession();
		AdminVO sessionMember =  (AdminVO) session.getAttribute("SessionInfo");
		
		if(sessionMember == null) {
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			return"redirect:/admin/login";
		}
		
		PaginationInfoVO<AnswerVO> pagingVO = new PaginationInfoVO<AnswerVO>();
		
		//검색을 진행
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
			
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = answerService.selectAnswerCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<AnswerVO> dataList = answerService.selectAnswerList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/answer/answerlist";
	}
		
	
	@GetMapping("/detail.do")
	public String answerDetail(int ansNo, HttpSession session,
			Model model) {

		AnswerVO answerVO = answerService.selectAnswer(ansNo);
		List<AnswerCommentVO> commentList = answerService.selectCommentList(ansNo);
		
		model.addAttribute("answerVO", answerVO);
		model.addAttribute("commentList", commentList);
		
//		if (ansNo == null) {
//			// comntPstNo가 null인 경우에 수행할 코드
//		} else {
//			try {
//				AnswerVO answerVO = answerService.selectAnswer(ansNo);
//				List<AnswerCommentVO> commentList = answerService.addComment(ansNo);
//				model.addAttribute("answer", answerVO);
//				log.info("fileList : " + answerVO.getAnswerFileList());
//				log.info("answerVO 실행 :" + answerVO);
//			} catch (Exception e) {
//				log.error("howdoudo.", e);
//				return "errorPage";
//			}
//
//		}
		return "admin/answer/answerdetail";
	}
}