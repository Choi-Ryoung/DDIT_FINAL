package kr.or.ddit.admin.answer.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.ddit.admin.answer.service.AdminIAnswerService;
import kr.or.ddit.admin.answer.vo.AnswerFileVO;


@Controller
public class AdminAnswerDownloadController {

	@Inject
	private AdminIAnswerService answerService;
	
	@RequestMapping(value="/admin/answer/download.do")
	public View answerProcess(
		int fileNo, ModelMap model
			) {
		// 선택한 파일을 다운로드 하기 위한 정보를 파일번호에 해당하는 파일 정보를 얻어온다.
		AnswerFileVO answerFileVO = answerService.answerDownload(fileNo);
		
		System.out.println("answerFileVO = " + answerFileVO);
		
		// 데이터 전달자를 통해서 파일정보를 전달하기 위한 Map 선언
		Map<String, Object> answerFileMap = new HashMap<String, Object>();
		answerFileMap.put("fileName", answerFileVO.getAnsFileNm());
		answerFileMap.put("fileSize", answerFileVO.getAnsFileSz());
		answerFileMap.put("fileSavepath", answerFileVO.getAnsFileSavepath());
		model.addAttribute("answerFileMap" , answerFileMap);
		
		// 리턴되는 noticeDownloadView는 jsp페이지로 존재하는 페이지 Name을 요청하는게 아니라,
		// 클래스를 요청하는것인데, 해당 클래스가 스프링에서 제공하는 AbstractView 클래스를 상속받은 클래스인데
		// 그 클래스는 AbstractView를 상속받아 renderMergedOutputMode 함수를 재정의할 때 View로 취급될 수 있게 해준다.
		return new AdminAnswerDownloadView();
		
	}
	
}















