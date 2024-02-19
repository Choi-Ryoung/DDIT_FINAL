package kr.or.ddit.member.community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/freeboard")
public class FreeBoardController {

	@Inject
	private IFreeService freeService;

	@GetMapping(value = "/form.do")
	public String freeboardInsertForm(CommunityVO communityVO, HttpServletRequest req, Model model, RedirectAttributes ra) {
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo"); 
		
		if(memberVO == null) {
			System.out.println("세션로그인 정보!!!!!!!" + memberVO);
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			 return "redirect:/member/loginform";
		}

		return "member/community/freeform";
	}

	/*
	 * @RequestMapping(value = "/insert.do", method = RequestMethod.POST) public
	 * String freeboardInsert(HttpServletRequest req, CommunityVO communityVO, Model
	 * model, RedirectAttributes ra) { String goPage = "member/community/freeform";
	 * // 이동할 페이지 정보
	 * 
	 * // 넘겨받은 데이터 검증 후, 에러가 발생한 데이터에 대한 에러정보를 담을 공간 Map<String, String> errors =
	 * new HashMap<String, String>();
	 * 
	 * // 제목 데이터가 누락되었을때 에러 정보 저장 if (errors.size() > 0) { // 에러 갯수가 0보다 클 때(에러가 존재)
	 * model.addAttribute("errors", errors); model.addAttribute("communityVO",
	 * communityVO); return "member/community/freeform"; } else { // 에러가 없을 때 // 나머지
	 * 로직 추가 try { // 나머지 로직 추가 ifreeService.insertFreeBoard(communityVO); // 나머지 로직
	 * 추가 } catch (Exception e) { // 에러 처리 로직 ra.addFlashAttribute("error",
	 * "게시글 작성 중 오류가 발생했습니다."); return "redirect:/freeboard/list.do"; } }
	 * 
	 * return goPage; }
	 */

	@PostMapping("/insert.do")
	public String freeBoardInsert(CommunityVO communityVO, HttpServletRequest req, Model model, RedirectAttributes ra)
			throws Exception {
		
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo"); 
		
		log.debug("너머온 값:{}", communityVO);

		String goPage = "";
		
		if(memberVO == null) {
			System.out.println("세션로그인 정보!!!!!!!" + memberVO);
			ra.addFlashAttribute("message","로그인 후 이용가능합니다!");
			goPage ="redirect:/member/loginform";
		}

		Map<String, String> errors = new HashMap<String, String>();

		if (StringUtils.isBlank(communityVO.getComntPstTtl())) {
			errors.put("ttl", "제목을 입력해주세요");
		}

		if (StringUtils.isBlank(communityVO.getComntPstCn())) {
			errors.put("cn", "내용을 입력해주세요");
		}

		if (errors.size() > 0) { // 에러가 있음
			model.addAttribute("errors", errors);
			model.addAttribute("communityVO", communityVO);
			goPage = "member/community/freeform";
		} else { // 에러 없음
			communityVO.setComntWrtrNm(memberVO.getPrMbrNcnm());

			communityVO.setComntFile(communityVO.getComntFile()); //
			log.info("체킁:  communityVO {}", communityVO);

			ServiceResult result = freeService.insertFreeBoard(req, communityVO);

			if (result.equals(ServiceResult.OK)) {
				goPage = "redirect:/freeboard/detail.do?comntPstNo=" + communityVO.getComntPstNo();
			} else {
				model.addAttribute("message", "서버 에러, 다시 시도해주세요");
				goPage = "member/community/freeform";
			}
		}

		return goPage;

	}
	// 댓글
}