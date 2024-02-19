package kr.or.ddit.member.login.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.login.service.ILoginService;
import kr.or.ddit.member.login.service.impl.MailServiceImpl;
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
public class LoginController {

	@Inject
    private MailServiceImpl mailService;
	
	@Inject
	private ILoginService loginService;

	@Inject
	private ICommonCodeService iccService;

	@RequestMapping(value = "/loginform", method = RequestMethod.GET)
	public String loginform(String error, String logout, Model model) {
		return "loginform";
	}

	@PostMapping("/login.do")
	public String normallogin(HttpSession session, RedirectAttributes ra, String membership, String id, String pw,
			Model model) {
		String goPage = "";
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(id)) {
			errors.put("id", "아이디를 입력해주세요.");
		}
		if (StringUtils.isBlank(pw)) {
			errors.put("pw", "비밀번호를 입력해주세요.");
		}
		
		// 오늘 날짜 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		int strToday = Integer.parseInt(sdf.format(cal.getTime()));
		
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("id", id);
			model.addAttribute("membership", membership);
			goPage = "loginform";
		} else {
			if (membership.equals("normal")) { // 일반회원일때
				PrivateMemberVO memberVO = loginService.selectMember(id, pw);
				if (memberVO != null) {
					int useStopCnt = memberVO.getUseStopCnt();			// 정지일수
					//int useStopEndYmd = Integer.parseInt(memberVO.getUseStopEndYmd());	// 정지일자
					
					String useStopEndYmdStr = memberVO.getUseStopEndYmd();
					if(useStopEndYmdStr != null) {
						useStopEndYmdStr = useStopEndYmdStr.replace("-", "");
					}
					
					int useStopEndYmd = (useStopEndYmdStr != null) ? Integer.parseInt(useStopEndYmdStr) : 0;
					
					System.out.println("Today = " + strToday);
					System.out.println("useStopEndYmd = " + useStopEndYmd);
					
					// 정지일자가 다 되었을때
					if(strToday >= useStopEndYmd) { 
						int status = loginService.updateStopStatus(id);
						System.out.println("status : " + status);
					}
					
					if(useStopCnt > 0 && useStopEndYmd > strToday) {	// 정지 당했을 때
						model.addAttribute("message", memberVO.getPrMbrNm() + "님은 " + useStopEndYmd + "부터 이용이 가능합니다.");
						goPage = "loginform";
						return goPage;
					}else {			// 정지 당하지 않았을때 또는 정지일자 끝났
						session.setAttribute("SessionInfo", memberVO);
						ra.addFlashAttribute("message", memberVO.getPrMbrNm() + "님! 로그인되었습니다!");
						goPage = "redirect:/member";
					}
				} else {
					model.addAttribute("id", id);
					model.addAttribute("membership", membership);
					model.addAttribute("message", "[서버에러]로그인 실패!, 다시 시도해주세요!");

					goPage = "loginform";
				}
			} else { // 기업회원일때
				EnterpriseMemberVO memberVO = loginService.selectentMember(id, pw);
				if (memberVO != null) {
					int entUseStopCnt = memberVO.getUseStopCnt();			// 정지일수
					//int entUseStopEndYmd = Integer.parseInt(memberVO.getUseStopEndYmd());	// 정지일자
					
					String useStopEndYmdStr = memberVO.getUseStopEndYmd();
					if(useStopEndYmdStr != null) {
						useStopEndYmdStr = useStopEndYmdStr.replace("-", "");
					}
					
					int entUseStopEndYmd = (useStopEndYmdStr != null) ? Integer.parseInt(useStopEndYmdStr) : 0;
					
					// 정지일자가 다 되었을때
					if(strToday >= entUseStopEndYmd) { 
						int status = loginService.updateEntStopStatus(id);
						System.out.println("status : " + status);
					}
					
					if(entUseStopCnt > 0 && entUseStopEndYmd > strToday) {	// 정지 당했을 때
						model.addAttribute("message", memberVO.getEntNm() + "님은 " + entUseStopEndYmd + "부터 이용이 가능합니다.");
						goPage = "loginform";
						return goPage;
					}else {
						session.setAttribute("SessionInfo", memberVO);
						ra.addFlashAttribute("message", memberVO.getEntNm() + "님! 로그인되었습니다!");
						goPage = "redirect:/ent";
					}
					
				} else {
					model.addAttribute("id", id);
					model.addAttribute("membership", membership);
					model.addAttribute("message", "[서버에러]로그인 실패!, 다시 시도해주세요!");

					goPage = "loginform";
				}
			}
		}

		return goPage;
	}


	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/member";

	}
	
	
	//일반회원  아이디 비밀번호 찾기
	@GetMapping("/ForgetIdAndPw")
	public String ForgetIdAndPw(Model model) {
		System.out.println("까르겟겟");
		
		return "idpwfind/memidpwfind";
	}
	
	//일반회원  아이디  찾기
	@ResponseBody
	@PostMapping("/findId.do")
	public ResponseEntity<String> ForgetId(@RequestBody Map<String, Object> map,HttpServletRequest req) {
		System.out.println("이름" + map.get("prMbrNm"));
		System.out.println("이메일" + map.get("prMbrEmail"));
		
		PrivateMemberVO member = loginService.findMemberId(map);
		System.out.println("member" + member.getPrMbrId());
		String findMemberId = member.getPrMbrId();
		
		return new ResponseEntity<String>(findMemberId,HttpStatus.OK);
	}
	
	//일반회원 비밀번호 찾기
	@ResponseBody
	@PostMapping("/findPw.do")
	public ResponseEntity<String> ForgetPw(@RequestBody Map<String, Object> map,HttpServletRequest req,
			RedirectAttributes ra ,HttpServletResponse rep) throws UnsupportedEncodingException {
		req.setCharacterEncoding("utf-8");
		rep.setContentType("text/html;charset=utf-8");
		
		String prMbrEmail = (String) map.get("prMbrEmail");
		String prMbrId = (String) map.get("prMbrId");
		
		System.out.println("이메일" + prMbrEmail);
		System.out.println("아이디" + prMbrId);
		
		//PrivateMemberVO member = loginService.findMemberPw(map);
		
		
		String findMemberPw = makeRndPw();
		map.put("prMbrPswd", findMemberPw);
		loginService.updateMemberPw(map);
		
		
		StringBuffer sb = new StringBuffer();
		
    	sb.append("<html><body>");
 		sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
 		sb.append("<div style='margin: 0; padding: 0; box-sizing: border-box; text-align: center;'>");
 		sb.append("<div style='margin: inherit; padding: inherit; box-sizing: inherit; width: 800px; display: inline-block;'>");
 		sb.append("<h1 style='margin: inherit; padding: inherit; box-sizing: inherit; background-color: #5bc0de; border-color: #46b8da; color: white; border-radius: 4px; text-align: center; padding: 10px;'>비밀번호는 다음과 같습니다.</h1>");
 		sb.append("<p style='margin: inherit; box-sizing: inherit; border-radius: 4px; border: 1px solid #46b8da; padding: 20px; font-size: 2em; text-align: center; font-weight: bold;'>");
 		sb.append(findMemberPw);
 		sb.append("</p>");
 		sb.append("<a href='http://192.168.36.103/member/loginform'>로그인 하러가기</a>");
 		sb.append("</div>");
 		sb.append("</div>");
 		sb.append("</body></html>");
 		String str = sb.toString();
 		
 		mailService.sendMail(prMbrEmail , "HIT", str);
		
		return new ResponseEntity<String>(findMemberPw,HttpStatus.OK);
	}
	
	
	//기업회원  아이디  찾기
	@ResponseBody
	@PostMapping("/findEntId.do")
	public ResponseEntity<String> ForgetEntId(@RequestBody Map<String, Object> map,HttpServletRequest req) {
		System.out.println("사업자번호" + map.get("brno"));
		System.out.println("이메일" + map.get("entMbrEmail"));
		
		EnterpriseMemberVO entmember = loginService.findEntId(map);
		System.out.println("member" + entmember.getEntMbrId());
		String findEntId = entmember.getEntMbrId();
		
		return new ResponseEntity<String>(findEntId,HttpStatus.OK);
	}
	
	
	//기업회원 비밀번호 찾기
		@ResponseBody
		@PostMapping(value="/findEntPw.do", produces = "application/json;charset=utf-8")
		public ResponseEntity<String> ForgetEntPw(@RequestBody Map<String, Object> map,HttpServletRequest req,
				RedirectAttributes ra ,HttpServletResponse rep) throws UnsupportedEncodingException {
			 String goPage = "";
			
			String entMbrEmail = (String) map.get("entMbrEmail");
			String entMbrId = (String) map.get("entMbrId");
			String result = loginService.selectEntId(map);
			
			System.out.println("result : " + result);
			
			if(result == null) {
				return new ResponseEntity<String>("FAILED",HttpStatus.OK);
			}
				
			String findMemberPw = makeRndPw();
			map.put("prMbrPswd", findMemberPw);
			loginService.updateEntPw(map);
			
			
			StringBuffer sb = new StringBuffer();
			
			req.setCharacterEncoding("utf-8");
			rep.setContentType("text/html;charset=utf-8");
	    	sb.append("<html><body>");
	 		sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
	 		sb.append("<div style='margin: 0; padding: 0; box-sizing: border-box; text-align: center;'>");
	 		sb.append("<div style='margin: inherit; padding: inherit; box-sizing: inherit; width: 800px; display: inline-block;'>");
	 		sb.append("<h1 style='margin: inherit; padding: inherit; box-sizing: inherit; background-color: #5bc0de; border-color: #46b8da; color: white; border-radius: 4px; text-align: center; padding: 10px;'>비밀번호는 다음과 같습니다.</h1>");
	 		sb.append("<p style='margin: inherit; box-sizing: inherit; border-radius: 4px; border: 1px solid #46b8da; padding: 20px; font-size: 2em; text-align: center; font-weight: bold;'>");
	 		sb.append(findMemberPw);
	 		sb.append("</p>");
	 		sb.append("<p style='text-align: center;'>");
	 		sb.append("<a href='http://192.168.36.104/member/loginform'>로그인 하러가기</a>");
	 		sb.append("</p>");
	 		sb.append("<p style='text-align: center;'>");
	 		sb.append("</p>");
	 		sb.append("</div>");
	 		sb.append("</div>");
	 		sb.append("</body></html>");
	 		String str = sb.toString();
	 		
	 		mailService.sendMail(entMbrEmail , "HIT", str);
			
			return new ResponseEntity<String>(findMemberPw,HttpStatus.OK);
		}
	
	
	//기업회원  아이디 비밀번호 찾기
	@GetMapping("/entForgetIdAndPw")
	public String entForgetIdAndPw(Model model) {
		System.out.println("기업의 까르겟겟");
		return "idpwfind/entidpwfind";
	}

	private String makeRndPw() {
		UUID newPw = UUID.randomUUID();
		String memPw = newPw.toString().replaceAll("-", "").substring(0, 8);
		return memPw;
	}
	
	
	//네이버 로그인,...,
	  @GetMapping("/social")
	    public String index() {
		  System.out.println("네이버 로그인");
	        return "loginform";
	    }
	  @RequestMapping(value = "login/oauth2/code/naver", method = RequestMethod.GET)
	    public String loginPOSTNaver(HttpSession session) {
	        log.info("callback controller");

		
	        return "callback";
	    }
	  @ResponseBody
	  @PostMapping(value = "/socialLogin",  produces = "application/json;charset=utf-8")
	  public int socialLogin(Model model, PrivateMemberVO member,@RequestBody Map<String, Object> map,
			  						HttpSession session, RedirectAttributes ra) {
		String goPage = "";
		String PrMbrId = (String) map.get("prMbrId");
		String prMbrNm =  (String)map.get("prMbrNm");
		
		
		int a = loginService.selectSSId(PrMbrId);
		if(a > 0) {
			session.setAttribute("SessionInfo", map);
			ra.addFlashAttribute("message", map.get("prMbrNm") + "님! 로그인되었습니다!");
			System.out.println("세션"+session);
			System.out.println("세션2"+ prMbrNm);
		}
			System.out.println("aaaaaaaaaaa:" + a);
		  return a;
	  }
	  
	  @ResponseBody
	  @PostMapping(value = "/socialCreateUser",  produces = "application/json;charset=utf-8")
	  public int socialCreateUser(HttpSession session,Model model,@RequestBody Map<String, Object> map,RedirectAttributes ra) {
		  String goPage = "";
		  
		String prMbrId = (String) map.get("prMbrId");
		String prMbrEmail = (String) map.get("prMbrEmail");
		String prMbrPswd =  (String)map.get("prMbrPswd");
		String prMbrNcnm =  (String)map.get("prMbrNcnm");
		String prMbrNm =  (String)map.get("prMbrNm");
		String prMbrBirthdy =  (String)map.get("prMbrBirthdy");
		String prMbrTelno =  (String)map.get("prMbrTelno");
		
		Map<String,String> pMap = new HashMap<String,String>();
		pMap.put("prMbrId", prMbrId);
		pMap.put("prMbrEmail", prMbrEmail);
		pMap.put("prMbrPswd", prMbrPswd);
		pMap.put("prMbrNcnm", prMbrNcnm);
		pMap.put("prMbrNm", prMbrNm);
		pMap.put("prMbrBirthdy", prMbrBirthdy);
		pMap.put("prMbrTelno", prMbrTelno);
		
		int a = loginService.insertSSMember(pMap);
		
		if(a > 0 ) {
			session.setAttribute("SessionInfo", pMap);
			ra.addFlashAttribute("message", pMap.get("prMbrNm") + "님! 로그인되었습니다!");
			
		}
			System.out.println("aaaaaaaaaaa:" + a);
			
		  return a;
	  }
	  
	
	
}
