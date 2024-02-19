package kr.or.ddit.member.mypage.controller;

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

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mentoring.service.MentoService;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mypage.service.IMypageService;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MentoInfoUpdateController {
	
	
	@Inject
	private ICommonCodeService iccService;
	
	@Inject
	private MentoService mentoService;
	
	@Inject
	private IMypageService mpService;
	
/*	@GetMapping("mentoUpdate")
	public String mentoUpdate(String menNcnm, Model model,HttpSession session,HttpServletRequest req, RedirectAttributes ra) {
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		String goPage="";
		PrivateMemberVO sessionMember = (PrivateMemberVO) session.getAttribute("SessionInfo");
		//MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		System.out.println("멘토회원 정보조회!");
		menNcnm = sessionMember.getPrMbrNcnm();
		System.out.println("멘토닉네임" + menNcnm);
		System.out.println(sessionMember);
		
		
		
	if(sessionMember ==null) {
		ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
		goPage ="redirect:/member/loginform";
		
		
	}else {
		MentoringProfileVO mentoProfile = mpService.getMentoInfo(menNcnm);
		
		model.addAttribute("mento",mentoProfile);
		
		goPage= "member/mypage/mentoinfo";
	}
				
		
		
		return goPage;
	}
	*/
	
	
	@GetMapping("mentoUpdate")
	public String mentoUpdate(MentoringProfileVO mentoVO, Model model, HttpServletRequest req, RedirectAttributes ra) {
		
		List<CommonCodeVO> dutyList = iccService.selCodeList("DUTY");
		List<CommonCodeVO> careerList = iccService.selCodeList("CAREER");
		
		model.addAttribute("dutyList",dutyList);
		model.addAttribute("careerList",careerList);
		String goPage="";
		System.out.println("멘토회원 정보조회!");
		HttpSession session = req.getSession();
		PrivateMemberVO sessionMember = (PrivateMemberVO) session.getAttribute("SessionInfo");
		System.out.println("sessionmember" +sessionMember);

		
		
	if(sessionMember ==null) {
		ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
		goPage ="redirect:/member/loginform";
		
		
	}else {
		String menNcnm = sessionMember.getPrMbrNcnm();
		mentoVO = mpService.getMentoInfo(menNcnm);
		model.addAttribute("mento",mentoVO);
		goPage= "member/mypage/mentoinfo";
	}
		
		return goPage;
	}
	@PostMapping("mentoUpdate.do")                        
	public ResponseEntity<String>  mentoUpdatedo( HttpServletRequest req,MentoringProfileVO mentoVO,RedirectAttributes ra, Model model) throws Exception{
		String goPage = "";
		
		
		int result = mpService.mentoUpdate(mentoVO);
		System.out.println("Result = " + result);
		
		if(result > 0) {
			System.out.println("여긴 성공이~요~");
			ra.addFlashAttribute("message","회원정보 수정이 완료되었습니다!");
			ResponseEntity.ok(String.valueOf("redirect:/member/mentoUpdate"));
			goPage = "redirect:/member";
			
		}else {
			System.out.println("여긴 실패요~");
			model.addAttribute("message","수정에 실패했습니다 다시 확인해주세요");
			model.addAttribute("member",mentoVO);
			goPage ="redirect:/member";/*"member/mypage/myInfo";*/
		}
				
				
		
		
		
		return ResponseEntity.ok(String.valueOf("redirect:/member"));
		
	}
	
}
