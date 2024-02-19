package kr.or.ddit.enterprise.applicant.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enterprise.applicant.service.IEntApplyService;
import kr.or.ddit.enterprise.applicant.vo.EvalueQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.apply.service.impl.MessageService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.login.service.ILoginService;
import kr.or.ddit.member.login.service.impl.LoginServiceImpl;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/entapply")
public class EntApplyControllor {
	
	@Inject
	private IEntApplyService entApplyService;
	
	private MessageService mService = new MessageService();
	
	@RequestMapping(value="/list")
	public String entApplyList(@RequestParam String empmnPbancNo,Model model, HttpSession session) {
		
		EnterpriseMemberVO eVo = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		Map<String,Object> pMap = new HashMap<String,Object>();
		pMap.put("empmnPbancNo", empmnPbancNo);
		List<Map<String,Object>> applyList = entApplyService.selApplyList(pMap);
		
		List<Map<String,String>> evalueList = entApplyService.getEvalueQuestion();
		
		model.addAttribute("empmnPbancNo", empmnPbancNo);
		model.addAttribute("applyList", applyList);
		model.addAttribute("evalueList", evalueList);

		return "enterprise/announcement/applicantManagement";
	}
	
	@PostMapping("/savePassRes.do")
	@ResponseBody
	public String savePassRes(@RequestBody Map<String, String> pMap) {
	    // 여기서 prMbrId를 이용하여 원하는 로직 수행
		/*
		 * Map<String,String> pMap = new HashMap<String, String>(); pMap.put("prMbrId",
		 * prMbrId); pMap.put("resNo", resNo);
		 * 
		 */
		EmploymentAnnouncementVO eaVo = entApplyService.getEmpmnPbancTtl(pMap);
		pMap.put("empmnPbancTtl", eaVo.getEmpmnPbancTtl());
		PrivateMemberVO pmVo = entApplyService.getMemberTelNo(pMap);
		pMap.put("prMbrTelno", pmVo.getPrMbrTelno());
		
		if("evalueDocModal".equals(pMap.get("modalId")))
		{
			int res = entApplyService.setDocPass(pMap);
			mService.sendPassRes(pMap);
		}
		else if("evalueCtModal".equals(pMap.get("modalId")))
		{
			int res = entApplyService.setCtPass(pMap);
			mService.sendPassRes(pMap);
		}
		else if("evalueIvModal".equals(pMap.get("modalId")))
		{
			int res = entApplyService.setIvPass(pMap);
			mService.sendPassRes(pMap);
		}
		
	    // 로직 수행 후 "OK" 응답
	    return "OK";
	}
	
	@PostMapping("/setDocChkY.do")
	@ResponseBody
	public String setDocChkY(@RequestParam Map<String, String> pMap) {
	    // 여기서 prMbrId를 이용하여 원하는 로직 수행
		/*
		 * Map<String,String> pMap = new HashMap<String, String>(); pMap.put("prMbrId",
		 * prMbrId); pMap.put("resNo", resNo);
		 * 
		 */
		int res = entApplyService.setDocChkY(pMap);
		
	    // 로직 수행 후 "OK" 응답
	    return "OK";
	}
	
	@PostMapping("/disQualifyCt.do")
	@ResponseBody
	public String disQualifyCt(@RequestParam Map<String, String> pMap) {
	    // 여기서 prMbrId를 이용하여 원하는 로직 수행
		/*
		 * Map<String,String> pMap = new HashMap<String, String>(); pMap.put("prMbrId",
		 * prMbrId); pMap.put("resNo", resNo);
		 * 
		 */
		int res = entApplyService.disQualifyCt(pMap);
		
	    // 로직 수행 후 "OK" 응답
	    return "OK";
	}
	
	
	@PostMapping("/getCtResult.do")
	@ResponseBody
	public List<EntPracticeQuestionYnVO> getCtResult(@RequestBody Map<String, String> pMap) {
	    // 여기서 empmnPbancNo와 prMbrId를 이용하여 원하는 로직을 수행합니다.
	    // 예를 들어, 서비스를 호출하여 데이터를 가져오거나 처리할 수 있습니다.
	    
	    List<EntPracticeQuestionYnVO> epqyList = entApplyService.getCtResult(pMap);
	    
	    // 로직 수행 후 "OK" 응답
	    return epqyList;
	}
	
	@PostMapping("/getCtQuestionInfo.do")
	@ResponseBody
	public List<EntPracticeQuestionVO> getCtQuestionInfo(@RequestBody Map<String, String> pMap) {
	    // 여기서 prMbrId를 이용하여 원하는 로직 수행
		/*
		 * Map<String,String> pMap = new HashMap<String, String>(); pMap.put("prMbrId",
		 * prMbrId); pMap.put("resNo", resNo);
		 * 
		 */
		List<EntPracticeQuestionVO>  epqList= entApplyService.getCtQuestionInfo(pMap);
		
	    // 로직 수행 후 "OK" 응답
	    return epqList;
	}
	
	/*
	 * @GetMapping("/select")
	 * 
	 * @ResponseBody public List<ApplyVO> entApplySelect(int empmnPbancNo, Model
	 * model) { log.info("empmnPbancNo : " + empmnPbancNo); List<ApplyVO> applyVO =
	 * entApplyService.selectEntApply(empmnPbancNo); return applyVO; }
	 */
	
	@RequestMapping(value = "/entVideoChat", method = RequestMethod.GET)
	public String entVideoChat(/* int empmnPbancNo, */ Model model, HttpSession session) {
		
		EnterpriseMemberVO entMemberVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		String entMbrId = entMemberVO.getEntMbrId();
		
		// model.addAttribute("empmnPbancNo", empmnPbancNo);
		model.addAttribute("entMbrId", entMbrId);
		
		return "chat/entVideoChat";
	}
	
}
