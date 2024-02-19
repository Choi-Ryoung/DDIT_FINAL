package kr.or.ddit.enterprise.collabo.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enterprise.collabo.service.ICollaboService;
import kr.or.ddit.enterprise.collabo.vo.CollaboVO;
import kr.or.ddit.member.employment.vo.EmploymentAnnouncementVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/collabo")
public class CollaboController {

	@Inject
	private ICollaboService collaboService;

	@RequestMapping(value = "/list")
	public String CollaboList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		PaginationInfoVO<CollaboVO> pagingVO = new PaginationInfoVO<CollaboVO>();

		// 검색 기능 추가
		// 검색을 했을때의 조건은 키워드(searchWord)가 넘어왔을때 정확하게 검색을 진행한거니까
		// 이때, 검색을 진행하기 위한 타입과 키워드를 PaginationInfoVO에 셋팅하고 목록을 조회하기 위한 조건으로
		// 쿼리를 조회할 수 있도록 보내준다.
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 현재 페이지 전달 후, start/endRow와 start/endPage 설정
		pagingVO.setCurrentPage(currentPage);

		int totalRecord = collaboService.selectCollaboCount(pagingVO); // 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		List<CollaboVO> dataList = collaboService.selectCollaboList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);

		return "enterprise/collabo/collabolist";
	}

	
	@PostMapping("/insert.do")
	public String collaboInsert(CollaboVO collaboVO, Model model, HttpServletRequest req) {

		//[HttpSession] 로그인 처리 후 세션 정보에서 얻어 온 회원정보를 가용하기 위한 준비
		HttpSession session = req.getSession();
		EnterpriseMemberVO entVO = (EnterpriseMemberVO) session.getAttribute("SessionInfo");

		collaboVO.setCoPstWrtr(entVO.getEntNm());
		collaboVO.setCoTelno(entVO.getEntPicTelno());

		int res = collaboService.insertCollabo(collaboVO);
		if(res == 0)
		{
			log.info("등록실패");
			return "redirect:/collabo/insert";
		}
		else
		{
			log.info("등록완료");
			return "redirect:/collabo/list";
		}
	}
	
}
