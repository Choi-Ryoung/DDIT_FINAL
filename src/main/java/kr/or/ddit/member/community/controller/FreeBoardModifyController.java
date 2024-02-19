package kr.or.ddit.member.community.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/freeboard")
public class FreeBoardModifyController {

	@Inject
	private IFreeService ifreeService;
	
	@RequestMapping(value="/update.do", method = RequestMethod.GET)
	public String freeboardUpdateForm(@RequestParam int comntPstNo, Model model) {
		log.info("comntPstNo" + comntPstNo);
		CommunityVO communityVO = ifreeService.selectFreeBoard(comntPstNo);
		log.info(communityVO.toString());
		model.addAttribute("freeboard", communityVO);
		model.addAttribute("status", "u");	// '수정입니다' flag
		return "member/community/freeform";
	}
	
	
	  @RequestMapping(value="/update.do", method = RequestMethod.POST) 
	  public String freeboardUpdate( 
			  HttpServletRequest req, CommunityVO communityVO, Model model, RedirectAttributes ra
			  ) { 
		  String goPage = "";
		  ServiceResult result = ifreeService.updateFreeBoard(req, communityVO);
		  if(result.equals(ServiceResult.OK)) { // 수정 성공
		  
			  goPage = "redirect:/freeboard/detail.do?comntPstNo="+communityVO.getComntPstNo();
			  ra.addFlashAttribute("message", "게시글 수정이 완료되었습니다!");
		  }else { // 수정 실패
		  
			  model.addAttribute("freeboard", communityVO); 
			  model.addAttribute("message","수정에 실패했습니다!"); 
			  model.addAttribute("status", "u"); 
			  goPage = "member/community/freeform"; 
		  }
		  return goPage; 
	  }
	 
	
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	public String freeboardDelete(
	        HttpServletRequest req, int comntPstNo, 
	        Model model, RedirectAttributes ra) {
	    String goPage = "";
	    
	    ServiceResult result = ifreeService.deleteFreeBoard(req, comntPstNo);
	    if(result.equals(ServiceResult.OK)) {    // 삭제 성공
	        goPage = "redirect:/freeboard/list.do";
	        ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
	    } else {            // 삭제 실패
	        // 파라미터 이름 올바르게 수정
	    	goPage = "redirect:/freeboard/detail.do?comntPstNo=" + comntPstNo; 
	        ra.addFlashAttribute("message", "게시글 삭제가 실패했습니다!");
	    }
	    
	    return goPage;
	}
	
	
	
  }












