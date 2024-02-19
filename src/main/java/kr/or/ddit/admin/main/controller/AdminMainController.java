package kr.or.ddit.admin.main.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.admin.main.service.IAdminService;
import kr.or.ddit.admin.main.vo.AdminMainGraphVO;
import kr.or.ddit.vo.AdminVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminMainController {

	@Inject
	private IAdminService adminService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String adminMain(Model model, HttpServletRequest req,RedirectAttributes ra)  
	{
		String goPage = "";
		HttpSession session = req.getSession();
		AdminVO sessionAdmin= (AdminVO)session.getAttribute("SessionInfo");
		
		if(sessionAdmin == null) {
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			goPage ="redirect:/admin/login";
		}else {
			//String adminId = sessionAdmin.getAdminId();
			
			List<PrivateMemberVO> prMbrTopTenList = adminService.selectTopTenPrMbr();
			List<EnterpriseMemberVO> entMbrTopTenList = adminService.selectTopTenEntMbr();
			
			model.addAttribute("prMbrTopTenList", prMbrTopTenList);
			model.addAttribute("entMbrTopTenList", entMbrTopTenList);
		
			goPage =  "admin/adminMain";
			
		}
		return goPage; 
	}
	
	@RequestMapping(value = "/getCountMembersList", method = RequestMethod.GET)
	public @ResponseBody List<List<AdminMainGraphVO>> getCountMembersList(Model model, AdminMainGraphVO graphVO) {
		System.out.println("1234");
		List<List<AdminMainGraphVO>> ymdList = new ArrayList<List<AdminMainGraphVO>>();
		List<AdminMainGraphVO> memJoinYmdList = adminService.getCountMembersList(graphVO);
		List<AdminMainGraphVO> entJoinYmdList = adminService.getCountEntMemberList(graphVO);
		
		ymdList.add(memJoinYmdList);
		ymdList.add(entJoinYmdList);
		
		System.out.println("size : " + ymdList.size());

		return ymdList;
	}

}
