package kr.or.ddit.member.mentoring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.enterpriseinfo.service.ICommonCodeService;
import kr.or.ddit.member.mentoring.service.PaymentService;
import kr.or.ddit.member.mentoring.vo.MentoringProfileVO;
import kr.or.ddit.member.mentoring.vo.SettlementDescriptionVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.PrivateMemberVO;
import lombok.extern.slf4j.Slf4j;
import sun.nio.cs.HistoricallyNamedCharset;

@Slf4j
@Controller
@RequestMapping("/mento")
public class SettlementController {

	@Inject
	private PaymentService payService;
	
	@Inject
	private ICommonCodeService iccService;
	
	@RequestMapping(value="/pay", method = RequestMethod.GET)
	public String settlementForm(@RequestParam String menNcnm, Model model, HttpSession session) {
		log.info("settlementForm() 실행!");
		log.info("menNcnm" + menNcnm);
		
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		if(memberVO == null) {
			return "redirect:/member/loginform";
		}
		
		List<CommonCodeVO> paymentList = iccService.selCodeList("PAYMENT");
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("menNcnm", menNcnm);
		
		return "member/payment/payform";
	}
	
//	@ResponseBody
//	@RequestMapping(value="/pay", method = RequestMethod.POST)
//	public int settlement(@RequestBody SettlementDescriptionVO settle, HttpSession session, Model model) {
//		log.info("settlement() 실행!");
//		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
//		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
//		log.debug("체킁:{}",memberVO);
//		
//		List<CommonCodeVO> paymentList = iccService.selCodeList("PAYMENT");
//		
//		settle.setPrMbrId(memberVO.getPrMbrId());
//		settle.setSettlementNm(memberVO.getPrMbrNm());
//		settle.setSettlementHp(memberVO.getPrMbrTelno());
//		settle.setSettlementMail(memberVO.getPrMbrEmail());
//		settle.setPrMbrNcnm(memberVO.getPrMbrNcnm());
//		String settleCo = settle.getSettlementCo();
//		if(!settleCo.equals("30000")) {
//			
//		}
//		
//		settle.setSettlementYn("Y");
//		//settle.setMenNcnm("");
//		
//		
//		log.info("결제방식 : " + settle.getSettlementTpCd());
//		log.info("상품명 : " + settle.getSettlementItem());
//		log.info("상품금액 : " + settle.getSettlementCo());
//		log.info("결제자명 : " + settle.getSettlementNm());
//		log.info("결제자 연락처 : " + settle.getSettlementHp());
//		log.info("결제자 이메일 : " + settle.getSettlementMail());
//		log.info("결제자 닉네임 : " + settle.getPrMbrNcnm());
//		log.info("paymentList : " + paymentList);
//		
//		session.setAttribute("settleInfo", settle);
//		model.addAttribute("paymentList", paymentList);
//		model.addAttribute("settle", settle);
//		
//		return payService.getPayment(settle);
//	}
	
	@ResponseBody
	@PostMapping("/pay")
	public Map<String, Object> settlement(@RequestBody SettlementDescriptionVO sVo,HttpSession session) {
		log.info("ett"+ sVo);
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		MentoringProfileVO mentoVO = (MentoringProfileVO) session.getAttribute("mentoInfo");
		log.info("memberVO : " + memberVO);
		log.info("mentoVO : " + mentoVO);
		
		
		//SettlementDescriptionVO sVo = new SettlementDescriptionVO();
		sVo.setPrMbrId(memberVO.getPrMbrId());
		sVo.setPrMbrNcnm(memberVO.getPrMbrNcnm());
		sVo.setMenNcnm(mentoVO.getMenNcnm());
		sVo.setSettlementHp(memberVO.getPrMbrTelno());
		sVo.setSettlementMail(memberVO.getPrMbrEmail());
		sVo.setSettlementYn("Y");
		sVo.setSettlementItem("한시간만 알려주실?");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int cost = sVo.getSettlementCo();
		
		if(cost != 30000) {
			resultMap.put("result", "fail");
			resultMap.put("msg", "금액이 잘못입력하셨습니다.");
			return  resultMap;
		}
		
		int res = payService.getPayment(sVo);
		
		if(res == 0) {
			resultMap.put("result", "fail");
			resultMap.put("msg", "결재 실패했습니다.");
			return  resultMap;
		}
		
		resultMap.put("result", "success");
		resultMap.put("resultData", sVo);
		
		return resultMap;
	}
	
	@GetMapping(value="/paylist")
	public String paymentList(HttpServletRequest req, Model model) {
		List<SettlementDescriptionVO> settleList = payService.getPaymentList();
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		SettlementDescriptionVO settle = (SettlementDescriptionVO)session.getAttribute("settleInfo");
		model.addAttribute("settleList", settleList);
		model.addAttribute("settles", settle);
		log.info("settleList : " + settleList);
		log.info("memberVO : " + memberVO);
		return "member/payment/paydetail";
	}
	
	
	@GetMapping("/paydetail")
	public String paymentDetail(int settlementNo, HttpServletRequest req, Model model) {
		
		HttpSession session = req.getSession();
		PrivateMemberVO memberVO = (PrivateMemberVO) session.getAttribute("SessionInfo");
		log.debug("체킁:{}",memberVO);
		SettlementDescriptionVO settle = payService.getPaymentDetail(settlementNo);
		settle.setPrMbrId(memberVO.getPrMbrId());
		settle.setSettlementNm(memberVO.getPrMbrNm());
		settle.setSettlementHp(memberVO.getPrMbrTelno());
		settle.setSettlementMail(memberVO.getPrMbrEmail());
		 
		
		model.addAttribute("settle", settle);
		return "member/payment/paymentdetail";
		//return payService.getPaymentDetail(settlementNo);
	}
	
	@GetMapping("/payform")
	public String payDetail() {
		return "member/payment/paydetail";
	}
	
}
