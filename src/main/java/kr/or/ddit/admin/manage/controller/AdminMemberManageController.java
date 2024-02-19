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

import kr.or.ddit.admin.manage.service.IAdminMemberManageService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Controller
@RequestMapping(value = "/admin/manage")
public class AdminMemberManageController {
	
	@Inject
	private IAdminMemberManageService adminMemberManageService;
	
	@RequestMapping("/memberManage")
	public String memberManage(
			HttpSession session,
			Model model,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "name") String searchType,
			@RequestParam(required = false) String searchWord
		) {
		PaginationInfoVO<PrivateMemberVO> pagingVO = new PaginationInfoVO<PrivateMemberVO>(10, 5);
		
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
		
		int totalRecord = adminMemberManageService.selectMemberCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PrivateMemberVO> dataList = adminMemberManageService.selectMemberList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/management/memberManage";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberDetailInfo", method = RequestMethod.POST)
	public ResponseEntity<PrivateMemberVO> memberDetailInfo(@RequestBody Map<String, Object> map) {
		String prMbrId = "";
		prMbrId = (String) map.get("prMbrId");
		
		PrivateMemberVO memDetail = adminMemberManageService.selectMemberDetail(prMbrId);
		return new ResponseEntity<PrivateMemberVO>(memDetail, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/updateMemberInfo.do", method = RequestMethod.POST)
	public String updateMemberInfo(PrivateMemberVO pqVO, Model model) {
		String goPage = "";
		int useStopCnt = pqVO.getUseStopCnt();
		
		int status = adminMemberManageService.updateMemberInfo(pqVO);
		
		if(useStopCnt == 0) {
			adminMemberManageService.updateUseStopEndYmd(pqVO);
		}
		
		if(status > 0) {
			goPage = "redirect:/admin/manage/memberManage";
		}else {
			model.addAttribute("pqVO", pqVO);
			goPage = "redirect:/admin/manage/memberManage";
		}
		
		return goPage;
	}
	
	
}
