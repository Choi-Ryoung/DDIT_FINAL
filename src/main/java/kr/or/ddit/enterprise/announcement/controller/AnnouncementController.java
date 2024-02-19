package kr.or.ddit.enterprise.announcement.controller;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.enterprise.announcement.service.IAdmstAreaCodeService;
import kr.or.ddit.member.employment.service.IEmpService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.vo.AdmstAreaCodeVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/announcement")
public class AnnouncementController {
	
	@Inject
	private ICommonCodeService iccService;
	
	@Inject
	private IEmpService empService;
	
	@Inject
	private IAdmstAreaCodeService iaacService;
	
	
	
	@RequestMapping(value="/list")
	public String announcementList(
			HttpSession session, 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		PaginationInfoVO<EmploymentAnnouncementVO> pagingVO = new PaginationInfoVO<EmploymentAnnouncementVO>();
		
		// 검색 기능 추가
		// 검색을 했을때의 조건은 키워드(searchWord)가 넘어왔을때 정확하게 검색을 진행한거니까
		// 이때, 검색을 진행하기 위한 타입과 키워드를 PaginationInfoVO에 셋팅하고 목록을 조회하기 위한 조건으로
		// 쿼리를 조회할 수 있도록 보내준다.
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
		pagingVO.setLogoImg(entVO.getLogoImg());

		log.info("체크 : " + pagingVO.getLogoImg());
		
		int totalRecord = empService.selectAnnouncementCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<EmploymentAnnouncementVO> dataList = empService.selectAnnouncementList(pagingVO);
		
		//지원자 수 
		List<Integer> applicantList = new ArrayList<Integer>();
		List<Integer> applicantAllPassCntList = new ArrayList<Integer>();
		
		Map<String,String> pMap = new HashMap<String,String>();
		
		for (EmploymentAnnouncementVO employmentAnnouncementVO : dataList) {
			pMap.put("empmnPbancNo", String.valueOf(employmentAnnouncementVO.getEmpmnPbancNo()));
			applicantList.add(empService.getApplicantCnt(pMap));
			applicantAllPassCntList.add(empService.getApplicantAllPassCnt(pMap));
		}
		
		
		
		pagingVO.setDataList(dataList);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("applicantList", applicantList);
		model.addAttribute("applicantAllPassCntList", applicantAllPassCntList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "enterprise/announcement/announcementList";
	}
	
	
	@GetMapping("/detail")
	public String announcementDetail(int empmnPbancNo,  Model model) {
		EmploymentAnnouncementVO empVO = empService.selectEmployment(empmnPbancNo);
		model.addAttribute("employment", empVO);
		return "enterprise/announcement/announcementDetail";
	}
	

	@PostMapping("/delete.do")
	public String deleteAnnouncement(
			HttpServletRequest req,
			int empmnPbancNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		ServiceResult result = empService.deleteAnnouncement(req, empmnPbancNo);
		if(result.equals(ServiceResult.OK)) {	// 삭제 성공
			goPage = "redirect:/announcement/list";
			ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
		}else {			// 삭제 실패
			goPage = "redirect:/announcement/detail?empmnPbancNo"+empmnPbancNo;
			ra.addFlashAttribute("message", "게시글 삭제가 실패했습니다!");
		}
		return goPage;
	}
	

	
	@GetMapping("/update")
	public String announcementUpdateForm(int empmnPbancNo,  Model model) {
		EmploymentAnnouncementVO empVO = empService.selectEmployment(empmnPbancNo);
		model.addAttribute("employment", empVO);
			
		AdmstAreaCodeVO admstAreaCodeVO = new AdmstAreaCodeVO();
		admstAreaCodeVO.setCityCd(empVO.getRgnCd());
		
		List<CommonCodeVO> genderList = iccService.selCodeList("GENDER");
		List<CommonCodeVO> acbgList = iccService.selCodeList("ACBG");
		List<CommonCodeVO> ivLevelList = iccService.selCodeList("IVLEVEL");
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> ivTypeList = iccService.selCodeList("IVTYPE");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> workTypeList = iccService.selCodeList("WORK");
		List<AdmstAreaCodeVO> rgnList = iaacService.selCodeList();
		List<AdmstAreaCodeVO> sigunguList = iaacService.selCountyList(admstAreaCodeVO);
		
 		log.info("시군구 리스트 : " + sigunguList.toString());
		
		model.addAttribute("sigunguList",sigunguList);
		model.addAttribute("rgnList",rgnList);
		model.addAttribute("workTypeList",workTypeList);
		model.addAttribute("acbgList",acbgList);
		model.addAttribute("genderList",genderList);
		model.addAttribute("ivLevelList",ivLevelList);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("ivTypeList",ivTypeList);
		model.addAttribute("careerList",careerList);
		
		model.addAttribute("status", "u");	// '수정입니다' flag
		return "enterprise/announcement/announcementInsert";
	}
	
	@PostMapping("/update.do")
	public String announcementUpdate(
			HttpServletRequest req,
			EmploymentAnnouncementVO empVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		//[HttpSession] 로그인 처리 후 세션 정보에서 얻어 온 회원정보를 가용하기 위한 준비
		HttpSession session = req.getSession();
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		empVO.setEmpmnPbancWrtrNm(entVO.getEntNm());
		empVO.setPowkNm(entVO.getEntBscAddr() + " " + entVO.getEntDaddr());
		
		ServiceResult result = empService.updateAnnouncement(req, empVO);
		if(result.equals(ServiceResult.OK)) {	// 수정 성공
			goPage = "redirect:/announcement/detail?empmnPbancNo="+empVO.getEmpmnPbancNo();
			ra.addFlashAttribute("message", "게시글 수정이 완료되었습니다!");
		}else {		// 수정 실패
			model.addAttribute("empVO", empVO);
			model.addAttribute("message", "수정에 실패했습니다!");
			model.addAttribute("status", "u");
			goPage = "/announcement/announcementInsert";
		}
		
		return goPage;
	}
	
	
	
	
	@PostMapping("/insert.do")
	public String announcementInsert(EmploymentAnnouncementVO empVO, Model model, HttpServletRequest req) {

		//[HttpSession] 로그인 처리 후 세션 정보에서 얻어 온 회원정보를 가용하기 위한 준비
		HttpSession session = req.getSession();
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");

		empVO.setEntMbrId(entVO.getEntMbrId());
		empVO.setEmpmnPbancWrtrNm(entVO.getEntNm());
		empVO.setPowkNm(entVO.getEntBscAddr() + " " + entVO.getEntDaddr());

		int res = empService.insertAnnouncement(empVO);
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/announcement/insert";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/announcement/list";
		}
	}

	@GetMapping("/insert")
	public String announcementIn(Model model) {
		List<CommonCodeVO> genderList = iccService.selCodeList("GENDER");
		List<CommonCodeVO> acbgList = iccService.selCodeList("ACBG");
		List<CommonCodeVO> ivLevelList = iccService.selCodeList("IVLEVEL");
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> ivTypeList = iccService.selCodeList("IVTYPE");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> workTypeList = iccService.selCodeList("WORK");
		List<AdmstAreaCodeVO> rgnList = iaacService.selCodeList();
	
		model.addAttribute("rgnList",rgnList);
		model.addAttribute("workTypeList",workTypeList);
		model.addAttribute("acbgList",acbgList);
		model.addAttribute("genderList",genderList);
		model.addAttribute("ivLevelList",ivLevelList);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("ivTypeList",ivTypeList);
		model.addAttribute("careerList",careerList);
		
		return "enterprise/announcement/announcementInsert";
	}
	
	@RequestMapping(value = "/countyList")
	@ResponseBody
	public List<AdmstAreaCodeVO> countyList(AdmstAreaCodeVO admstAreaCodeVO) {
		return iaacService.selCountyList(admstAreaCodeVO);
	}
	
	
	
	
}
