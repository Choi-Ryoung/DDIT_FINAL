package kr.or.ddit.member.notice.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.member.notice.mapper.INoticeMapper;
import kr.or.ddit.member.notice.vo.NoticeFileVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class FileUploadUtils {
	
	public static void ntFileUpload(List<NoticeFileVO> noticeFileList, int ntPstNo, HttpServletRequest req,
			INoticeMapper mapper) throws Exception {
		String savePath = "/resources/notice/";
		
		if(noticeFileList != null && noticeFileList.size() > 0) {
			for(NoticeFileVO ntFileVO : noticeFileList) {
				String saveName = UUID.randomUUID().toString();
				saveName = saveName + "_" + ntFileVO.getNtFileNm().replaceAll(" ", "_");
				
				// 업로드 서버경로 + /resources/upload/menNcnm
				String saveLocate = req.getServletContext().getRealPath(savePath + ntPstNo);
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// saveLocate + "/" + UUID_원본파일명
				saveLocate += "/" + saveName;
				ntFileVO.setNtPstNo(ntPstNo);;				// 닉네임 설정
				ntFileVO.setNtFileSavepath(saveLocate);	// 파일 업로드 경로 설정
				log.info("ntFileVO1 : " + ntFileVO.toString());
				
				mapper.insertNtFile(ntFileVO);		// 멘토 프로필 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				ntFileVO.getItem().transferTo(saveFile);	// 파일복사
			}
		}
		
	}

	
	
}
