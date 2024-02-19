package kr.or.ddit.member.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.member.mypage.service.IMypageService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import kr.or.ddit.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("member/mypage")
public class ProposalController {

	@Inject
	private IMypageService mpService;
	
	@RequestMapping(value="/selectPrpsList")
	public String prpsList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "job") String searchType,
			@RequestParam(required = false) String searchWord,
			HttpSession session,
			Model model
			) {
			PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
			System.out.println(memberVO.getPrMbrId());
			
		PaginationInfoVO<ProposalVO> pagingVO = new PaginationInfoVO<ProposalVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
		}
		
		SearchVO searchVO = new SearchVO();
		
		searchVO.setPrMbrId(memberVO.getPrMbrId());
		pagingVO.setSearchVO(searchVO);
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = mpService.countProposal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ProposalVO> dataList = mpService.selectProposalList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("pagingVO", pagingVO);
		
		return "member/mypage/prpslist";
	}
	
	@ResponseBody
	@PostMapping("/selectPrpsList")
	public ResponseEntity<Map<String, String>> selectPrpsList(@RequestParam int prpslNo) {
		
		System.out.println("이직제안 정보ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ");
		ProposalVO proposal = mpService.selectPrpsList(prpslNo);
		
		if(proposal == null) {
			 return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	    Map<String, String> responseData = new HashMap<>();
	    responseData.put("prpslTtl", proposal.getPrpslTtl());
	    responseData.put("prpslCn", proposal.getPrpslCn());
	    
	    return new ResponseEntity<>(responseData, HttpStatus.OK);
		
	}
	
	
}
