package kr.or.ddit.member.faq.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.faq.service.IFaqService;
import kr.or.ddit.member.faq.vo.FaqVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Inject
	private IFaqService faqservice;
	
	@RequestMapping(value = "/list" ,method=RequestMethod.GET)
	public String list(Model model) {
		List<FaqVO> faqList = faqservice.list();
		model.addAttribute("faqList",faqList);
		return "member/faq/faqlist";
	}
	@RequestMapping(value = "/form",method=RequestMethod.GET)
	public String form() {
		return "member/faq/faqform";
	}
	@RequestMapping(value = "/insert",method=RequestMethod.POST)
	public String insert(FaqVO faqVO , Model model) {
		String goPage = "";
		
		int status = faqservice.insert(faqVO);
		if(status > 0) {
			goPage ="redirect:/faq/detail?faqPstNo="+faqVO.getFaqPstNo();
	}else {
		model.addAttribute("faqVO",faqVO);
		goPage = "member/faq/faqform";
	}
		
		return goPage;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@RequestParam(name = "faqPstNo", required = false) Integer faqPstNo, Model model) {
	    if (faqPstNo == null) {
	        // 처리
	    } else {
	        try {
	            FaqVO faqVO = faqservice.detail(faqPstNo);
	            model.addAttribute("faqVO", faqVO);
	            log.info("faqVO 실행:" + faqVO);
	        } catch (Exception e) {
	            log.error("howdoudo.", e);
	            return "errorPage";
	        }
	    }
	    return "member/faq/faqdetail";
	}
	
	@RequestMapping(value = "/update",method = RequestMethod.GET)
	public String updateForm(int faqPstNo, Model model) {
		FaqVO faqVO = faqservice.detail(faqPstNo);
		model.addAttribute("faqVO",faqVO);
		model.addAttribute("status","u");
		return "member/faq/faqform";
	}
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	public String update(FaqVO faqVO, Model model) {
		String goPage = "";
		faqservice.update(faqVO);
		int status = faqservice.update(faqVO);
		if(status > 0) {
			goPage = "redirect:/faq/detail?faqPstNo="+faqVO.getFaqPstNo();
		}else {
			model.addAttribute("faqVO",faqVO);
			model.addAttribute("status","u");
			goPage = "memberfaq/faqform";
		}
		return goPage;
	}
	
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String delete(int faqPstNo, Model model) {
		String goPage = "";
		int status = faqservice.delete(faqPstNo);
		if(status > 0) {
			goPage = "redirect:/faq/list";
		}else {
			goPage = "redirect:/faq/detail?faqPstNo="+faqPstNo;
		}
		return goPage;
	}

}

