package kr.or.ddit.member.notice.controller;

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
import kr.or.ddit.member.notice.service.INoticeService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Inject
	private INoticeService noticeService;

	@GetMapping(value = "/form.do")
	public String noticeInsertForm() {
		return "member/notice/noticeform";
	}

	
	
	@PostMapping("/insert.do")
	public String noticeInsert(NoticeVO noticeVO, HttpServletRequest req, Model model, RedirectAttributes ra) throws Exception {
		
		HttpSession session = req.getSession();
		EnterpriseMemberVO memberVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo"); 
		
		if(memberVO == null) {
			System.out.println("세션로그인 정보!!!!!!!" + memberVO);
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
		
		}
		
		log.debug("너머온 값:{}",noticeVO);
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		
		if(StringUtils.isBlank(noticeVO.getNtPstTtl())) {
			errors.put("ttl", "제목을 입력해주세요");
		}
		
		if(StringUtils.isBlank(noticeVO.getNtPstCn())) {
			errors.put("cn", "내용을 입력해주세요");
		}
		
		if(errors.size() > 0) {		// 에러가 있음
			model.addAttribute("errors", errors);
			model.addAttribute("noticeVO", noticeVO);
			goPage = "member/notice/noticeform";
		} else {			// 에러 없음
			noticeVO.setNtWrtrNm(memberVO.getEntNm());
			noticeVO.setNtFile(noticeVO.getNtFile()); 
			log.info("체킁:  noticeVO {}", noticeVO);
			
			
			
			ServiceResult result = noticeService.insertNotice(req, noticeVO);
			
			if(result.equals(ServiceResult.OK)) {
				goPage = "redirect:/notice/detail.do?ntPstNo=" + noticeVO.getNtPstNo();
			} else {
				model.addAttribute("message", "서버 에러, 다시 시도해주세요");
				goPage = "member/notice/noticeform";
			}
		}
		return goPage;
	}
}