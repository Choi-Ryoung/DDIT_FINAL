package kr.or.ddit.member.notice.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.notice.service.INoticeService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeModifyController {

	@Inject
	private INoticeService noticeService;
	
	@RequestMapping(value="/update.do", method = RequestMethod.GET)
	public String noticeUpdateForm(@RequestParam int ntPstNo, Model model) {
		log.info("ntPstNo" + ntPstNo);
		NoticeVO noticeVO = noticeService.selectNotice(ntPstNo);
		log.info(noticeVO.toString());
		model.addAttribute("notice", noticeVO);
		model.addAttribute("status", "u");	// '수정입니다' flag
		return "member/notice/noticeform";
	}
	
	
	  @RequestMapping(value="/update.do", method = RequestMethod.POST) 
	  public String noticeUpdate( 
			  HttpServletRequest req, NoticeVO noticeVO, Model model, RedirectAttributes ra
			  ) { 
		  String goPage = "";
		  ServiceResult result = noticeService.updateNotice(req, noticeVO);
		  if(result.equals(ServiceResult.OK)) { // 수정 성공
		  
			  goPage = "redirect:/notice/detail.do?ntPstNo="+noticeVO.getNtPstNo();
			  ra.addFlashAttribute("message", "게시글 수정이 완료되었습니다!");
		  }else { // 수정 실패
		  
			  model.addAttribute("notice", noticeVO); 
			  model.addAttribute("message","수정에 실패했습니다!"); 
			  model.addAttribute("status", "u"); 
			  goPage = "member/notice/noticeform"; 
		  }
		  return goPage; 
	  }
	 
	
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	public String noticeDelete(
	        HttpServletRequest req, int ntPstNo, 
	        Model model, RedirectAttributes ra) {
	    String goPage = "";
	    
	    ServiceResult result = noticeService.deleteNotice(req, ntPstNo);
	    if(result.equals(ServiceResult.OK)) {    // 삭제 성공
	        goPage = "redirect:/notice/list.do";
	        ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
	    } else {            // 삭제 실패
	        // 파라미터 이름 올바르게 수정
	    	goPage = "redirect:/notice/detail.do?ntPstNo=" + ntPstNo; 
	        ra.addFlashAttribute("message", "게시글 삭제가 실패했습니다!");
	    }
	    
	    return goPage;
	}
	
	
	
  }












