package kr.or.ddit.member.mypage.vo;
import java.sql.Date;

import lombok.Data;

@Data
public class CareerVO {
	private int	   careerNo;
	private int    resNo;
	private String coNm;
	private String jobPosNm;
	private String serveYn;
	private String workBgngYmd;
	private String workEndYmd;
	private String assignTaskCn;
	private String salary;
	private String workDeptNm;
}
