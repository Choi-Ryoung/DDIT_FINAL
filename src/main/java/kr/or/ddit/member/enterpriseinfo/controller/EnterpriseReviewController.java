package kr.or.ddit.member.enterpriseinfo.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enterprise.entpage.service.IEntpageService;
import kr.or.ddit.member.enterpriseinfo.service.IEnterpriseReviewService;
import kr.or.ddit.member.enterpriseinfo.service.IInterviewReviewService;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewQuestionVO;
import kr.or.ddit.member.enterpriseinfo.vo.EnterpriseReviewVO;
import kr.or.ddit.member.enterpriseinfo.vo.InterviewReviewVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("member/enterpriseinfo")
public class EnterpriseReviewController {

	@Inject
	private IEnterpriseReviewService erService;
	
	@Inject
	private IEntpageService eService;
	
	
	//------------- 기업정보 메인 화면 --------------// 
	@RequestMapping(value = "/entReviewList", method = RequestMethod.GET)
	public String entReviewList(Model model)  
	{
		log.info("entReviewList() Start");
				
		List<EnterpriseMemberVO> emList = erService.selEmList();
		Map<String,String> pMap = new HashMap<String,String>();
		List<Map<String, String>> rankList = new ArrayList<Map<String,String>>();
		//채용공고 카운트
		List<Map<String, String>> amcList = new ArrayList<Map<String,String>>();
		
		String preEntMbrId = "";
		for (EnterpriseMemberVO enterpriseMemberVO : emList) {
			String entMbrId = enterpriseMemberVO.getEntMbrId();
			if(preEntMbrId.equals(entMbrId))
			{
				continue;
			}
			else
			{
				pMap.put("entMbrId", entMbrId);
				rankList.add(erService.selRankResult(pMap));
				amcList.add(erService.getCntAnnounceMent(pMap));
				preEntMbrId = entMbrId;
			}
			
		}
		
		log.info(emList.toString());
		model.addAttribute("emList",emList);
		model.addAttribute("rankList",rankList);
		model.addAttribute("amcList",amcList);
		
		return "member/enterpriseinfo/entReviewList";
	}
	
	@RequestMapping(value = "/entReviewDetail", method = RequestMethod.GET)
	public String entReviewDetail(String entMbrId, Model model)  
	{
		
		log.info("entReviewDetail() Start"); //질문 리스트
		  List<EnterpriseReviewQuestionVO> quesCnList = erService.selQuesCd(); //옵션리스트
		  
		  List<EnterpriseReviewQuestionVO> quesList = erService.selQuesList();
	
		  EnterpriseMemberVO emVo = eService.getEntAccountAll(entMbrId);
		  
		  List<EnterpriseReviewVO> erDetailList = erService.selErDetail(entMbrId); 
		  
		  List<Double> percentList = new ArrayList<Double>(); List<Integer> cntList = new ArrayList<Integer>();
		  int erDetailCnt = erService.selErDetailCnt(entMbrId); 
		  double parseRes = 0.0; 
		  double res = 0.0;
		  
		  DecimalFormat decimalFormat = new DecimalFormat("#.##");
		  
		  for(int i = 0 ; i < quesList.size(); i++) { Map<String, String> paramMap =
		  new HashMap<>();
		  
		  String columnName = 
		  "sexRatio".equals(quesList.get(i).getQuesCd()) ? "sex_ratio" : 
		  "clothesType".equals(quesList.get(i).getQuesCd()) ? "clothes_type" :
		  "attendanceType".equals(quesList.get(i).getQuesCd()) ? "attendance_type" : 
		  "avgAge".equals(quesList.get(i).getQuesCd()) ? "avg_age" : 
	      "annualType".equals(quesList.get(i).getQuesCd()) ? "annual_type" : 
		  "overtimeCnt".equals(quesList.get(i).getQuesCd()) ? "overtime_cnt" : 
		  "annualUseD".equals(quesList.get(i).getQuesCd()) ? "annual_use_d" : 
		  "salIncPer".equals(quesList.get(i).getQuesCd()) ? "sal_inc_per" : "";
		  
		  
		  paramMap.put("entMbrId", entMbrId);
		  paramMap.put("col", columnName); 
		  paramMap.put("option",quesList.get(i).getOptionCn());
		  cntList.add(erService.selColOptionCnt(paramMap)); res = (double)erService.selColOptionCnt(paramMap) / (double)erDetailCnt * 100.0; parseRes
		  = Double.parseDouble(decimalFormat.format(res)); percentList.add(parseRes);
		  }
		  
		  model.addAttribute("quesCnList",quesCnList);
		  model.addAttribute("quesList",quesList);
		  model.addAttribute("percentList",percentList);
		  model.addAttribute("cntList",cntList);
		  model.addAttribute("erDetailList",erDetailList);
		  model.addAttribute("emVo",emVo);
		  
		return "member/enterpriseinfo/entReviewDetail";
	}
	
	@RequestMapping(value = "/entReviewInsert", method = RequestMethod.GET)
	public String entReviewInsertForm(Model model)  
	{
		List<EnterpriseReviewQuestionVO> quesCnList = erService.selQuesCd();
		List<EnterpriseReviewQuestionVO> quesList = erService.selQuesList();
		
		model.addAttribute("quesCnList",quesCnList);
		model.addAttribute("quesList",quesList);
		
		log.info("list :" + quesList.toString());
		
		return "member/enterpriseinfo/entReviewInsertForm";
	}
	
	@RequestMapping(value = "/entReviewInsert.do", method = RequestMethod.POST)
	public String entReviewInsert(@RequestParam String entNm,HttpServletRequest request,EnterpriseReviewVO erVo, Model model)  
	{
		
		log.info("entReviewInsert() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		erVo.setPrMbrId(memberVo.getPrMbrId());
		erVo.setEntMbrId(erService.selEmConEntMbrId(entNm));
		erVo.setPstgYn("Y");
		log.info("vo : " + erVo.toString());
		int res = erService.insert(erVo);
		
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/member/enterpriseinfo/entReviewList";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/member/enterpriseinfo/entReviewList";
		}
	}
	
	@RequestMapping(value = "/sample", method = RequestMethod.GET)
	public String sample()  
	{
		return "member/enterpriseinfo/sample";
	}
	
	@RequestMapping(value = "/entNmAutoComplete.do")
	public @ResponseBody Map<String, Object> autocomplete(@RequestParam Map<String, Object> paramMap) throws Exception{
		List<Map<String, Object>> resultList = erService.getEntNm(paramMap);
		paramMap.put("resultList", resultList);


		return paramMap;
	}
	
	
}

