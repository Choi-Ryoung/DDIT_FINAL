package kr.or.ddit.member.answer.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.member.answer.mapper.IAnswerMapper;
import kr.or.ddit.member.answer.vo.AnswerFileVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class AnswerUploadUtils {
	
	public static void ansFileUpload(List<AnswerFileVO> answerFileList, int ansNo, HttpServletRequest req,
			IAnswerMapper mapper) throws Exception {
		String savePath = "/resources/answer/";
		
		if(answerFileList != null && answerFileList.size() > 0) {
			for(AnswerFileVO ansFileVO : answerFileList) {
				String saveName = UUID.randomUUID().toString();
				saveName = saveName + "_" + ansFileVO.getAnsFileNm().replaceAll(" ", "_");
				
				// 업로드 서버경로 + /resources/upload/menNcnm
				String saveLocate = req.getServletContext().getRealPath(savePath + ansNo);
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// saveLocate + "/" + UUID_원본파일명
				saveLocate += "/" + saveName;
				ansFileVO.setAnsNo(ansNo);				// 닉네임 설정
				ansFileVO.setAnsFileSavepath(saveLocate);	// 파일 업로드 경로 설정
				log.info("ansFileVO1 : " + ansFileVO.toString());
				
				mapper.insertAnsFile(ansFileVO);		// 멘토 프로필 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				ansFileVO.getItem().transferTo(saveFile);	// 파일복사
			}
		}
		
	}

	
	
}
