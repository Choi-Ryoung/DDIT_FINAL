package kr.or.ddit.member.apply.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionVO;
import kr.or.ddit.enterprise.codingTest.vo.EntPracticeQuestionYnVO;
import kr.or.ddit.member.apply.service.IApplyService;
import kr.or.ddit.member.apply.service.impl.MessageService;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.employment.service.IEmpService;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.member.mypage.service.IMypageService;
import kr.or.ddit.member.mypage.vo.ResumeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/apply")
public class ApplyController {

	@Inject
	private IApplyService applyService;
	
	@Inject
	private IEmpService empService;
	
	@Inject
	private IMypageService mpService;
	
	private MessageService mService= new MessageService();
	
	@RequestMapping(value="/list")
	public String applyList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model, HttpSession session) {
		
		PaginationInfoVO<ApplyVO> pagingVO = new PaginationInfoVO<ApplyVO>();
		PaginationInfoVO<EmploymentAnnouncementVO> pagingVO2 = new PaginationInfoVO<EmploymentAnnouncementVO>();
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		pagingVO2.setCurrentPage(currentPage);
		
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		pagingVO.setEntMbrId(entVO.getEntMbrId());
		pagingVO2.setEntMbrId(entVO.getEntMbrId());
		
		int totalRecord = applyService.selectApplyCount(pagingVO); // 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		int totalRecord2 = empService.selectAnnouncementCount(pagingVO2);	// 총 게시글 수 가져오기
		pagingVO2.setTotalRecord(totalRecord2);
		
		List<ApplyVO> applyList = applyService.selectApplyList(pagingVO);
		pagingVO.setDataList(applyList);
		
		List<EmploymentAnnouncementVO> dataList2 = empService.selectAnnouncementList(pagingVO2);
		pagingVO2.setDataList2(dataList2);
		
		model.addAttribute("applyList", applyList);
		model.addAttribute("empList", dataList2);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("pagingVO2", pagingVO2);
		
		return "enterprise/apply/applyList";
	}
	
	@GetMapping("/select")
	@ResponseBody
	public List<ApplyVO> applySelect(int empmnPbancNo, Model model) {
		log.info("empmnPbancNo : " + empmnPbancNo);
		List<ApplyVO> applyVO = applyService.selectApply(empmnPbancNo);
		return applyVO;
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
	
		
		@RequestMapping(value="/allList")
		public String applyAllList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model, HttpSession session) {
			
			PaginationInfoVO<ApplyVO> pagingVO = new PaginationInfoVO<ApplyVO>();
			
			// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
			pagingVO.setCurrentPage(currentPage);
		
			EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
			pagingVO.setEntMbrId(entVO.getEntMbrId());
			
			int totalRecord = applyService.selectApplyCount(pagingVO); // 총 게시글 수 가져오기
			pagingVO.setTotalRecord(totalRecord);

			List<ApplyVO> applyList = applyService.selectAllList(pagingVO);
			pagingVO.setDataList(applyList);
			
			model.addAttribute("applyList", applyList);
			model.addAttribute("pagingVO", pagingVO);

			return "enterprise/apply/applyAllList";
		}
	 
	 
	@GetMapping("/resumeOKCheck")
	@ResponseBody
	public String resumeOKCheck(@ModelAttribute("empmnPbancNo") String empmnPbancNo, HttpSession session,
			@ModelAttribute("prMbrId") String prMbrId) {
		
		// 기업 명 가져오기
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		String entNm = entVO.getEntNm();
		
		//회원 전화번호 가져오기
		PrivateMemberVO mVo = mpService.getMemberInfo(prMbrId);
		String phoneNumber = formatPhoneNumber(mVo.getPrMbrTelno());
		  if (phoneNumber.length() == 11) {
			  log.info("전화번호 파싱 오류. 문자 전송 미진행");
		  }
		  else
		  {
			//문자전송
				mService.certifiedPhoneNumber(phoneNumber,entNm,"Y");
		  }
		
		log.info("t" + empmnPbancNo);
		log.info("t" + prMbrId);
	    ApplyVO applyVO = new ApplyVO();
	    applyVO.setEmpmnPbancNo(Integer.valueOf(empmnPbancNo));
	    applyVO.setPrMbrId(prMbrId);

	    int res = applyService.updateResumeOKCheck(applyVO);
	    
	    if(res == 0) {
			log.info("이력서확인실패");
			return "NO";
		} else {
			log.info("이력서확인완료");
			return "OK";
		}
	}
	
	
	@GetMapping("/resumeNOCheck")
	@ResponseBody
	public String resumeNOCheck(@ModelAttribute("empmnPbancNo") String empmnPbancNo, HttpSession session,
			@ModelAttribute("prMbrId") String prMbrId) {
		
		// 기업 명 가져오기
		EnterpriseMemberVO entVO = (EnterpriseMemberVO)session.getAttribute("SessionInfo");
		String entNm = entVO.getEntNm();
		
		
		//회원 전화번호 가져오기
		PrivateMemberVO mVo = mpService.getMemberInfo(prMbrId);
		String phoneNumber = formatPhoneNumber(mVo.getPrMbrTelno());
		  if (phoneNumber.length() == 11) {
			  log.info("전화번호 파싱 오류. 문자 전송 미진행");
		  }
		  else
		  {
			//문자전송
				mService.certifiedPhoneNumber(phoneNumber,entNm,"N");
		  }
	
		log.info("t" + empmnPbancNo);
		log.info("t" + prMbrId);
	    ApplyVO applyVO = new ApplyVO();
	    applyVO.setEmpmnPbancNo(Integer.valueOf(empmnPbancNo));
	    applyVO.setPrMbrId(prMbrId);

	    int res = applyService.updateResumeNOCheck(applyVO);
	    
	    if(res == 0) {
			log.info("이력서확인실패");
			return "NO";
		} else {
			log.info("이력서확인완료");
			return "OK";
		}
	}
	
	
	
	
	@RequestMapping(value = "/resumeOpen")
	@ResponseBody 
	public int openResume(@ModelAttribute("prMbrId") ResumeVO resVO, @ModelAttribute("empmnPbancNo") ApplyVO applyVO) {
		log.info("체크 : " + resVO.getPrMbrId());
		log.info("체크2 : " + applyVO.getEmpmnPbancNo());
		return applyService.resumeOpen(resVO, applyVO); 
	}

	
	@PostMapping("/insert.do")
	@ResponseBody
	public String applyInsert(@RequestPart("resumeFiles") MultipartFile resumeFile, @ModelAttribute ApplyVO applyVO,MultipartHttpServletRequest req) {
		//log.info(" 3423 {}", applyVO);
		//[HttpSession] 로그인 처리 후 세션 정보에서 얻어 온 회원정보를 가용하기 위한 준비
		HttpSession session = req.getSession();
		PrivateMemberVO memVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		//log.info(" pppp {}", applyVO);
		//log.debug("요거다아:"+resVO.getResNo());
		
		int resNum = applyService.getResNo(memVO.getPrMbrId());
		log.info("이력서번호 : " + resNum);
		applyVO.setResNo(resNum);
		applyVO.setResumeFile(fileUpload(req,resumeFile));
		
		applyVO.setPrMbrId(memVO.getPrMbrId());
		applyVO.setDocChkYn("N");
		
		log.info("체크 : " + applyVO.toString());
		
		int res = applyService.insertApply(applyVO, req);
		
		if(res == 0) {
			log.info("등록실패");
			return "NG";
		} else {
			log.info("등록완료");
			return "OK";
		}
	}
	
	//파일 업로드 후 파일 경로 반환
		public String fileUpload(HttpServletRequest request,MultipartFile file)
		{
			
			String uploadPath = request.getServletContext().getRealPath("/resources/uploads/resume");
	    	File makeUploadPath = new File(uploadPath);
	    	if(!makeUploadPath.exists()) 
	    	{
	    		makeUploadPath.mkdirs();
	    	}
	    	
	    	
	    	String prifileImgPath = ""; //기업회원정보에 추가될 프로필 이미지 경로
	    	
			try {
				// 넘겨받은 회원정보에서 파일 데이터 가져오기
				
				// 넘겨받은 파일 데이터가 존재할 때
				if(file != null && !file.isEmpty()/*proFileImgFile.getOriginalFilename() != null && !proFileImgFile.getOriginalFilename().equals("")*/) {
					String fileName = UUID.randomUUID().toString();		// UUID 파일명 생성
					fileName += "_" + file.getOriginalFilename();	// UUID_원본파일명으로 파일명 생성
					//uploadPath += "/" + fileName;	// /resources/profile/uuid_원본파일명
					 String filePath = uploadPath + File.separator + fileName;  // /resources/profile/uuid_원본파일명
			            
					 file.transferTo(new File(filePath));  // 해당 위치에 파일 복사
					//proFileImgFile.transferTo(new File(uploadPath));	// 해당 위치에 파일복사
					 prifileImgPath = "/resources/uploads/memProfile/" + fileName;		// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return prifileImgPath;
		}
	
	@RequestMapping(value = "/newBell")
	@ResponseBody 
	public List<ApplyVO> newBell(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		EnterpriseMemberVO memVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		List<ApplyVO> list = null;
		list = applyService.selectNewApplyCnt(memVO);
		
		if(list == null) {
			list= new ArrayList<ApplyVO>();
		}
		
		return applyService.selectNewApplyCnt(memVO);
	}
	
	
	// 최룡
	@RequestMapping(value = "/realCodingTest", method = RequestMethod.GET)
	public String realCodingTest(
			HttpSession session,
			Model model,
			String entMbrId,
			int empmnPbancNo) {
		System.out.println("entMbrId : " + entMbrId);
		System.out.println("empmnPbancNo : " + empmnPbancNo);
		
		List<EntPracticeQuestionVO> entPqList = applyService.getCodingTestList(entMbrId);
		
		int[] entPqNoArr = new int[5];
		for(int i=0; i<entPqList.size(); i++) {
			entPqNoArr[i] = entPqList.get(i).getEntPqNo();
		}
		session.setAttribute("questionList", entPqNoArr);
		
		model.addAttribute("entPq", entPqList.get(0));
		model.addAttribute("idx", 0);
		model.addAttribute("prevIdx", -1);
		
		model.addAttribute("entMbrId", entMbrId);
		model.addAttribute("empmnPbancNo", empmnPbancNo);
		
		return "member/codingtest/codingTestDet/realCodingTest";
	}
	
	@RequestMapping(value = "/nextCodingTest", method = RequestMethod.POST)
	public String nextCodingTest(
			HttpSession session, int idx, String answer, int entPqNo,
			Model model, String entMbrId, int empmnPbancNo) {
		System.out.println("entMbrId : " + entMbrId);
		System.out.println("#########################################[next]idx : " + idx);
		
		int[] entPqNoArr = (int[]) session.getAttribute("questionList");
		
		idx++;
		EntPracticeQuestionVO entPq = null;
		EntPracticeQuestionVO eqVO = new EntPracticeQuestionVO();
		eqVO.setEntMbrId(entMbrId);
		eqVO.setEntPqNo(entPqNoArr[idx]);
		entPq = applyService.getCodingTest(eqVO);
		if(entPqNoArr.length-1 > idx) {
			model.addAttribute("idx", (idx));
		}else {
			model.addAttribute("idx", (idx));
			model.addAttribute("nextIdx", -1);
		}
		model.addAttribute("entPq", entPq);
		model.addAttribute("entPqNo", entPqNo);
		model.addAttribute("entMbrId", entMbrId);
		model.addAttribute("empmnPbancNo", empmnPbancNo);
		
		return "member/codingtest/codingTestDet/realCodingTest";
	}
	
	@RequestMapping(value = "/prevCodingTest", method = RequestMethod.POST)
	public String prevCodingTest(
			HttpSession session, int idx, String answer, int entPqNo,
			Model model, String entMbrId, int empmnPbancNo) {
		System.out.println("entMbrId : " + entMbrId);
		System.out.println("#########################################[prev]idx : " + idx);
		
		int[] entPqNoArr = (int[]) session.getAttribute("questionList");
		
		idx--;
		EntPracticeQuestionVO entPq = null;
		EntPracticeQuestionVO eqVO = new EntPracticeQuestionVO();
		eqVO.setEntMbrId(entMbrId);
		eqVO.setEntPqNo(entPqNoArr[idx]);
		entPq = applyService.getCodingTest(eqVO);
		if(idx > 0) {
			model.addAttribute("idx", (idx));
		}else {
			model.addAttribute("idx", (idx));
			model.addAttribute("prevIdx", -1);
		}
		model.addAttribute("entPq", entPq);
		model.addAttribute("entPqNo", entPqNo);
		model.addAttribute("entMbrId", entMbrId);
		model.addAttribute("empmnPbancNo", empmnPbancNo);
		
		return "member/codingtest/codingTestDet/realCodingTest";
	}
	
	@RequestMapping(value = "/submitCodingTest", method = RequestMethod.POST)
	public String submitCodingTest(String entMbrId, int empmnPbancNo, String answer, String entPqNoList, HttpSession session) {
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		String prMbrId = memberVO.getPrMbrId();
		
		System.out.println("entMbrId : " + entMbrId);
		System.out.println("empmnPbancNo : " + empmnPbancNo);
		
		String[] strArr = answer.split("___");
		String[] entPqNoArr = entPqNoList.split("___");
		
		System.out.println("strArr : " + Arrays.toString(strArr));
		
		EntPracticeQuestionYnVO epqVO = new EntPracticeQuestionYnVO();
		
		epqVO.setEmpmnPbancNo(empmnPbancNo);
		epqVO.setPrMbrId(prMbrId);
		
		for(int i=0; i<strArr.length; i++) {
			epqVO.setEntPqAns(strArr[i]);
			epqVO.setEntPqNo(Integer.parseInt(entPqNoArr[i]));
			System.out.println("strArr[i] : " + strArr[i]);
			applyService.submitCodingTest(epqVO);
		}
		
		return "redirect:/member/mypage/applyList";
	}
	
	
}
