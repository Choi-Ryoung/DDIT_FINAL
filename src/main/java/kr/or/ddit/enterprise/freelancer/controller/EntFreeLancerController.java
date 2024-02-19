package kr.or.ddit.enterprise.freelancer.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enterprise.freelancer.service.IEntFreeLancerService;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewQuestionVO;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewVO;
import kr.or.ddit.member.freelancer.vo.ProjectBoardVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("enterprise/freelancer")
public class EntFreeLancerController {
	
	@Inject
	private IEntFreeLancerService flService;
	@Inject
	private ICommonCodeService iccService;
	
	@RequestMapping(value = "/flList")
	public String flList(Model model)  
	{
		log.info("freeLancerList() Start");
		PaginationInfoVO<ProjectBoardVO> pagingVO = new PaginationInfoVO<ProjectBoardVO>();
		
		return "member/entinfo/intReviewList";
	}
	
	@RequestMapping(value = "/pjInsert", method = RequestMethod.GET)
	public String pjInsertForm(Model model)  
	{
		log.info("pjInsertForm() Start");
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);

		return "enterprise/freelancer/pjInsertForm";
	}
	
	@RequestMapping(value = "/pjInsert.do", method = RequestMethod.POST)
	public String pjInsert(ProjectBoardVO pjVo, Model model)  
	{
		log.info("pjInsert() Start");
		log.info("vo : " + pjVo.toString());
		pjVo.setEntMbrId("ent01");
		
		Calendar calendar = Calendar.getInstance();
		Date currentDate = calendar.getTime();
		pjVo.setPstWrtDt(currentDate);
		
	    calendar.setTime(pjVo.getPstWrtDt());
	    calendar.add(Calendar.DAY_OF_MONTH, 7);
		
		pjVo.setPstEndDt(calendar.getTime());
		pjVo.setPstgYn("Y");
		
		log.info("vo : " + pjVo.toString());
		
		int res = flService.insert(pjVo);
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/enterprise/freelancer/pjInsertForm";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/enterprise/freelancer/pjInsertForm";
		}
	}
	

}
