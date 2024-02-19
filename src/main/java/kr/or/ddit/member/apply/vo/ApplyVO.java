package kr.or.ddit.member.apply.vo;

import java.util.Calendar;

import lombok.Data;

@Data
public class ApplyVO {
	private String entMbrId;
	private String prMbrId;
	private int empmnPbancNo;
	private String resumeFile;
	private String applyYmd;
	private String docChkYn;
	private String docPassYn;
	private String codingPassYn;
	private String interviewPassYn;
	private String docPassYmd;
	private String codingPassYmd;
	private String interviewPassYmd;
	private String powkNm;
	private String logoImg;
	
	private int resNo;
	private String provPhoto;
	private String sexdstnCd;
	private String careerCd;
	private String prMbrBirthdy;
	
	private int currAge;
	
	private String prMbrNm;
	private String entNm;
	private String empmnPbancWrtrNm;
	private String empmnPbancTtl;
	
	private int rowNum;
	
	public void setPrMbrBirthdy(String prMbrBirthdy) {
		this.prMbrBirthdy = prMbrBirthdy;
		
		int birthYear = Integer.parseInt(prMbrBirthdy.substring(0,4));
		int birthMonth = Integer.parseInt(prMbrBirthdy.substring(5,7));
		int birthDay = Integer.parseInt(prMbrBirthdy.substring(8,10));
		
		Calendar current = Calendar.getInstance();
        
        int currentYear  = current.get(Calendar.YEAR);
        int currentMonth = current.get(Calendar.MONTH) + 1;
        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
        
        System.out.println("현재 년 : "+currentYear);
        System.out.println("현재 월 : "+currentMonth);
        System.out.println("현재 일 : "+currentDay);
        
        // 만 나이 구하기 2022-1995=27 (현재년-태어난년)
        int age = currentYear - birthYear;
        // 만약 생일이 지나지 않았으면 -1
        if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) 
            age--;
        
        currAge = age;
	}
}
