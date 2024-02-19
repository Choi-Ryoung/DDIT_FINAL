package kr.or.ddit.enterprise.talentsearch.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enterprise.talentsearch.service.SearchService;
import kr.or.ddit.enterprise.talentsearch.service.impl.MessageService;
import kr.or.ddit.enterprise.talentsearch.vo.ProposalVO;
import kr.or.ddit.enterprise.talentsearch.vo.ResumeVO;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mypage.service.IMypageService;
import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/search")
@Controller
public class SearchController {

	@Inject
	private ICommonCodeService iccService;
	
	@Inject
	private SearchService searchService;
	
	@Inject
	private IMypageService mpService;
	
	private MessageService mService= new MessageService();
	
	@RequestMapping("/searchdutylist")
	public String searchDutyList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "job") String searchType,
			@RequestParam(required = false) String searchWord,
			String dutyCd, String careerYearCd,
			String workCd, String salaryCd,
			HttpSession session,
			Model model
			) {
	
		
//		PaginationInfoVO<ResumeVO> pagingVO = new PaginationInfoVO<ResumeVO>();
//		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
//		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
//		log.info("dutyCd : " + dutyCd);
//		log.info("careerYearCd : " + careerYearCd);
//		if(dutyCd != null || careerYearCd != null) {
//		    String[] dutyArr = dutyCd.split(",");
//		    String[] careerYearArr = careerYearCd.split(",");
//		    
//		    ResumeVO resumeVO = new ResumeVO();
//		    resumeVO.setDutyCdList(dutyArr);
//		    resumeVO.setCareerYearCdList(careerYearArr);
//		    
//		    
//		    pagingVO.setItemVO(resumeVO);
//		    log.info("dutyArr : " + dutyArr[0]);
//		    log.info("careerYearArr : " + careerYearArr[0]);
//		    log.info("resumeVO : " + resumeVO);
//		}
		
		PaginationInfoVO<ResumeVO> pagingVO = new PaginationInfoVO<ResumeVO>();
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> workList = iccService.selCodeList("WORK");
		List<CommonCodeVO> salaryList = iccService.selCodeList("SALARY");
		log.info("dutyCd : " + dutyCd);
		log.info("careerYearCd : " + careerYearCd);
		log.info("workCd : " + workCd);
		log.info("salaryCd : " + salaryCd);

		if (dutyCd != null || careerYearCd != null || workCd != null || salaryCd != null) {
		    ResumeVO resumeVO = new ResumeVO();

		    if (dutyCd != null) {
		        String[] dutyArr = dutyCd.split(",");
		        resumeVO.setDutyCdList(dutyArr);
		        log.info("dutyArr : " + dutyArr[0]);
		    }

		    if (careerYearCd != null) {
		        String[] careerYearArr = careerYearCd.split(",");
		        resumeVO.setCareerYearCdList(careerYearArr);
		        log.info("careerYearArr : " + careerYearArr[0]);
		    }
		    
		    if (workCd != null) {
		    	String[] workArr = workCd.split(",");
		    	resumeVO.setWorkCdList(workArr);
		    	log.info("workArr : " + workArr[0]);
		    }
		    
		    if (salaryCd != null) {
		    	String[] salaryArr = salaryCd.split(",");
		    	resumeVO.setSalaryCdList(salaryArr);
		    	log.info("salaryArr : " + salaryArr[0]);
		    }

		    pagingVO.setItemVO(resumeVO);
		    log.info("resumeVO : " + resumeVO);
		}
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
		}
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = searchService.countResume(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ResumeVO> dataList = searchService.selectResumeList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("salaryList",salaryList);
		model.addAttribute("workList", workList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/talentsearch/searchdutylist";
	}
	
	@GetMapping("/resumedetail")
	public String getResumeDetail(int resNo, HttpSession session, Model model) {
		
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		ResumeVO resumeVO = searchService.selectResume(resNo);	// 이력서
		session.setAttribute("resumeVO", resumeVO);
		
		log.info("entVO : " + entVO);
		log.info("resumeVO : " + resumeVO);
		
		if(entVO == null) {
			return "redirect:/member/loginform";
		}
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> gradList = iccService.selCodeList("GRAD");
		List<CommonCodeVO> workList = iccService.selCodeList("WORK");
		List<CommonCodeVO> sititleList = iccService.selCodeList("SITITLE");
		
		model.addAttribute("duty", dutyList);
		model.addAttribute("career", careerList);
		model.addAttribute("grad", gradList);
		model.addAttribute("work", workList);
		model.addAttribute("sititle", sititleList);
		model.addAttribute("mVo", resumeVO);
		
		return "enterprise/talentsearch/resumedetail";
	}
	
	@ResponseBody
	@PostMapping("/resumeDetail.do")
	public Map<String, Object> postProposal(HttpSession session) {
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		ResumeVO resumeVO = (ResumeVO) session.getAttribute("resumeVO");
		log.info("entVO : " + entVO);
		log.info("resumeVO : " + resumeVO);
		
		String entId = entVO.getEntMbrId();
		String entNm = entVO.getEntNm();
		
		// 회원전화번호 가져오기
		PrivateMemberVO mVo = mpService.getMemberInfo(resumeVO.getPrMbrId());
		String phoneNumber = formatPhoneNumber(mVo.getPrMbrTelno());
			if(phoneNumber.length() == 11) {
				log.info("전화번호 파싱  오류, 문자 전송 미진행");
			} else {
				// 문자전송
				 mService.certifiedPhoneNumber(phoneNumber, entNm, "Y");
			}
		
		ProposalVO prps = new ProposalVO();
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		StringBuilder sb = new StringBuilder();
		sb.append(mVo.getPrMbrNm() + "님 안녕하세요" + entNm + " 채용담당자입니다.")
		.append("\n")
		.append("(주)HIT에 올려주신 이력서를 보고 스카웃 제안 드립니다.")
		.append("\n")
		.append("작성된 이력서를 검토하였을 때, 저희 회사의 기준 및 취지와 적합하다고 판된됩니다.")
		.append("\n")
		.append("자세한 내용은 010-6462-0603으로 전화 또는 문자 주시면 안내하도록 하겠습니다.")
		.append("\n")
		.append("좋은 하루 보내시길 바라겠습니다.");
		log.info("sb : " + sb);
		
		prps.setEntMbrId(entId);
		prps.setPrMbrId(resumeVO.getPrMbrId());
		prps.setPrpslCn(sb.toString());
		prps.setPrpslYn("Y");
		prps.setPrpslTtl(entNm + "에서 보낸 입사 제안입니다.");
		
		int res = searchService.insertPrpsl(prps);
		
		if(res == 0) {
			map.put("result", "fail");
		}
		
		map.put("result", "success");
		map.put("prps", prps);
		
		return map;
	}
	
	public static String formatPhoneNumber(String phoneNumber) 
	 {
	        if (phoneNumber.length() == 11) {
	            // 문자열 연산을 사용하여 전화번호 형식 변환
	            return phoneNumber.substring(0, 3) + "-" + phoneNumber.substring(3, 7) + "-" + phoneNumber.substring(7);
	        } else {
	            // 매칭되는 부분이 없는 경우 처리
	            System.out.println("잘못된 전화번호 형식입니다.");
	            return phoneNumber;
	        }
	    }
	
//	@ResponseBody
//	@PostMapping("/searchdutylist")
//	public ResumeVO getResumeDetail(@RequestBody Map<String, Object> map) {
//		int resNo;
//		resNo = (Integer) map.get("resNo");
//	}
	
	@RequestMapping(value="/searchcareerlist")
	public String searchCareerList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "job") String searchType,
			@RequestParam(required = false) String searchWord,
			String dutyCd, String careerYearCd,
			String workCd, String salaryCd,
			HttpSession session,
			Model model
			) {
	
		PaginationInfoVO<ResumeVO> pagingVO = new PaginationInfoVO<ResumeVO>();
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> workList = iccService.selCodeList("WORK");
		List<CommonCodeVO> salaryList = iccService.selCodeList("SALARY");
		log.info("dutyCd : " + dutyCd);
		log.info("careerYearCd : " + careerYearCd);
		log.info("workCd : " + workCd);
		log.info("salaryCd : " + salaryCd);

		if (dutyCd != null || careerYearCd != null || workCd != null || salaryCd != null) {
		    ResumeVO resumeVO = new ResumeVO();

		    if (dutyCd != null) {
		        String[] dutyArr = dutyCd.split(",");
		        resumeVO.setDutyCdList(dutyArr);
		        log.info("dutyArr : " + dutyArr[0]);
		    }

		    if (careerYearCd != null) {
		        String[] careerYearArr = careerYearCd.split(",");
		        resumeVO.setCareerYearCdList(careerYearArr);
		        log.info("careerYearArr : " + careerYearArr[0]);
		    }
		    
		    if (workCd != null) {
		    	String[] workArr = workCd.split(",");
		    	resumeVO.setWorkCdList(workArr);
		    	log.info("workArr : " + workArr[0]);
		    }
		    
		    if (salaryCd != null) {
		    	String[] salaryArr = salaryCd.split(",");
		    	resumeVO.setSalaryCdList(salaryArr);
		    	log.info("salaryArr : " + salaryArr[0]);
		    }

		    pagingVO.setItemVO(resumeVO);
		    log.info("resumeVO : " + resumeVO);
		}
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
		}
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = searchService.countResume(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ResumeVO> dataList = searchService.selectResumeList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("salaryList",salaryList);
		model.addAttribute("workList", workList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/talentsearch/searchcareerlist";
	}
	
}
