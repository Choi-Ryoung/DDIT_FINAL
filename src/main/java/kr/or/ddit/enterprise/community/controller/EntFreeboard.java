package kr.or.ddit.enterprise.community.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enterprise.community.service.EntFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.member.community.vo.PaginationInfoVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/ent")
@Controller
public class EntFreeboard {

	@Inject
	private EntFreeService entFreeService;
	
	@RequestMapping(value="/freeboardlist")
	
	
	public String entFreeboard(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "comntPsgTtl") String searchType,
			@RequestParam(required = false) String searchWord,
			HttpSession session, Model model) {
		EnterpriseMemberVO memberVO = (EnterpriseMemberVO)session.getAttribute("SessionInfo");
		log.info("memberVO : " + memberVO);
		
		if(memberVO.equals(null)) {
			return "redirect:/loginform";
		}
		
		PaginationInfoVO<CommunityVO> pagingVO = new PaginationInfoVO<CommunityVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = entFreeService.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<CommunityVO> dataList = entFreeService.selectFreeBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/community/freeboardlist";
	}
	
	@GetMapping("/freeboardDetail")
	public String entFreeboardDetail(int comntPstNo, HttpSession session, Model model) {

		try {
			CommunityVO communityVO = entFreeService.selectFreeBoard(comntPstNo);
			List<CommunityCommentVO> comments = entFreeService.selectFreeBoardCommentList(comntPstNo);
			List<CommunityTagVO> tagList = entFreeService.selectFreeBoardTagList(comntPstNo);
			model.addAttribute("freeboard", communityVO);
			model.addAttribute("freeboardComments", comments);
			model.addAttribute("tagList", tagList);
			log.info("fileList : " + communityVO.getCommunityFileList());
			log.info("communityVO 실행 :" + communityVO);
		} catch (Exception e) {
			log.error("howdoudo.", e);
			return "errorPage";
		}

		return "enterprise/community/freedetail";
		
	}
	
}
