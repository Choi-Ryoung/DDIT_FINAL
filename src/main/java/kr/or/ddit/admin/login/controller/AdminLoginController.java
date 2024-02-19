package kr.or.ddit.admin.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.admin.login.service.IAdminLoginService;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.vo.AdminVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "admin")
public class AdminLoginController {
	
	@Inject
	private IAdminLoginService adminLoginService;
	
	@Inject
	private ICommonCodeService iccService;
	
	@GetMapping("login")
	public String adminloginForm(Model model,HttpSession session,RedirectAttributes ra) {
		return "adminlogin";
	}
	
	@PostMapping("login.do")
	public String adminlogin(AdminVO admin ,Model model, HttpSession session, RedirectAttributes ra ) {
		System.out.println("11111111111111111111111111111");
		String goPage ="";
		Map<String , String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(admin.getAdminId())) {
			errors.put("adminId", "아이디 입력하세요");
			System.out.println("아이디에러");
		}
		if(StringUtils.isBlank(admin.getAdminPswd())) {
			errors.put("adminPswd", "비밀번호를 입력하세요");
			System.out.println("비번에러");
		}
		if(errors.size() > 0) {
			System.out.println("에러ㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓ");
			model.addAttribute("errors",errors);
			model.addAttribute("adminVO",admin);
			goPage ="adminlogin";
		}else {
			AdminVO adminVO = adminLoginService.adminLogin(admin);
			if(adminVO != null) {
				System.out.println("asd"+admin.getAdminId());
				session.setAttribute("SessionInfo", adminVO);
				ra.addFlashAttribute("message" ,adminVO.getAdminId() + "님, 로그인 되었습니다");
				
				
				
				goPage="redirect:/admin/main";
			}else {
				model.addAttribute("message","서버에러, 로그인 정보를 정확하게 확인해주세요.");
				model.addAttribute("admin",admin);
				goPage="admin/login";
			}
		}
		System.out.println("222222222222222222");
		return goPage;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin/login";

	}
}
