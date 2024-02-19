package kr.or.ddit.enterprise.main.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.main.service.IMemberMainService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.vo.FaqVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
public class EntMainController {
	
	@Inject
	private IMemberMainService memberMainService;
	
	//------------- 기업 로그인 화면(최룡) --------------// 
	//@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/ent", method = RequestMethod.GET)
	public String EnterpriseMain(Model model)  
	{
		PaginationInfoVO<EmploymentAnnouncementVO> pagingVO = new PaginationInfoVO<EmploymentAnnouncementVO>();
		
		List<EmploymentAnnouncementVO> dataList = memberMainService.selectEmpList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		List<NoticeVO> twoNoticeList = memberMainService.selectTwoNotice();
		model.addAttribute("twoNoticeList", twoNoticeList);
		
		List<FaqVO> twoFaqList = memberMainService.selectTwoFaq();
		model.addAttribute("twoFaqList", twoFaqList);
		
		return "enterprise/entMain";
	}
}
