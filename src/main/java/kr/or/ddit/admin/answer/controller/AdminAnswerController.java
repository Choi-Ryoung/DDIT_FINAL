package kr.or.ddit.admin.answer.controller;

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
import kr.or.ddit.admin.answer.service.AdminIAnswerService;
import kr.or.ddit.admin.answer.vo.AnswerVO;
import kr.or.ddit.vo.AdminVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/answer")
public class AdminAnswerController {

	
	@Inject
	private AdminIAnswerService answerService;

	@GetMapping(value = "/form.do")
	public String answerInsertForm() {
		return "admin/answer/answerform";
	}

	
	
	@PostMapping("/insert.do")
		
	public String answerInsert(AnswerVO answerVO, HttpServletRequest req, Model model, RedirectAttributes ra) throws Exception {
	    HttpSession session = req.getSession();
	    AdminVO memberVO = (AdminVO) session.getAttribute("SessionInfo");
	    
	    
	    
	    

	    log.debug("너머온 값:{}", answerVO);

	    String goPage = "";

	    Map<String, String> errors = new HashMap<String, String>();

	    if (answerVO == null) {
	        model.addAttribute("message", "잘못된 요청입니다.");
	        goPage = "admin/answer/answerform";
	        return goPage;
	    }

	    if (StringUtils.isBlank(answerVO.getAnsTtl())) {
	        errors.put("ttl", "제목을 입력해주세요");
	    }

	    if (StringUtils.isBlank(answerVO.getAnsCn())) {
	        errors.put("cn", "내용을 입력해주세요");
	    }

	    if (errors.size() > 0) { // 에러가 있음
	        model.addAttribute("errors", errors);
	        model.addAttribute("answerVO", answerVO);
	        goPage = "admin/answer/answerform";
	    } else { // 에러 없음
	        answerVO.setAnsWrtr(memberVO != null ? memberVO.getPrMbrId() : null);

	        answerVO.setAnsFile(answerVO.getAnsFIle());
	        log.info("체크: answerVO {}", answerVO);

	        ServiceResult result = answerService.insertAnswer(req, answerVO);

	        if (result.equals(ServiceResult.OK)) {
	            goPage = "redirect:/admin/answer/detail.do?ansNo=" + answerVO.getAnsNo();
	        } else {
	            model.addAttribute("message", "서버 에러, 다시 시도해주세요");
	            goPage = "admin/answer/answerform";
	            
	        }
	    }

	    return goPage;
	}
}
	