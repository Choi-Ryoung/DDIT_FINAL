package kr.or.ddit.admin.answer.vo;

import lombok.Data;

@Data
public class AdminVO {
	private int adminNo;
	private String adminId;
	private String adminPswd;
	public String getPrMbrId() {
		return null;
	}
}
