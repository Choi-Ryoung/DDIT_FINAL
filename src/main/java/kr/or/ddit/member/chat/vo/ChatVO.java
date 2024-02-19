package kr.or.ddit.member.chat.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ChatVO {
	private int chatNo;
	private int roomNo;
	private String prMbrId;
	private String prMbrNcnm;
	private String msg;
	private String crtYmd;
}
