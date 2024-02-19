package kr.or.ddit.member.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.employment.service.IEmpService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.main.service.IMemberMainService;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.FaqVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import kr.or.ddit.vo.QuestionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberMainController {

	@Inject
	private IMemberMainService memberMainService;
	
	//------------- 시작 화면 --------------// 
		@RequestMapping(value = "/sub", method = RequestMethod.GET)
		public String sub()  
		{
			return "sub";
		}
			
		@RequestMapping(value = "/member", method = RequestMethod.GET)
		public String memberMain(Model model)  
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
			
			return "member/main";
		}
		
		@RequestMapping(value = "/", method = RequestMethod.GET)
		public String main(Model model)  
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
			
			return "member/main";
		}
		
		@RequestMapping(value = "resumeChk.do", method = RequestMethod.GET)
		@ResponseBody
		public Map<String,String> resumeChk(HttpServletRequest request,Model model)  
		{
			Map<String,String> resMap= new HashMap<String,String>();
			Map<String,String> pMap= new HashMap<String,String>();
			
			HttpSession session = request.getSession();
			PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
			
			if(memberVo == null)
			{
				resMap.put("session","0");
				resMap.put("result","1");
				return resMap;
			}
			
			pMap.put("prMbrId", memberVo.getPrMbrId());
			int res = memberMainService.resumeChk(pMap);
			
			resMap.put("session", "1");
			resMap.put("result", String.valueOf(res));
			
			
			return resMap;
		}
		
		
}
