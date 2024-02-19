package kr.or.ddit.enterprise.briefing.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.employment.service.IBriefingService;
import kr.or.ddit.member.employment.vo.EmploymentBriefingVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/briefing")
public class BriefingController {

	@Inject
	private IBriefingService briefingService;
	
	@RequestMapping(value="/list")
	public String entBriefingList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session) {
		PaginationInfoVO<EmploymentBriefingVO> pagingVO = new PaginationInfoVO<EmploymentBriefingVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		pagingVO.setEntMbrId(entVO.getEntMbrId());
		
		int totalRecord = briefingService.selectEntBriefingCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<EmploymentBriefingVO> dataList = briefingService.selectEntBriefingList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/briefing/briefingList";
	}
	
	@PostMapping("/insert.do")
	public String briefingInsert(EmploymentBriefingVO briefingVO, Model model, HttpServletRequest req) {

		//[HttpSession] 로그인 처리 후 세션 정보에서 얻어 온 회원정보를 가용하기 위한 준비
		HttpSession session = req.getSession();
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");

		briefingVO.setEntMbrId(entVO.getEntMbrId());

		int res = briefingService.insertBriefing(briefingVO);
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/briefing/list";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/briefing/list";
		}
	}
	
	
	
	@PostMapping("/delete.do")
	public String deleteBriefing(HttpServletRequest req, int empmnBrfNo, Model model, RedirectAttributes ra) {
		
		log.debug("체킁:" + empmnBrfNo);
		
		String goPage = "";
		
		ServiceResult result = briefingService.deleteBriefing(req, empmnBrfNo);
		
		if(result.equals(ServiceResult.OK)) {	// 삭제 성공
			goPage = "redirect:/briefing/list";
			ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
		}else {			// 삭제 실패
			goPage = "redirect:/briefing/list";
			ra.addFlashAttribute("message", "게시글 삭제가 실패했습니다!");
		}
		return goPage;
	}
	
	
	@PostMapping("/update.do")
	public String briefingUpdate(EmploymentBriefingVO briefingVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		ServiceResult result = briefingService.updateBriefing(briefingVO);
		
		if(result.equals(ServiceResult.OK)) {	// 수정 성공
			goPage = "redirect:/briefing/list";
			ra.addFlashAttribute("message", "게시글 수정이 완료되었습니다!");
		}else {		// 수정 실패
			model.addAttribute("message", "수정에 실패했습니다!");
			goPage = "redirect:/briefing/list";
		}
		
		return goPage;
	}
	
	
	
	
	
	@RequestMapping("/update")
	@ResponseBody
	public EmploymentBriefingVO briefingUpd(EmploymentBriefingVO employmentBriefingVO) {
		log.info("체잉에에에이엥킁 : " + employmentBriefingVO.getEmpmnBrfNo());
		EmploymentBriefingVO briefingVO = briefingService.selectBriefing(Integer.parseInt(employmentBriefingVO.getEmpmnBrfNo()));
		return briefingVO;
	}
	
	
	
	
}
