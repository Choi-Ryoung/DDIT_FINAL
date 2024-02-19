package kr.or.ddit.admin.manage.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.manage.service.IAdminEntMemberManageService;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping(value = "/admin/manage")
public class AdminEntMemberManageController {
	
	@Inject
	private IAdminEntMemberManageService adminEntMemberManageService;
	
	@RequestMapping("/entMemberManage")
	public String entMemberManage(
			HttpSession session,
			Model model,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "name") String searchType,
			@RequestParam(required = false) String searchWord
		) {
		PaginationInfoVO<EnterpriseMemberVO> pagingVO = new PaginationInfoVO<EnterpriseMemberVO>(10, 5);
		
		// ========= 페이징 처리 시작 ========= 
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = adminEntMemberManageService.selectEntMemberCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<EnterpriseMemberVO> dataList = adminEntMemberManageService.selectEntMemberList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/management/entMemberManage";
	}
	
	@ResponseBody
	@RequestMapping(value="/entMemberDetailInfo", method = RequestMethod.POST)
	public ResponseEntity<EnterpriseMemberVO> memberDetailInfo(@RequestBody Map<String, Object> map) {
		String entMbrId = "";
		entMbrId = (String) map.get("entMbrId");
		
		EnterpriseMemberVO entMemDetail = adminEntMemberManageService.selectEntMemberDetail(entMbrId);
		return new ResponseEntity<EnterpriseMemberVO>(entMemDetail, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/updateEntMemberInfo.do", method = RequestMethod.POST)
	public String updateEntMemberInfo(EnterpriseMemberVO entMemberVO, Model model) {
		String goPage = "";
		int useStopCnt = entMemberVO.getUseStopCnt();
		
		int status = adminEntMemberManageService.updateEntMemberInfo(entMemberVO);
		
		if(useStopCnt == 0) {
			adminEntMemberManageService.updateUseStopEndYmd(entMemberVO);
		}
		
		if(status > 0) {
			goPage = "redirect:/admin/manage/entMemberManage";
		}else {
			model.addAttribute("entMemberVO", entMemberVO);
			goPage = "redirect:/admin/manage/entMemberManage";
		}
		
		return goPage;
	}
	
	
}
