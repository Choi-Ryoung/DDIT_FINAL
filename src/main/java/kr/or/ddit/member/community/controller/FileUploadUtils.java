package kr.or.ddit.member.community.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.member.community.mapper.IFreeMapper;
import kr.or.ddit.member.community.vo.CommunityFileVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class FileUploadUtils {
	
	public static void comntFileUpload(List<CommunityFileVO> communityFileList, int comntPstNo, HttpServletRequest req,
			IFreeMapper mapper) throws Exception {
		String savePath = "/resources/freeboard/";
		
		if(communityFileList != null && communityFileList.size() > 0) {
			for(CommunityFileVO comntFileVO : communityFileList) {
				String saveName = UUID.randomUUID().toString();
				saveName = saveName + "_" + comntFileVO.getComntFileNm().replaceAll(" ", "_");
				
				// 업로드 서버경로 + /resources/upload/menNcnm
				String saveLocate = req.getServletContext().getRealPath(savePath + comntPstNo);
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// saveLocate + "/" + UUID_원본파일명
				saveLocate += "/" + saveName;
				comntFileVO.setComntPstNo(comntPstNo);;				// 닉네임 설정
				comntFileVO.setComntFileSavepath(saveLocate);	// 파일 업로드 경로 설정
				log.info("comntFileVO1 : " + comntFileVO.toString());
				
				mapper.insertComntFile(comntFileVO);		// 멘토 프로필 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				comntFileVO.getItem().transferTo(saveFile);	// 파일복사
			}
		}
		
	}

	
	
}
