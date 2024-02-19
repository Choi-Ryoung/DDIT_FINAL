package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ChatVO {
	private int chatNo;
	private int roomNo;
	private String prMbrId;
	private String msg;
	private String crtYmd;
}
