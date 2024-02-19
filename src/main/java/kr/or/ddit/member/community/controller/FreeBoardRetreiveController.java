package kr.or.ddit.member.community.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityCommentVO;
import kr.or.ddit.member.community.vo.CommunityTagVO;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/freeboard")
public class FreeBoardRetreiveController {

	@Inject
	private IFreeService ifreeService;

	@GetMapping(value = "/list.do")
	public String freeBoardList(HttpServletRequest req, RedirectAttributes ra, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "comntPstTtl") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		
		
		


		PaginationInfoVO<CommunityVO> pagingVO = new PaginationInfoVO<CommunityVO>();

		// 검색을 진행
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);

			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);
		int totalRecord = ifreeService.selectFreeBoardCount(pagingVO);

		pagingVO.setTotalRecord(totalRecord);
		List<CommunityVO> dataList = ifreeService.selectFreeBoardList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		return "member/community/freelist";
	}

	

	@GetMapping("/detail.do")
	public String freeboardDetail(@RequestParam(name = "comntPstNo", required = false) Integer comntPstNo,
			Model model) {

		if (comntPstNo == null) {
			// comntPstNo가 null인 경우에 수행할 코드
		} else {
			try {
				CommunityVO communityVO = ifreeService.selectFreeBoard(comntPstNo);
				List<CommunityCommentVO> comments = ifreeService.selectFreeBoardCommentList(comntPstNo);
				List<CommunityTagVO> tagList = ifreeService.selectFreeBoardTagList(comntPstNo);
				model.addAttribute("freeboard", communityVO);
				model.addAttribute("freeboardComments", comments);
				model.addAttribute("tagList", tagList);
				log.info("fileList : " + communityVO.getCommunityFileList());
				log.info("communityVO 실행 :" + communityVO);
			} catch (Exception e) {
				log.error("howdoudo.", e);
				return "errorPage";
			}

		}
		return "member/community/freedetail";
	}
	
	
	
}
