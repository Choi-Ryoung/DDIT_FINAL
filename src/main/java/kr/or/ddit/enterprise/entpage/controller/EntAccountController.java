package kr.or.ddit.enterprise.entpage.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.enterprise.entpage.service.IEntpageService;
import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.vo.EnterpriseMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("ent/entpage")
public class EntAccountController {
	
	@Inject
	 IEntpageService eaService;
	
	@Inject
	private ICommonCodeService iccService;
	
	@GetMapping("/entAccount")
	public String entAccount(EnterpriseMemberVO entmember,Model model,HttpServletRequest req, RedirectAttributes ra) {
		
		String goPage ="";
		HttpSession session = req.getSession();
		EnterpriseMemberVO sessionEnt = (EnterpriseMemberVO) session.getAttribute("SessionInfo");
		
		if(sessionEnt == null) {
			ra.addFlashAttribute("message","로그인 후 이용 가능합니다!");
			goPage = "redirect:/member/loginform";
		}else {
			String entmemberId = sessionEnt.getEntMbrId();
			
			entmember = eaService.getEntAccount(entmemberId);
			model.addAttribute("entmember",entmember);
			goPage = "enterprise/entinfo/entAccount";
			
		}
		
		
		return goPage;
	}
	
	@ResponseBody
	@PostMapping("/entAccount.do")
	public String entManageUpdate(EnterpriseMemberVO entmemberVO,Model model, 
									HttpServletRequest req, RedirectAttributes ra) {
		String res = null;
		System.out.println("기업회원 수정~~~~~~~~~~~~~");
		int result = eaService.entAccountUpdate(req,entmemberVO);
		System.out.println("entmemberVO : " + entmemberVO.getEntMbrId());
		System.out.println("result :" + result);
		
		if(result > 0) {
			System.out.println("성공이쥬???????????");
			ra.addFlashAttribute("message","회원정보 수정이 완료되었습니다!");
			res = ServiceResult.OK.toString();
		}else {
			System.out.println("실패쥬???????????????");
			model.addAttribute("message","수정에 실패했습니다 확인해주세요");
			model.addAttribute("entmember",entmemberVO);
			res = ServiceResult.FAILED.toString();
		}
		return res;
	

	}
}
