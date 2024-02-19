package kr.or.ddit.admin.community.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.admin.community.service.AdminFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;
import kr.or.ddit.vo.AdminVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminFreeboard {

	@Inject
	private AdminFreeService adminFreeService;
	
	@RequestMapping(value="/freeboardlist")
	public String entFreeboard(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "comntPsgTtl") String searchType,
			@RequestParam(required = false) String searchWord,
			HttpSession session, Model model) {
		
		PaginationInfoVO<CommunityVO> pagingVO = new PaginationInfoVO<CommunityVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = adminFreeService.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<CommunityVO> dataList = adminFreeService.selectFreeBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/community/freeboardlist";
	}
	
	@GetMapping("/freeboardDetail")
	public String entFreeboardDetail(int comntPstNo, HttpSession session, Model model) {

		try {
			CommunityVO communityVO = adminFreeService.selectFreeBoard(comntPstNo);
			List<CommunityCommentVO> comments = adminFreeService.selectFreeBoardCommentList(comntPstNo);
			List<CommunityTagVO> tagList = adminFreeService.selectFreeBoardTagList(comntPstNo);
			model.addAttribute("freeboard", communityVO);
			model.addAttribute("freeboardComments", comments);
			model.addAttribute("tagList", tagList);
			log.info("fileList : " + communityVO.getCommunityFileList());
			log.info("communityVO 실행 :" + communityVO);
		} catch (Exception e) {
			log.error("howdoudo.", e);
			return "errorPage";
		}

		return "admin/community/freedetail";
		
	}
	
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	public String freeboardDelete(
	        HttpServletRequest req, int comntPstNo, 
	        Model model, RedirectAttributes ra) {
	    String goPage = "";
	    
	    ServiceResult result = adminFreeService.deleteFreeBoard(req, comntPstNo);
	    if(result.equals(ServiceResult.OK)) {    // 삭제 성공
	        goPage = "redirect:/admin/freeboardlist";
	        ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
	    } else {            // 삭제 실패
	        // 파라미터 이름 올바르게 수정
	    	goPage = "redirect:/admin/freeboardDetail?comntPstNo=" + comntPstNo; 
	        ra.addFlashAttribute("message", "게시글 삭제가 실패했습니다!");
	    }
	    
	    return goPage;
	}
	
	// 댓글 삭제
		@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
		public String deleteComment(int comntCmtnNo, int comntPstNo, RedirectAttributes ra) {
			int status = adminFreeService.deleteComment(comntCmtnNo);
			if(status > 0) {
				ra.addFlashAttribute("message", "댓글 삭제 완료!");
			}else{
				ra.addFlashAttribute("message", "서버에러, 댓글 삭제 실패!");
			}
			return "redirect:/admin/freeboardDetail?comntPstNo=" + comntPstNo;
		}
	
}
