package kr.or.ddit.member.answer.controller;

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

import kr.or.ddit.member.answer.service.IAnswerService;
import kr.or.ddit.member.answer.vo.AnswerVO;
import kr.or.ddit.member.answer.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/answer")
public class AnswerRetreiveController {

	@Inject
	private IAnswerService answerService;
	
	@GetMapping(value = "/list.do")
	public String answerList(HttpServletRequest req, RedirectAttributes ra, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "ntPstTtl") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		HttpSession session = req.getSession();
		PrivateMemberVO sessionMember = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		if(sessionMember == null) {
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			return"redirect:/member/loginform";
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
		
		return "member/answer/answerlist";
	}
		
	
	@GetMapping("/detail.do")
	public String answerDetail(@RequestParam(name = "ansNo", required = false) Integer ansNo,
			Model model) {

		if (ansNo == null) {
			// comntPstNo가 null인 경우에 수행할 코드
		} else {
			try {
				AnswerVO answerVO = answerService.selectAnswer(ansNo);
				model.addAttribute("answer", answerVO);
				log.info("fileList : " + answerVO.getAnswerFileList());
				log.info("answerVO 실행 :" + answerVO);
			} catch (Exception e) {
				log.error("howdoudo.", e);
				return "errorPage";
			}

		}
		return "member/answer/answerdetail";
	}
}