package kr.or.ddit.enterprise.talentsearch.service.impl;
import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class MessageService {
	
	public void certifiedPhoneNumber(String userPhoneNumber,String entNm,String prpslYn) {
		String api_key = "NCS0XMAMFO2NU9CT"; // NCS0XMAMFO2NU9CT
	    String api_secret = "APXCW3SGOKZF4AFRSB9SBB9WTNMVOPJ8"; // APXCW3SGOKZF4AFRSB9SBB9WTNMVOPJ8
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", "010-7455-1436");    // 수신전화번호
	    params.put("from", "010-6462-0603");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    StringBuilder sb = new StringBuilder();
	    
	    if(prpslYn.equals("Y"))
	    {
	    	sb.append("안녕하세요 " +entNm+ " 채용 담당자 입니다.");
	    	sb.append("\n");
			sb.append(entNm + " 면접 제안을 위해 문자 드립니다.");
			sb.append("\n");
			sb.append("연락주세요");
			System.out.println("sb : " + sb);
	    }

	    params.put("text",sb.toString()); // 문자 내용 입력
	    System.out.println("sb.toString() : " + sb.toString());
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	    
	}
	
	
	public void certifiedPhoneNumber(String userPhoneNumber) {
		String api_key = "NCS0XMAMFO2NU9CT"; // NCS0XMAMFO2NU9CT
	    String api_secret = "APXCW3SGOKZF4AFRSB9SBB9WTNMVOPJ8"; // APXCW3SGOKZF4AFRSB9SBB9WTNMVOPJ8
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", "010-7455-1436");    // 수신전화번호
	    params.put("from", "010-6462-0603");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    StringBuilder sb = new StringBuilder();
	    sb.append("test 내용");
	  

	    params.put("text",sb.toString()); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	    
	}

}
