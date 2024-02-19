package kr.or.ddit.member.login.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.login.service.ILoginService;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
@RequestMapping(value = "/member")
public class SignupController {

	@Inject
	private ILoginService loginService;
	
	@Inject
	private ICommonCodeService iccService;
	
	
	


	 
	
	
	@PostMapping("/entsignup.do")
	public String entregister(EnterpriseMemberVO entmemberVO, Model model, HttpServletRequest req, RedirectAttributes ra) {
		System.out.println("register123123123123123123123123 : " + entmemberVO);
		String goPage = "";

		// 1. 넘겨받은 데이터(VO)를 서비스로 던져서 insert 기능을 요청한다. (회원가입 기능 요청)
		// - 회원가입 즉, insert가 완료되서 넘어온 결과는 정수 형태의 값으로 처리 ( 1 : 성공, 0 : 실패 )
		int status = loginService.entinsertMember(entmemberVO, req);
		System.out.println("status : " + status);
		System.out.println("id : " + entmemberVO.getEntMbrId());

		// 2. 넘겨받은 결과 데이터(정수)를 통해서 아래 프로세스를 처리한다.

		// - 1일때, insert가 성공헸을떼 페이지는 로그인 페이지로 이동
		if (status > 0) {
			//model.addAttribute("message", entmemberVO.getEntMbrId() + "님 가입을 축하드립니다 로그인후 이용해주시기바랍니다");
			ra.addFlashAttribute("message", entmemberVO.getEntNm() + "님 가입을 축하드립니다 로그인후 이용해주시기 바랍니다.");
			
			goPage = "redirect:/member/loginform";

			// - 0일때, insert가 실패했을때 페이지는 회원가입 페이지로 이동
			// > 내가 입력한 데이터를 그대로 클라이언트로 전달 (전달방법 : Model 이라는 데이터 잔달자를 통해서 데이터를 전달)
		} else {
			/*
			 * model.addAttribute("memberVO", memberVO); goPage ="/signup";
			 */
			model.addAttribute("entmemberVO", entmemberVO);
			
			goPage = "signup";
		}

		return goPage;
	}
	

	
	@GetMapping("/signup")
	public String registerForm(Model model) {
		List<CommonCodeVO> genderList = iccService.selCodeList("GENDER");
		
		model.addAttribute("genderList",genderList);
		
		return "signup";
	}

	@PostMapping("/signup.do")
	public String register(PrivateMemberVO memberVO, Model model, HttpServletRequest req, RedirectAttributes ra) {
		
		System.out.println("register : " + memberVO);
		String goPage = "";

		// 1. 넘겨받은 데이터(VO)를 서비스로 던져서 insert 기능을 요청한다. (회원가입 기능 요청)
		// - 회원가입 즉, insert가 완료되서 넘어온 결과는 정수 형태의 값으로 처리 ( 1 : 성공, 0 : 실패 )
		int status = loginService.insertMember(memberVO);

		// 2. 넘겨받은 결과 데이터(정수)를 통해서 아래 프로세스를 처리한다.

		// - 1일때, insert가 성공헸을떼 페이지는 로그인 페이지로 이동
		if (status > 0) {
			
			ra.addFlashAttribute("message", memberVO.getPrMbrId() + "님 가입을 축하드립니다 로그인후 이용해주시기 바랍니다.");
			goPage = "redirect:/member/loginform";

			// - 0일때, insert가 실패했을때 페이지는 회원가입 페이지로 이동
			// > 내가 입력한 데이터를 그대로 클라이언트로 전달 (전달방법 : Model 이라는 데이터 잔달자를 통해서 데이터를 전달)
		} else {
			/*
			 * model.addAttribute("memberVO", memberVO); goPage ="/signup";
			 */
		}

		return goPage;
	}
	



	@GetMapping("/checkDuplicateId")
	
	@ResponseBody public ResponseEntity<String> checkDuplicateId(@RequestParam
	String memId) { System.out.println("일반ㅂㅂㅂㅂㅂ"); try { boolean isDuplicate =
	loginService.checkDuplicateId(memId); return
	ResponseEntity.ok(String.valueOf(isDuplicate)); } catch (Exception e) {
	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("false");
	} }

	// 닉네임 중복 확인 엔드포인트
	@GetMapping("/checkDuplicateNick")
	@ResponseBody
	public ResponseEntity<String> checkDuplicateNick(@RequestParam String memNickNm) {
	    try {
	        boolean isDuplicateNick = loginService.checkDuplicateNick(memNickNm);
	        return ResponseEntity.ok(String.valueOf(isDuplicateNick));
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("false");
	    }
	}
	
	
	@GetMapping("/checkDuplicateEntId2")
	@ResponseBody
	public ResponseEntity<String> checkDuplicateentId(@RequestParam String entId) {
		System.out.println("기업ㅂㅂㅂㅂㅂ");
		try {
			boolean isDuplicate = loginService.checkDuplicateEntId2(entId);
			return ResponseEntity.ok(String.valueOf(isDuplicate));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("false");
		}
	}

}
