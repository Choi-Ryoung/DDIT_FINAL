package kr.or.ddit.member.mentoring.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mentoring.mapper.PaymentMapper;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringFileVO;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;
import kr.or.ddit.member.mentoring.vo.MentoringTagVO;
import kr.or.ddit.member.mentoring.vo.PaginationInfoVO;
import kr.or.ddit.member.mentoring.vo.SettlementDescriptionVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mento")
public class MentoController {

	@Resource(name="uploadPath")
	private String resourcePath;
	
	@Inject
	private ChatService chatService;
	
	@Inject
	private MentoService mentoService;
	
	@Inject
	private ICommonCodeService iccService;
	
	
	// 멘토링매치 홈
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String mentoHome() {
		return "member/mentoring/sample2";
	}
	
	// 멘토프로필 리스트
	@RequestMapping(value="/list")
	public String mentoringList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "job") String searchType,
			@RequestParam(required = false) String searchWord,
			HttpSession session,
			Model model
			) {
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		PaginationInfoVO<MentoringProfileVO> pagingVO = new PaginationInfoVO<MentoringProfileVO>();
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		
		}
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = mentoService.selectMentoCount(pagingVO);	// 멘토 프로필 개수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<MentoringProfileVO> dataList = mentoService.selectMentoList(pagingVO);
		pagingVO.setDataList(dataList);
		List<CommonCodeVO> proceedList = iccService.selCodeList("PROCEEDING");
		model.addAttribute("proceedList", proceedList);
		model.addAttribute("pagingVO", pagingVO);
		log.info("proceedList : " + proceedList);
		return "member/mentoring/mentolist";
	}
	
	@RequestMapping(value="/form", method = RequestMethod.GET)
	public String mentoRegisterForm(HttpSession session, Model model) {
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		if(memberVO == null) {
			return "redirect:/member/loginform";
		}
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		log.debug("체킁:{}",memberVO);
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		//model.addAttribute("SessionInfo", session.getAttribute("SessionInfo"));
		
		return "member/mentoring/mentoForm";
	}
	
	@RequestMapping(value="/insert", method = RequestMethod.POST)
	public String mentoInsert(MentoringProfileVO mentoVO, HttpServletRequest req, Model model, RedirectAttributes ra) throws Exception {
		String goPage = "";
		
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		List<CommonCodeVO> proceedList = iccService.selCodeList("PROCEEDING");
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("proceedList",proceedList);
		
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		if(memberVO == null) {
			goPage = "redirect:/member/loginform";
		}
		SettlementDescriptionVO settleVO = (SettlementDescriptionVO) session.getAttribute("settleInfo");
		log.debug("settleVO : " + settleVO);
		mentoVO.setPrMbrId(memberVO.getPrMbrId());
		mentoVO.setMenNcnm(memberVO.getPrMbrNcnm());
		mentoVO.setAprvYn("N");
		mentoVO.setProcCd("대기중");
		
		ServiceResult result = mentoService.insertMento(req, mentoVO);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/mento/list";
		} else {
			model.addAttribute("msg", "다시 시도해주세요");
			goPage = "/member/mentoring/mentoForm";
		
	    }
		return goPage;
	}
	
	
	@ResponseBody
	@RequestMapping(value="idCheck", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> idCheck(@RequestBody Map<String, String> map) {
		log.info("넘겨받은 아이디 : " + map.get("menNcnm"));
		ServiceResult result = mentoService.idCheck(map.get("menNcnm"));
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}

	@GetMapping(value="/find")
	public String mentoFind(String menNcnm, Model model,HttpSession session, Map<String, String> map) {
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		log.info("dddd :" + menNcnm);
		if(memberVO == null) {
			return "redirect:/member/loginform";
		}
		
		if(menNcnm.equals(memberVO.getPrMbrNcnm())) {
			MentoringProfileVO mentoProfile = mentoService.selectMento(menNcnm);
			
			session.setAttribute("mentoInfo", mentoProfile);
			model.addAttribute("mento", mentoProfile);
		} else {
			MentoringProfileVO mentoProfile = mentoService.selectMento(menNcnm);
			
			
			log.info("넘겨받은 멘티 닉네임 : " + map.put("menNcnm", menNcnm));
			log.info("넘겨받은 멘티 닉네임 : " + map.put("prMbrId", memberVO.getPrMbrId()));
			log.info("넘겨받은 멘티 닉네임 : " + map.put("prMbrNcnm", memberVO.getPrMbrNcnm()));
			
			MentiVO menti = mentoService.selMt(map);
			
			ChatRoomVO roomVO = chatService.getChatRoom(map);
			log.info("menti : " + menti);
			log.info("roomVO : " + roomVO);
			
			session.setAttribute("roomVO", roomVO);
			session.setAttribute("mentoInfo", mentoProfile);
			model.addAttribute("mento", mentoProfile);
			model.addAttribute("menti", menti);
			model.addAttribute("roomVO", roomVO);
			
		}
		
		
		return "member/mentoring/mentofind";
	}
	
	@GetMapping("/review")
	public String mentoReview(@RequestParam String menNcnm, Model model,HttpSession session) {
		log.info("menNcnm : " + menNcnm);
		MentiVO menti = (MentiVO)session.getAttribute("mentiInfo");
		log.info("menti : " + menti);
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		
		if(memberVO == null) {
			return "redirect:/member/loginform";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("menNcnm", menNcnm);
		map.put("prMbrId", memberVO.getPrMbrId());
		
		MentiVO mentiVO = mentoService.selectMenti(map);
		log.info("mentiVO : " + mentiVO);
		
		MentoringProfileVO mentoProfile = mentoService.selectMento(menNcnm);
		
		List<MentoringReviewVO> reviewList = mentoService.selectReviewList(menNcnm);
		
		model.addAttribute("mentiVO", mentiVO);
		model.addAttribute("menNcnm", menNcnm);
		model.addAttribute("mento", mentoProfile);
		model.addAttribute("reviewList", reviewList);
		
		return "member/mentoring/mentoreview";
	}
	
	@RequestMapping(value="/modify", method = RequestMethod.GET)
	public String mentoModifyForm(String menNcnm, Model model) {
		MentoringProfileVO mento = mentoService.selectMento(menNcnm);
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		model.addAttribute("mento", mento);
		model.addAttribute("status", "u");
		return "member/mentoring/mentoForm";
	}
	
	@RequestMapping(value="/modify", method = RequestMethod.POST)
	public String mentoModify(MentoringProfileVO mentoVO, HttpServletRequest req, Model model) throws Exception {
		String goPage = "";
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		mentoVO.setPrMbrId(memberVO.getPrMbrId());
		mentoVO.setMenNcnm(memberVO.getPrMbrNcnm());
		
		if(mentoVO.getMenNcnm().equals(memberVO.getPrMbrNcnm())) {
			goPage = "redirect:/mento/list";
		}
		
		ServiceResult result = mentoService.updateMento(req, mentoVO);
		if(result.equals(ServiceResult.OK)) {	// 수정 성공
			goPage = "redirect:/mento/list";
		} else {								// 수정 실패
			model.addAttribute("mento", mentoVO);
			model.addAttribute("status", "u");
			goPage = "member/mentoring/mentoForm";
		}
		return goPage;
	}
	
	@RequestMapping(value="/remove", method = RequestMethod.POST)
	public String mentoDelete(String menNcnm, Model model) {
		String goPage = "";
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		
		ServiceResult result = mentoService.deleteMento(menNcnm);
		if(result.equals(ServiceResult.OK)) {
			model.addAttribute("msg", "삭제가 완료되었습니다.");
			goPage = "redirect:/mento/list";
		} else {
			goPage = "/mento/find?menNcnm=" + menNcnm;
		}
		return goPage;
	}
	
	@GetMapping("/success")
	public String mentoSuccess() {
		return "/member/mentoring/success";
	}
	
	@GetMapping("/alert")
	public String procCd(@RequestParam String menNcnm, HttpSession session, Model model) {
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		
		MentoringProfileVO mentoProfile = mentoService.selectMento(menNcnm);
		log.info("mentoProfile : " + mentoProfile);
		
		model.addAttribute("mento", mentoProfile);
		
		return "member/mentoring/sweetalert2";
	}
	
	@GetMapping("/alert2")
	public String procCd2(@RequestParam String menNcnm, HttpSession session, Model model) {
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		
		MentoringProfileVO mentoProfile = mentoService.selectMento(menNcnm);
		
		model.addAttribute("mento", mentoProfile);
		
		return "member/mentoring/sweetalert3";
	}
	
}
