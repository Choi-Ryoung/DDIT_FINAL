package kr.or.ddit.member.community.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CommunityVO {
	private int comntPstNo;
	private String comntPstTtl;
	private String comntWrtrNm;
	private String comntPstCn;
	private String comntWrtDt;
	private int comntInqCnt;
	private String comntTitle;
	private String comntContent;
	private String tags;
	private List<CommunityTagVO> tagList;
	private List<CommunityFileVO> communityFileList; // freeboardFileList?
	private MultipartFile[] comntFile;
	private Integer[] DelFreeBoardNo;

	// 세터 이름과 충돌 나지 않게
	public void setComntFile(MultipartFile[] comntFile) {
		this.comntFile = comntFile;
		if (comntFile != null) {
			List<CommunityFileVO> communityFileList = new ArrayList<CommunityFileVO>();
			for (MultipartFile item : comntFile) {
				if (StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				CommunityFileVO communityFileVO = new CommunityFileVO(item);
				communityFileList.add(communityFileVO);
			}
			this.communityFileList = communityFileList;
		}
	}

}