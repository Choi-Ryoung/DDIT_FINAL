package kr.or.ddit.admin.manage.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.admin.manage.service.IAdminCodingTestManageService;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping("/admin/manage")
public class AdminCodingTestManageController {

	@Inject
	private IAdminCodingTestManageService adminCodingTestManageService;
	
	@RequestMapping(value = "/codingTestList")
	public String manageCodingTest(
			HttpSession session,
			Model model,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord
		)  
	{
		PaginationInfoVO<PracticeQuestionVO> pagingVO = new PaginationInfoVO<PracticeQuestionVO>(10,5);
		
		// AdminVO adminVO = (AdminVO)session.getAttribute("SessionInfo");
		
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
		
		int totalRecord = adminCodingTestManageService.selectCodingTestCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		List<PracticeQuestionVO> dataList = adminCodingTestManageService.selectCodingTestList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/management/codingManageList";
	}
	
	@RequestMapping(value = "/insertCodingTest", method = RequestMethod.GET)
	public String insertCodingTest(Model model) {
		model.addAttribute("status", "insert");
		return "admin/management/codingTestDet/updateCodingTest";
	}
	
	@RequestMapping(value = "/insertCodingTest.do", method = RequestMethod.POST)
	public String insertCodingTest(Model model, PracticeQuestionVO pqVO) {
		String goPage = "";
		
		int result = adminCodingTestManageService.insertCodingTest(pqVO);
		System.out.println("result : " + result);
		
		if(result > 0) {
			goPage = "redirect:/admin/manage/codingTestList";
		}else {
			model.addAttribute("pqVO", pqVO);
			goPage = "/admin/manage/insertCodingTest";
		}
		
		return goPage;
	}
	
	@RequestMapping(value = "/codingTestManageDetail", method = RequestMethod.GET)
	public String codingTestManageDetail(Model model, int prctQuesNo) {
		PracticeQuestionVO pqVO = adminCodingTestManageService.selectCodingTestDetail(prctQuesNo);
		
		model.addAttribute("pqVO", pqVO);
		model.addAttribute("status", "update");
		
		return "admin/management/codingTestDet/updateCodingTest";
	}
	
	@RequestMapping(value = "/updateCodingTest.do", method = RequestMethod.POST)
	public String updateCodingTest(Model model, PracticeQuestionVO pqVO) {
		String goPage = "";
		
		int status = adminCodingTestManageService.updateCodingTest(pqVO);
		
		if(status > 0) {
			goPage = "redirect:/admin/manage/codingTestList";
		}else {
			model.addAttribute("pqVO", pqVO);
			goPage = "/admin/manage/codingTestManageDetail?prctQuesNo=" + pqVO.getPrctQuesNo();
		}
		
		return goPage;
	}
	
	@RequestMapping(value = "/deleteCodingTest.do", method = RequestMethod.POST)
	public String deleteCodingTest(Model model, int prctQuesNo) {
		String goPage = "";
		
		int status = adminCodingTestManageService.deleteCodingTest(prctQuesNo);
		
		if(status > 0) {
			goPage = "redirect:/admin/manage/codingTestList";
		}else {
			goPage = "/admin/manage/codingTestManageDetail?prctQuesNo=" + prctQuesNo;
		}
		
		return goPage;
	}
	
}
