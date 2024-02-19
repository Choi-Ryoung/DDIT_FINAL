package kr.or.ddit.enterprise.codingTest.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enterprise.codingTest.service.IEntCodingTestService;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SearchVO;

@Controller
@RequestMapping(value = "/ent")
public class EntCodingTestController {
	
	@Inject
	private IEntCodingTestService entCodingTestService;
	
	// 목록
	@RequestMapping(value = "/codingTest", method = RequestMethod.GET)
	private String entCodingTestList(
			HttpSession session,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
		
		PaginationInfoVO<EntPracticeQuestionVO> pagingVO = new PaginationInfoVO<EntPracticeQuestionVO>(10,5);
		
		// 운영에서는 
		EnterpriseMemberVO entMemberVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		SearchVO searchVO = new SearchVO();
		pagingVO.setSearchVO(searchVO);
		searchVO.setEntMbrId(entMemberVO.getEntMbrId());
		
		// ========= 페이징 처리 시작 ========= 
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = entCodingTestService.selectEntCodingTestCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		List<EntPracticeQuestionVO> dataList = entCodingTestService.selectEntCodingTestList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/codingTest/entCodingTestList";
	}
	
	// 상세보기
	@RequestMapping(value = "/selectEntCodingTestDetail", method = RequestMethod.GET)
	public String selectEntCodingTestDetail(Model model, int entPqNo) {
		
		EntPracticeQuestionVO epqVO = entCodingTestService.selectEntCodingTestDetail(entPqNo);
		
		model.addAttribute("status", "update");
		model.addAttribute("epqVO", epqVO);
		
		return "enterprise/codingTest/entCodingTestDet/registerEntCodingTest";
	}
	
	// 등록하러가기
	@RequestMapping(value = "/registerEntCodingTest", method = RequestMethod.GET)
	public String registerEntCodingTest(Model model) {
		model.addAttribute("status", "insert");
		
		return "enterprise/codingTest/entCodingTestDet/registerEntCodingTest";
	}
	
	// 등록하기
	@RequestMapping(value = "/registerEntCodingTest.do", method = RequestMethod.POST)
	public String registerEntCodingTest(Model model, EntPracticeQuestionVO epqVO, HttpSession session) {
		EnterpriseMemberVO entMemberVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		epqVO.setEntMbrId(entMemberVO.getEntMbrId());
		
		entCodingTestService.registerEntCodingTest(epqVO);
		
		return "redirect:/ent/codingTest";
	}
	
	// 수정하기
	@RequestMapping(value = "/updateEntCodingTest.do", method = RequestMethod.POST)
	public String updateEntCodingTest(Model model, EntPracticeQuestionVO epqVO, HttpSession session) {
		EnterpriseMemberVO entMemberVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		epqVO.setEntMbrId(entMemberVO.getEntMbrId());
		
		entCodingTestService.updateEntCodingTest(epqVO);
		
		return "redirect:/ent/codingTest";
	}
	
	// 삭제하기
	@RequestMapping(value = "/deleteEntCodingTest.do", method = RequestMethod.POST)
	public String deleteEntCodingTest(Model model, int entPqNo) {
		
		entCodingTestService.deleteEntCodingTest(entPqNo);
		
		return "redirect:/ent/codingTest";
	}
	
}
