package kr.or.ddit.member.enterpriseinfo.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.enterpriseinfo.service.IInterviewReviewService;
import kr.or.ddit.member.enterpriseinfo.vo.InterviewReviewVO;
import kr.or.ddit.vo.CommonCodeGroupVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

@Slf4j
@Controller
@RequestMapping("member/enterpriseinfo")
public class InterviewReviewController{

	@Inject
	private IInterviewReviewService irService;
	@Inject
	private ICommonCodeService iccService;
	
	//------------- 면접후기 메인 화면 --------------// 
	@RequestMapping(value = "/intReviewList")
	public String intReviewList(
			Model model)  
	{
		log.info("intReviewList() Start");
		List<InterviewReviewVO> irList = irService.selIrList();
		
		model.addAttribute("irList",irList);
		
		return "member/enterpriseinfo/intReviewList";
	}
	
	@RequestMapping(value = "/intReviewInsert", method = RequestMethod.GET)
	public String intReviewInsertForm(InterviewReviewVO irVo,Model model)  
	{
		
		log.info("intReviewInsertForm() Start");
		
		List<CommonCodeVO> genderList = iccService.selCodeList("GENDER");
		List<CommonCodeVO> ivLevelList = iccService.selCodeList("IVLEVEL");
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> ivTypeList = iccService.selCodeList("IVTYPE");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> ivCareerList = iccService.selCodeList("IVCAREER");
		List<CommonCodeVO> ivEvalueList = iccService.selCodeList("IVEVALUE");
		List<CommonCodeVO> ivPcntList = iccService.selCodeList("IVPCNT");
		List<CommonCodeVO> ivPassList = iccService.selCodeList("IVPASS");
		
		model.addAttribute("genderList",genderList);
		model.addAttribute("ivLevelList",ivLevelList);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("ivTypeList",ivTypeList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("ivCareerList",ivCareerList);
		model.addAttribute("ivEvalueList",ivEvalueList);
		model.addAttribute("ivPcntList",ivPcntList);
		model.addAttribute("ivPassList",ivPassList);

		log.info("intReviewInsertForm() Start");
		return "member/enterpriseinfo/intReviewInsertForm";
	}
	
	@RequestMapping(value = "/intReviewInsert.do", method = RequestMethod.POST)
	public String intReviewInsert(HttpServletRequest request,InterviewReviewVO irVo,Model model)  
	{
		log.info("intReviewInsert() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		irVo.setPrMbrId(memberVo.getPrMbrId());
		irVo.setIvWrtrNm(memberVo.getPrMbrNm());
		irVo.setPstgYn("N");
		log.info(irVo.toString());
		int res = irService.insert(irVo);
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/member/enterpriseinfo/intReviewList";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/member/enterpriseinfo/intReviewList";
		}
		
	}
	
	@RequestMapping(value = "/intReviewTest", method = RequestMethod.GET)
	public String intReviewTest()  
	{
		log.info("intReviewTest() Start");
		return "member/enterpriseinfo/intReviewTest";
	}
	
}
