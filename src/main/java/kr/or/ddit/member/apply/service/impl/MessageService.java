package kr.or.ddit.member.apply.service.impl;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class MessageService {
	
	public void certifiedPhoneNumber(String userPhoneNumber,String entNm,String passYn) {
		String api_key = "5";
	    String api_secret = "3";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "010-9782-7770");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    StringBuilder sb = new StringBuilder();
	    
	    if(passYn.equals("Y"))
	    {
	    	sb.append("안녕하세요 " +entNm+ " 채용 담당자 입니다.");
			sb.append("서류전형에 합격하셨습니다.");
			sb.append("축하드립니다.");
	    }
	    else
	    {
	    	sb.append("안녕하세요 " +entNm+ " 채용 담당자 입니다.");
	    	sb.append("서류전형에 불합격하셨습니다.");
		    sb.append("지원해주셔서 감사합니다");
	    }

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
	
	
	public void certifiedPhoneNumber(String userPhoneNumber) {
		String api_key = "5";
	    String api_secret = "3";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "010-9782-7770");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
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

	public void sendPassRes(Map<String, String> pMap) {
		
		//CR 
		String api_key = "NCSNRI0X58GKSAEX";
	    String api_secret = "GXZVNE5BEONXX8I5WUO0WSELSZDMR5KQ";
	    Message coolsms = new Message(api_key, api_secret);

	    //JMK 발표날 이걸로 테스트 후 변경.
	    //String api_key = "NCSNRI0X58GKSAEX";
	    //String api_secret = "GXZVNE5BEONXX8I5WUO0WSELSZDMR5KQ";
	    
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", formatPhoneNumber((String)pMap.get("prMbrTelno")));    // 수신전화번호
	    params.put("from", "01095621990");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    //01095621990 발표날 이걸로 테스트 후 변경.
	    
	    params.put("type", "SMS");
	    StringBuilder sb = new StringBuilder();
	    sb.append("["+pMap.get("empmnPbancTtl") + "]\n");
		if("evalueDocModal".equals(pMap.get("modalId")))
		{
			 sb.append("서류 심사 결과\n");
		}
		else if("evalueCtModal".equals(pMap.get("modalId")))
		{
			 sb.append("코딩테스트 결과\n");
		}
		else if("evalueIvModal".equals(pMap.get("modalId")))
		{
			 sb.append("면접 결과\n");
		}
	    if(pMap.get("passYn").equals("Y"))
	    {
	    	sb.append("합격입니다.");
	    }
	    else if(pMap.get("passYn").equals("N"))
	    {
	    	sb.append("불합격입니다.");
	    }

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
	
	public static String formatPhoneNumber(String phoneNumber) {
        // 전화번호를 010-1234-5678 형식으로 변환하는 정규표현식 패턴
        Pattern pattern = Pattern.compile("(\\d{3})(\\d{4})(\\d{4})");
        Matcher matcher = pattern.matcher(phoneNumber);

        // 정규표현식에 맞게 변환된 전화번호 반환
        if (matcher.matches()) {
            return matcher.replaceFirst("$1-$2-$3");
        } else {
            // 정규표현식에 맞지 않는 경우 기존 번호 그대로 반환
            return phoneNumber;
        }
    }


}
