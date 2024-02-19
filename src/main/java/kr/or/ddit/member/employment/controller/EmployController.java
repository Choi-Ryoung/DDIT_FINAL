package kr.or.ddit.member.employment.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.service.IBriefingService;
import kr.or.ddit.member.employment.service.IEmpService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.employment.vo.EmploymentBriefingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/employment")
public class EmployController {
	
	@Inject
	private IEmpService empService;
	
	@Inject
	private IBriefingService briefingService;
	
	
	@RequestMapping(value="/list")
	public String empList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		PaginationInfoVO<EmploymentAnnouncementVO> pagingVO = new PaginationInfoVO<EmploymentAnnouncementVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = empService.selectEmpCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<EmploymentAnnouncementVO> dataList = empService.selectEmpList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "member/employment/employmentList";
	}
	
	
	@RequestMapping(value="/detail", method = RequestMethod.GET)
	public String empDetail(int empmnPbancNo, Model model) {
		EmploymentAnnouncementVO empVO = empService.selectEmployment(empmnPbancNo);
		log.info("test" + empVO.toString());
		model.addAttribute("employment", empVO);
		log.info(empVO.getEntMbrId().toString());
		return "member/employment/employmentDetail";
	}

	@RequestMapping(value="/briefingList")
	public String briefingList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model) {
		PaginationInfoVO<EmploymentBriefingVO> pagingVO = new PaginationInfoVO<EmploymentBriefingVO>();
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = briefingService.selectBriefingCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<EmploymentBriefingVO> dataList = briefingService.selectBriefingList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "member/employment/employmentBriefing";
	}
	
	
	
	

}

