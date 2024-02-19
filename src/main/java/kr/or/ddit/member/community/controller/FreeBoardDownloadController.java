package kr.or.ddit.member.community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.ddit.member.community.service.IFreeService;
import kr.or.ddit.member.community.vo.CommunityFileVO;


@Controller
public class FreeBoardDownloadController {

	@Inject
	private IFreeService ifreeService;
	
	@RequestMapping(value="/freeboard/download.do")
	public View communityProcess(
		int fileNo, ModelMap model
			) {
		// 선택한 파일을 다운로드 하기 위한 정보를 파일번호에 해당하는 파일 정보를 얻어온다.
		CommunityFileVO communityFileVO = ifreeService.communityDownload(fileNo);
		
		System.out.println("communityFileVO = " + communityFileVO);
		
		// 데이터 전달자를 통해서 파일정보를 전달하기 위한 Map 선언
		Map<String, Object> freboardFileMap = new HashMap<String, Object>();
		freboardFileMap.put("fileName", communityFileVO.getComntFileNm());
		freboardFileMap.put("fileSize", communityFileVO.getComntFileSz());
		freboardFileMap.put("fileSavepath", communityFileVO.getComntFileSavepath());
		model.addAttribute("freeboardFileMap", freboardFileMap);
		
		// 리턴되는 noticeDownloadView는 jsp페이지로 존재하는 페이지 Name을 요청하는게 아니라,
		// 클래스를 요청하는것인데, 해당 클래스가 스프링에서 제공하는 AbstractView 클래스를 상속받은 클래스인데
		// 그 클래스는 AbstractView를 상속받아 renderMergedOutputMode 함수를 재정의할 때 View로 취급될 수 있게 해준다.
		return new FreeBoardDownloadView();
	}
	
}















