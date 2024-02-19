package kr.or.ddit.member.notice.controller;

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

import kr.or.ddit.member.notice.service.INoticeService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.member.notice.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeRetreiveController {

	@Inject
	private INoticeService noticeService;

	@GetMapping(value = "/list.do")
	public String noticeList(HttpServletRequest req, RedirectAttributes ra, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "ntPstTtl") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		HttpSession session = req.getSession();
		PrivateMemberVO sessionMember = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		if(sessionMember == null) {
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			return"redirect:/member/loginform";
		}
		
		
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<NoticeVO>();

		// 검색을 진행
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);

			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);
		int totalRecord = noticeService.selectNoticeCount(pagingVO);

		pagingVO.setTotalRecord(totalRecord);
		List<NoticeVO> dataList = noticeService.selectNoticeList(pagingVO);
		pagingVO.setDataList(dataList);
		

		model.addAttribute("pagingVO", pagingVO);

		return "member/notice/noticelist";
	}

	

	@GetMapping("/detail.do")
	public String noticeDetail(@RequestParam(name = "ntPstNo", required = false) Integer ntPstNo,
			Model model) {

		if (ntPstNo == null) {
			
		} else {
			try {
				NoticeVO noticeVO = noticeService.selectNotice(ntPstNo);
				model.addAttribute("notice", noticeVO);
				log.info("fileList : " + noticeVO.getNoticeFileList());
				log.info("noticeVO 실행 :" + noticeVO);
			} catch (Exception e) {
				log.error("howdoudo.", e);
				return "errorPage";
			}

		}
		return "member/notice/noticedetail";
	}

	
}
