package kr.or.ddit.member.mentoring.controller.utils;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.member.mentoring.mapper.MentoMapper;
import kr.or.ddit.member.mentoring.vo.MentoringFileVO;

public class FileUploadUtils {
	
	public static void mentoFileUpload(List<MentoringFileVO> mentoFileList, String menNcnm, HttpServletRequest req,
			MentoMapper mentoMapper) throws Exception {
		String savePath = "/resources/profile/";
		
		if(mentoFileList != null && mentoFileList.size() > 0) {
			for(MentoringFileVO mentoFileVO : mentoFileList) {
				String saveName = UUID.randomUUID().toString();
				saveName = saveName + "_" + mentoFileVO.getMenFileNm().replaceAll(" ", "_");
				
				// 업로드 서버경로 + /resources/upload/menNcnm
				String saveLocate = req.getServletContext().getRealPath(savePath + menNcnm);
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// saveLocate + "/" + UUID_원본파일명
				saveLocate += "/" + saveName;
				mentoFileVO.setMenNcnm(menNcnm);					// 닉네임 설정
				mentoFileVO.setMenFileSavepath(saveLocate);;	// 파일 업로드 경로 설정
				mentoMapper.insertMentoFile(mentoFileVO);		// 멘토 프로필 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				mentoFileVO.getItem().transferTo(saveFile);	// 파일복사
			}
		}
		
	}

	
	
}
