package kr.or.ddit.admin.mentoring.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.mentoring.service.MentoringService;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("admin")
public class MentoringMananement {
	
	@Inject
	private ICommonCodeService iccService;
	
	@Inject
	private MentoringService mentoringService;
	
	@GetMapping("/mentolist")
	public String mentoList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "nickname") String searchType,
			@RequestParam(required = false) String searchWord,
			String menNcnm,
			Model model) {
		log.info("mentoList() 실행!");
		PaginationInfoVO<MentoringProfileVO> pagingVO = new PaginationInfoVO<MentoringProfileVO>();
		// 검색어 있음
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = mentoringService.selMentoCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MentoringProfileVO> dataList = mentoringService.selMtList(pagingVO);
		pagingVO.setDataList(dataList);
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> proceedList = iccService.selCodeList("PROCEEDING");
		log.info("proceedList : " + proceedList);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("proceedList",proceedList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/mentoring/mentoringlist";
	}
	
	@GetMapping("/mentoform")
	public String mentoInsertForm() {
		return "admin/mentoring/mentoringform";
	}
	
	@GetMapping("/find")
	public String mentoFind(String menNcnm, HttpSession session, Model model) {
		log.info("mentoFind() 실행!");
		log.info("menNcnm : " + menNcnm);
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> proceedList = iccService.selCodeList("PROCEEDING");
		log.info("proceedList : " + proceedList);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("proceedList",proceedList);
		MentoringProfileVO mentoProfile = mentoringService.selectMento(menNcnm);
		log.info("mentoProfile : " + mentoProfile);
		model.addAttribute("mento", mentoProfile);
		return "admin/mentoring/mentoringfind";
	}
	
	@PostMapping("/mentoupdate")
	public String mentoUpdate(MentoringProfileVO mentoVo, HttpSession session, Model model) {
		log.info("mentoUpdate() 실행!");
		log.info("mentoVo : " + mentoVo);
		String goPage = "";
		List<CommonCodeVO> proceedList = iccService.selCodeList("PROCEEDING");
		
		// 반려사유
		String rjctRsn = mentoVo.getRjctRsn();
		// 진행상태
		String procCd = mentoVo.getProcCd();
		String menNcnm = mentoVo.getMenNcnm();
		log.info("menNcnm : " + menNcnm);
		
		model.addAttribute("proceedList", proceedList);
		log.info("proceedList : " + proceedList);
		// 진행상태 업데이트
		if(procCd.equals("승인")) {
			mentoVo.setAprvYn("Y");
			log.info("승인 : " + mentoVo.getAprvYn());
		} else if(procCd.equals("반려") || procCd.equals("대기중")) {
			mentoVo.setAprvYn("N");
			log.info("반려, 대기중 : " + mentoVo.getAprvYn());
		}
		int status = mentoringService.updateProcCd(mentoVo);
		
		log.info("status : " + status);
		if(status > 0) {
			goPage = "redirect:/admin/mentolist";
		} else {
			model.addAttribute("mentoVo", mentoVo);
			goPage = "redirect:/admin/find?menNcnm=" + menNcnm;
		}
		return goPage;
		
	}
	
	
}
