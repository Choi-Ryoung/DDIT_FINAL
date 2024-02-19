package kr.or.ddit.member.mentoring.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MentoringProfileVO {
	private String menNcnm;
	private String prMbrId;
	private String menPstCn;
	private Date menWrtDt;
	private String aprvYn;
	private String trmsAgreCd;
	private String bankCd;
	private String actno;
	private String rjctRsn;
	// 24.01.10 추가
	private MultipartFile picture;
	private String entNm;
	private String entLogo;
	private String applyTaskCd;
	private String applyCareerCd;
	// 2024.01.11 추가
	private String menIndt;
	private List<MentoringTagVO> tagList;
	private String tag;
	// 2024.01.16 추가
	private String[] delmenNcnm;
	private MultipartFile[] menFile;
	private List<MentoringFileVO> menFileList;
	private List<MentiVO> mentiList;
	// 2024.01.25 추가
	private String procCd;
	
	public void setMenFile(MultipartFile[] menFile) {
		this.menFile = menFile;
		if(menFile != null) {
			List<MentoringFileVO> menFileList = new ArrayList<MentoringFileVO>();
			for(MultipartFile item : menFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				MentoringFileVO menFileVO = new MentoringFileVO(item);
				menFileList.add(menFileVO);
			}
			this.menFileList = menFileList;
		}
	}
}
