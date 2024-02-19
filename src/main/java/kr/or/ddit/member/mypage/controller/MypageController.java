
package kr.or.ddit.member.mypage.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mypage.service.IMypageService;
import kr.or.ddit.member.mypage.vo.AcademicBackgroundVO;
import kr.or.ddit.member.mypage.vo.CareerVO;
import kr.or.ddit.member.mypage.vo.CertificateVO;
import kr.or.ddit.member.mypage.vo.PreferenceVO;
import kr.or.ddit.member.mypage.vo.ProjectCareerVO;
import kr.or.ddit.member.mypage.vo.ResumeVO;
import kr.or.ddit.member.mypage.vo.SelfIntroductionVO;
import kr.or.ddit.member.mypage.vo.StudyAndTrainningVO;
import kr.or.ddit.member.mypage.vo.RecordVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;
import kr.or.ddit.member.apply.vo.ApplyVO;
import kr.or.ddit.member.mypage.vo.RecordVO;



@Slf4j
@Controller
@RequestMapping("member/mypage")
public class MypageController {
	
	@Inject
	private IMypageService mpService;
	
	@Inject
	private ICommonCodeService iccService;

	@RequestMapping(value = "/myInfo", method = RequestMethod.GET)
	public String myInfo(PrivateMemberVO memberVO,Model model, HttpServletRequest req, RedirectAttributes ra)  
	{
		
		List<CommonCodeVO> genderList = iccService.selCodeList("GENDER");
		model.addAttribute("genderList",genderList);
		
		String goPage= "";
		log.info("myInfo() Start");
		HttpSession session = req.getSession();
		PrivateMemberVO sessionMember = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		if(sessionMember == null) {
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			goPage ="redirect:/member/myInfo";
		}else {
			String memberId = sessionMember.getPrMbrId();
			
			memberVO = mpService.getMemberInfo(memberId);
			model.addAttribute("member",memberVO);
			goPage =  "member/mypage/myInfo";
			
		}
		return goPage;
	}
	
	
	//일반회원정보 수정
	@PostMapping("/myInfo.do")
	//@ResponseBody
	public ResponseEntity<String> myInfoUpdate( HttpServletRequest req,PrivateMemberVO memberVO,RedirectAttributes ra, Model model, Map param) {
		String a ="";
		a = memberVO.getPrMbrId();
		System.out.println(a);
		System.out.println("회원정보수정ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		System.out.println("memberVO : " + memberVO.getPrMbrId());
		
	
		String a1 = (String) req.getAttribute("prMbrId");
		System.out.println("ggg"+a1);
		String goPage="";
		int result = mpService.profileUpdate(memberVO);
		
		System.out.println("result: " + result);
		
		if(result > 0) {
			ra.addFlashAttribute("message","회원정보 수정이 완료되었습니다!");
			ResponseEntity.ok(String.valueOf("redirect:/member"));
			goPage ="redirect:/member";/*"redirect:/member/myInfo";*/
		}else {
			System.out.println("실패다 시발아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
			model.addAttribute("message","수정에 실패했습니다 다시 확인해주세요");
			model.addAttribute("member",memberVO);
			goPage ="redirect:/member";/*"member/mypage/myInfo";*/
		}
		
		return ResponseEntity.ok(String.valueOf("redirect:/member"));
	}
	

	//------- 이력서  관련 -----------------------------------
	
    
	@RequestMapping(value = "/resumeList", method = RequestMethod.GET)
	public String resumeList(HttpServletRequest request,Model model)  
	{
		log.info("resumeList() Start");
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		
		List<ResumeVO> rList = mpService.selResList(memberVo.getPrMbrId());
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> workList = iccService.selCodeList("WORK");
		List<CommonCodeVO> salaryList = iccService.selCodeList("SALARY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		String prMbrNm= memberVo.getPrMbrNm();
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("workList",workList);
		model.addAttribute("salaryList",salaryList);
		model.addAttribute("careerList",careerList);
		 
		model.addAttribute("rList",rList);
		model.addAttribute("prMbrNm",prMbrNm);
		
		return "member/mypage/resumeList";
	}
	
	@RequestMapping(value = "/resumeInsert", method = RequestMethod.GET)
	public String resumeInsertForm(HttpServletRequest request,Model model)  
	{
		log.info("resumeInsertForm() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		
		
		List<CommonCodeVO> sITitleList = iccService.selCodeList("SITITLE");
		List<CommonCodeVO> gradList = iccService.selCodeList("GRAD");
		
		model.addAttribute("sITitleList",sITitleList);
		model.addAttribute("gradList",gradList);
		model.addAttribute("mVo",memberVo);
		
		return "member/mypage/resumeInsertForm";
	}
	
	@RequestMapping(value = "/resumeDetail", method = RequestMethod.GET)
	public String resumeDetail(@RequestParam String resNo,HttpServletRequest request,Model model)
	{
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		
		List<CommonCodeVO> sITitleList = iccService.selCodeList("SITITLE");
		List<CommonCodeVO> gradList = iccService.selCodeList("GRAD");
		
		
		model.addAttribute("mVo",memberVo);
		model.addAttribute("sITitleList",sITitleList);
		model.addAttribute("gradList",gradList);
		model.addAttribute("resNo",resNo);
		return "member/mypage/resumeDetail";
	}
	
	
	//이력 데이터 로드
	@RequestMapping(value = "/resumeDetailData", method = RequestMethod.GET)
	@ResponseBody
	public RecordVO resumeDetailData(@RequestParam String resNo,HttpServletRequest request,Model model) throws Exception  
	{
		log.info("resumeDetail() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		String prMbrId = memberVo.getPrMbrId();
		
		//이력서 번호 , 회원 아이디  record Data load
		Map<String, String> pMap = new HashMap<String, String>();
		pMap.put("prMbrId", prMbrId);
		pMap.put("resNo", resNo);
		log.info(pMap.toString());
		
		List<AcademicBackgroundVO> acbgList = mpService.selAcbgOne(pMap);
		List<CareerVO> cList = mpService.selCOne(pMap);
		List<CertificateVO> crtList = mpService.selCrtOne(pMap);
		List<PreferenceVO> pList = mpService.selPOne(pMap);
		List<ProjectCareerVO> pcList = mpService.selPcOne(pMap);
		List<StudyAndTrainningVO> satList = mpService.selSatOne(pMap);
		List<SelfIntroductionVO> siList = mpService.selSIOne(pMap);
		
		ResumeVO resVo = mpService.selResOne(pMap);
		log.info("acbgList" + acbgList.toString());
		log.info("cList" + cList.toString());
		log.info("crtList" + crtList.toString());
		log.info("satList" + satList.toString());
		log.info("pList" + pList.toString());
		log.info("pcList" + pcList.toString());
		log.info("siList" + siList.toString());
		
		RecordVO recordVo = new RecordVO();
        recordVo.setAcdbgList(acbgList);
        recordVo.setCareerList(cList);
        recordVo.setCertifList(crtList);
        recordVo.setPjCareerList(pcList);
        recordVo.setPrefList(pList);
        recordVo.setStdatList(satList);
        recordVo.setSelfintList(siList);
        
        recordVo.setResTtl(resVo.getResTtl());
        recordVo.setRprsvResYn(resVo.getRprsvResYn());
        recordVo.setProvPhoto(resVo.getProvPhoto());
        
        return recordVo;
	}
	
	

	//이력서 삭제
	@RequestMapping(value = "/resumeDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> resumeDelete(@RequestParam String resNo,HttpServletRequest request,Model model) throws Exception  
	{
		log.info("resumeDelete.do() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		
		String prMbrId = memberVo.getPrMbrId();
		
		Map<String, String> pMap = new HashMap<String, String>();
		pMap.put("prMbrId", prMbrId);
		pMap.put("resNo", resNo);
		
		int res = mpService.delC(pMap);
		res = mpService.delAcbg(pMap);
		res = mpService.delPc(pMap);
		res = mpService.delSat(pMap);
		res = mpService.delP(pMap);
		res = mpService.delCrt(pMap);
		res = mpService.delSI(pMap);
		
		res = mpService.delResOne(pMap);
		
		if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
		
        return new ResponseEntity<>("OK", HttpStatus.OK);
	}
	
	//이력서 삭제
	@RequestMapping(value = "/rprsvResSet.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> rprsvResSet(@RequestParam String resNo,HttpServletRequest request,Model model) throws Exception  
	{
		log.info("rprsvResSet.do() Start");
		
		HttpSession session = request.getSession();
		PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
		
		String prMbrId = memberVo.getPrMbrId();
		
		Map<String, String> pMap = new HashMap<String, String>();
		pMap.put("prMbrId", prMbrId);
		pMap.put("resNo", resNo);
		
		int res = mpService.rprsvAllN(prMbrId);
		res = mpService.updRprsvRes(pMap);
		
		if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
		
        return new ResponseEntity<>("OK", HttpStatus.OK);
	}
	
	//이력서 삭제
@RequestMapping(value = "/saveMemo.do", method = RequestMethod.POST)
@ResponseBody
public ResponseEntity<String> saveMemo(@RequestParam String resNo,@RequestParam String resMemo,HttpServletRequest request,Model model) throws Exception  
{
	log.info("saveMemo.do() Start");
	
	HttpSession session = request.getSession();
	PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
	
	String prMbrId = memberVo.getPrMbrId();
	
	Map<String, String> pMap = new HashMap<String, String>();
	pMap.put("prMbrId", prMbrId);
	pMap.put("resNo",resNo);
	pMap.put("resMemo", resMemo);
	
	int res = mpService.saveResMemo(pMap);
	
	if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	
    return new ResponseEntity<>("OK", HttpStatus.OK);
}

//
@RequestMapping(value = "/saveWorkCondition.do", method = RequestMethod.POST)
@ResponseBody
public ResponseEntity<String> saveWorkCondition(@RequestBody ResumeVO resume,HttpServletRequest request,Model model) throws Exception  
{
	log.info("saveWorkCondition.do() Start");
	
	HttpSession session = request.getSession();
	PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
	
	String prMbrId = memberVo.getPrMbrId();
	
	Map<String, String> pMap = new HashMap<String, String>();
	pMap.put("prMbrId", prMbrId);
	pMap.put("resNo",String.valueOf(resume.getResNo()));
	pMap.put("careerYearCd", resume.getCareerYearCd());
	pMap.put("salaryCd", resume.getSalaryCd());
	pMap.put("workCd", resume.getWorkCd());
	pMap.put("dutyCd", resume.getDutyCd());
	
	int res = mpService.saveWorkCondition(pMap);
	
	if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	
	return new ResponseEntity<>("OK", HttpStatus.OK);
}



//
@RequestMapping(value = "/getWorkConditionData.do", method = RequestMethod.POST)
@ResponseBody
public ResumeVO getWorkConditionData(@RequestParam String resNo,HttpServletRequest request,Model model) throws Exception  
{
	log.info("saveWorkCondition.do() Start");
	
	HttpSession session = request.getSession();
	PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
	
	String prMbrId = memberVo.getPrMbrId();
	
	Map<String, String> pMap = new HashMap<String, String>();
	
	pMap.put("prMbrId", prMbrId);
	pMap.put("resNo", resNo);
	
	ResumeVO rVo = mpService.selResOne(pMap);
	
	return rVo;
}


			
	
	
	
	
@PostMapping(value = "/resumeUpdate.do", consumes = "multipart/form-data")
@ResponseBody
public ResponseEntity<String> resumeUpdate(HttpServletRequest request,@RequestPart("file") MultipartFile file,@RequestPart("listData") RecordVO rVO)
{
	log.info("resumeUpdate.do()");
	
	HttpSession session = request.getSession();
	PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
	String prMbrId = memberVo.getPrMbrId();
	
	//이력서에 번호랑 아이디 제목 가져와서 set 
	ResumeVO resumeVo = new ResumeVO();
	
	resumeVo.setPrMbrId(prMbrId);
	resumeVo.setResNo(Integer.valueOf(rVO.getResNo()));
	resumeVo.setResTtl(rVO.getResTtl());
	resumeVo.setProvPhoto(fileUpload(request,file));
	resumeVo.setCareerCd(rVO.getCareerCd());
	
	log.info(resumeVo.toString());
	int res1 = mpService.updRes(resumeVo);
	int res = 0;
	List<CareerVO> cList = rVO.getCareerList();
	List<AcademicBackgroundVO> acbgList = rVO.getAcdbgList();
	List<ProjectCareerVO> pcList =  rVO.getPjCareerList();   
	List<PreferenceVO> pList = rVO.getPrefList();
	List<CertificateVO> crtList = rVO.getCertifList();
	List<StudyAndTrainningVO> stdatList =  rVO.getStdatList();
	List<SelfIntroductionVO> siList =  rVO.getSelfintList();
	
	Map<String, String> pMap = new HashMap<String, String>();
	pMap.put("prMbrId", prMbrId);
	pMap.put("resNo", rVO.getResNo());
	
	res = mpService.delC(pMap);
	res = mpService.delAcbg(pMap);
	res = mpService.delPc(pMap);
	res = mpService.delSat(pMap);
	res = mpService.delP(pMap);
	res = mpService.delCrt(pMap);
	res = mpService.delSI(pMap);
	
	
	for (CareerVO careerVO : cList) 
	{	
		careerVO.setResNo(Integer.valueOf(rVO.getResNo()));
		res = mpService.updC(careerVO);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (AcademicBackgroundVO acbgVo : acbgList) {
		acbgVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updAcbg(acbgVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (ProjectCareerVO pcVo : pcList) {
		pcVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updPc(pcVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (PreferenceVO pVo : pList) {
		pVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updP(pVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (CertificateVO crtVo : crtList) {
		crtVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updCrt(crtVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (StudyAndTrainningVO satVo : stdatList) {
		satVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updSat(satVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (SelfIntroductionVO siVo : siList) {
		 siVo.setResNo(Integer.valueOf(rVO.getResNo()));
		 res = mpService.updSI(siVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	
	
	 return new ResponseEntity<>("OK", HttpStatus.OK);
}
	

@ResponseBody
@PostMapping(value ="/resumeInsert.do" , consumes = "multipart/form-data")
public ResponseEntity<String> resumeInsert(HttpServletRequest request,@RequestPart("file") MultipartFile file,@RequestPart("listData") RecordVO rVO)   
{
	log.info("file" + file);
	// 객체를활용한 방법 1
	log.info("#### : " + rVO.toString());
	
	//파일 업로드
	HttpSession session = request.getSession();
	PrivateMemberVO memberVo = (PrivateMemberVO)session.getAttribute("SessionInfo");
	String prMbrId = memberVo.getPrMbrId();
	
	//개인정보
	ResumeVO resumeVo = new ResumeVO();
	resumeVo.setPrMbrId(prMbrId);
	resumeVo.setPrMbrBirthdy(memberVo.getPrMbrBirthdy());
	resumeVo.setPrMbrBscAddr(memberVo.getPrMbrBscAddr());
	resumeVo.setPrMbrDaddr(memberVo.getPrMbrDaddr());
	resumeVo.setPrMbrEmail(memberVo.getPrMbrEmail());
	resumeVo.setPrMbrNm(memberVo.getPrMbrNm());
	resumeVo.setPrMbrTelno(memberVo.getPrMbrTelno());
	resumeVo.setPrMbrZip(memberVo.getPrMbrZip());
	resumeVo.setProvPhoto(fileUpload(request,file));
	resumeVo.setSexdstnCd(memberVo.getSexdstnCd());
	
	resumeVo.setResTtl(rVO.getResTtl());
	resumeVo.setRprsvResYn(rVO.getRprsvResYn());
	resumeVo.setCareerCd(rVO.getCareerCd());
	
	log.info("rprsvResYn" + rVO.getRprsvResYn());
	
	//대표 이력서 설정 전 이전 이력서 전부 n으로 변경 
	int res = mpService.rprsvAllN(prMbrId);
	int res1 = mpService.insRes(resumeVo);
	
	List<CareerVO> cList = rVO.getCareerList();
	
	List<AcademicBackgroundVO> acbgList = rVO.getAcdbgList();

	List<ProjectCareerVO> pcList =  rVO.getPjCareerList();   

	List<PreferenceVO> pList = rVO.getPrefList();

	List<CertificateVO> crtList = rVO.getCertifList();

	List<StudyAndTrainningVO> stdatList =  rVO.getStdatList();
	
	List<SelfIntroductionVO> selfIntList =  rVO.getSelfintList();

	for (CareerVO careerVO : cList) 
	{
		res = mpService.insC(careerVO);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (AcademicBackgroundVO acbgVo : acbgList) {
		 res = mpService.insAcbg(acbgVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (ProjectCareerVO pcVo : pcList) {
		 res = mpService.insPc(pcVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (PreferenceVO pVo : pList) {
		 res = mpService.insP(pVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (CertificateVO crtVo : crtList) {
		 res = mpService.insCrt(crtVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	for (StudyAndTrainningVO satVo : stdatList) {
		 res = mpService.insSat(satVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	
	for (SelfIntroductionVO siVo : selfIntList) {
		 res = mpService.insSI(siVo);
		//if(res == 0){return new ResponseEntity<>("NG", HttpStatus.INTERNAL_SERVER_ERROR);}
	}
	
    return new ResponseEntity<>("OK", HttpStatus.OK);
}


	
	///일반 function
	
	//파일 업로드 후 파일 경로 반환
	public String fileUpload(HttpServletRequest request,MultipartFile file)
	{
		
		String uploadPath = request.getServletContext().getRealPath("/resources/uploads/memProfile");
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
	
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 내가 지원한 기업내역 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@RequestMapping(value="/applyList")
	public String myApplyList(Model model, HttpSession session) {
		
		ApplyVO applyVO = new ApplyVO();

		PrivateMemberVO memVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		applyVO.setPrMbrId(memVO.getPrMbrId());
		
		List<ApplyVO> applyList = mpService.myApplyList(applyVO);
		
		model.addAttribute("applyList", applyList);
		
		return "member/mypage/myApplyList";
	}
	
	// 지원현황 상세보기 최룡
	@ResponseBody
	@RequestMapping(value="/myApplyDetail.do", method = RequestMethod.POST)
	public List<ApplyVO> myApplyDetail(@RequestBody Map<String, Object> map, HttpServletResponse response, HttpSession session) {
		int empmnPbancNo = 0;
		
		empmnPbancNo = (int) map.get("empmnPbancNo");
		
		ApplyVO applyVO = new ApplyVO();

		PrivateMemberVO memVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		applyVO.setPrMbrId(memVO.getPrMbrId());
		applyVO.setEmpmnPbancNo(empmnPbancNo);
		
		List<ApplyVO> applyList = mpService.myApplyDetail(applyVO);
		
		
		return applyList;
	}
	
	@RequestMapping(value = "/memVideoChat", method = RequestMethod.GET)
	public String memVideoChat(int empmnPbancNo, Model model, HttpSession session) {
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		String prMbrId = memberVO.getPrMbrId();
		
		model.addAttribute("empmnPbancNo", empmnPbancNo);
		model.addAttribute("prMbrId", prMbrId);
		
		return "chat/memVideoChat";
	}
	
	
	
}




