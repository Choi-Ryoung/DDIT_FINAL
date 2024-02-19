package kr.or.ddit.member.codingtest.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.codingtest.service.ICodingTestService;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionSolutionYnVO;
import kr.or.ddit.member.codingtest.vo.PracticeQuestionVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;
import kr.or.ddit.vo.SearchVO;

@Controller
@RequestMapping(value = "/member")
public class CodingTestController {
	
	private static final Logger log = LoggerFactory.getLogger(CodingTestController.class);
	
	
	@Inject
	private ICodingTestService codingTestService;
	
	@RequestMapping(value="/codingTestList")
	public String codingTestList(
			HttpSession session,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false, defaultValue = "diffyCd") String searchType2,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
		log.debug("CodingTestController Logging Test");
		PaginationInfoVO<PracticeQuestionVO> pagingVO = new PaginationInfoVO<PracticeQuestionVO>(10,5);
		
		// 운영에서는 
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		SearchVO searchVO = new SearchVO();
		pagingVO.setSearchVO(searchVO);
		searchVO.setPrMbrId(memberVO.getPrMbrId());
		
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
		
		int totalRecord = codingTestService.selectCodingTestCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		List<PracticeQuestionVO> dataList = codingTestService.selectCodingTestList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "member/codingtest/codingTestList";
		
	}
	
	// 코딩테스트 상세보기
	@RequestMapping(value="/codingTestDetail", method = RequestMethod.GET)
	public String codingTestDetail(int prctQuesNo, Model model) {
		PracticeQuestionVO codingTestVO = codingTestService.selectCodingTest(prctQuesNo);
		model.addAttribute("codingTestVO", codingTestVO);
		return "member/codingtest/codingTestDet/codingTestDetail";
	}
	
	// 내 풀이 조회
	@RequestMapping(value="/myCodingTest", method = RequestMethod.GET)
	public String myCodingTest(
			HttpSession session,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
		PaginationInfoVO<PracticeQuestionVO> pagingVO = new PaginationInfoVO<PracticeQuestionVO>(10,5);
		
		// 운영에서는 
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		SearchVO searchVO = new SearchVO();
		pagingVO.setSearchVO(searchVO);
		searchVO.setPrMbrId(memberVO.getPrMbrId());
		
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
		
		int totalRecord = codingTestService.selectCodingTestCount(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		List<PracticeQuestionVO> dataList = codingTestService.selectMyCodingTest(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);	
				
		return "member/codingtest/myCodingTest";
	}
	
	// 내 풀이 상세보기
	@RequestMapping(value="/myCodingTestDetail", method = RequestMethod.GET)
	public String myCodingTestDetail(PracticeQuestionVO pqVO, Model model, HttpSession session) {
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		pqVO.setPrMbrId(memberVO.getPrMbrId());
		
		PracticeQuestionVO codingTestVO = codingTestService.myCodingTestDetail(pqVO);
		model.addAttribute("codingTestVO", codingTestVO);
		return "member/codingtest/codingTestDet/myCodingTestDetail";
	}
	
	// 컴파일 메소드 호출
	@ResponseBody
	@RequestMapping(value="/compileCode", method = RequestMethod.POST, produces = "application/text;charset=utf-8")
	public String compileMethod(@RequestBody Map<String, Object> map, HttpServletResponse response) {
		String code = "";
		code = (String) map.get("code");
		
		FileClassLoader fc = new FileClassLoader();
		String result = fc.process("Compiler", code);
		
		return result;
	}
	
	@RequestMapping(value="/updateSolutionYn", method = RequestMethod.POST)
	public String updateSolutionYn(
			HttpSession session, RedirectAttributes ra,
			PracticeQuestionSolutionYnVO pqsyn, Model model) {
		String goPage = "";
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		
		pqsyn.setPrMbrId(memberVO.getPrMbrId());
		pqsyn.setPrctQuesNo(pqsyn.getPrctQuesNo());
		
		int prctQuesNo = pqsyn.getPrctQuesNo();
		
		System.out.println("pqsyn.getPrctQuesNo() : " + pqsyn.getPrctQuesNo());
		System.out.println("pqsyn.getPrctQuesAns : " + pqsyn.getPrctQuesAns());
		
		ServiceResult result = codingTestService.problemIsSolve(pqsyn);
		if(result.equals(ServiceResult.SOLVE)) {	// 내가 푼 문제다
			System.out.println("업데이ㅌ,");
			// 문제를 풀었기 때문에 insert된 데이터가 존재
			// 그래서 update가 이루어져야함
			int status = codingTestService.updateSolutionYn(pqsyn);
			if(status > 0) {
				ra.addFlashAttribute("message", "정상 제출되었습니다!");
				goPage = "redirect:/member/myCodingTest";
			}else {
				ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요.");
				goPage = "redirect:/member/codingTestDetail?prctQuesNo=" + prctQuesNo;
			}
			// 처음 풀어보는것이기 때문에 insert해야 함
		}else {	// 처음 풀어보는 문제임
			int status = codingTestService.insertSolutionYn(pqsyn);
			if(status > 0) {
				ra.addFlashAttribute("message", "정상 제출되었습니다!");
				goPage = "redirect:/member/codingTestList";
			}else {
				ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요.");
				goPage = "redirect:/member/codingTestDetail?prctQuesNo=" + prctQuesNo;
			}
		}
		
		return goPage;
	}
	
}
