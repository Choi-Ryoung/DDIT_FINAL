package kr.or.ddit.vo;

import lombok.Data;

@Data
public class NotificationVO {
	private int ntfctnNo;
	private String ntfctnCn;
	private String ntfctnIdntyYn;
	private String sndptyId;
	private String rcvrId;
}
