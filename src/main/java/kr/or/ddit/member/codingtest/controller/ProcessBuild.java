package kr.or.ddit.member.codingtest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Scanner;

public class ProcessBuild {
	
	public static void main(String[] args) {
		ProcessBuild pb = new ProcessBuild();
		String text = pb.execute("dir");
		System.out.println(text);
	}
	
	 /**
	  * 
	 * @param command cmd 창 명령어 
	 * @return cmd 창에 출력되는 내용 
	 */
	public String execute(String command) {
	        StringBuffer output = new StringBuffer();
	        Process process = null;
	        BufferedReader bufferReader = null;
	        Runtime runtime = Runtime.getRuntime();
	        String osName = System.getProperty("os.name");

	        // 윈도우일 경우
	        if (osName.indexOf("Windows") > -1) {
	            command = "cmd /c " + command;
	        }
	        try {
	            process = runtime.exec(command);
	            Scanner s = new Scanner(process.getInputStream(), "euc-kr");
	            while (s.hasNextLine() == true) {
	                //표준출력으로 출력
	                output.append(s.nextLine() + System.getProperty("line.separator"));
	            }
	            s = new Scanner(process.getErrorStream(), "euc-kr");
	            while (s.hasNextLine() == true) {
	                // 에러 출력
	                output.append(s.nextLine() + System.getProperty("line.separator"));
	            }
	        } catch (IOException e) {
	            output.append("IOException : " + e.getMessage());
	            e.printStackTrace();
	        } finally {
	            try {
	                process.destroy();
	                if (bufferReader != null) bufferReader.close();
	            } catch (IOException e1) {
	                e1.printStackTrace();
	            }
	        }
	        return output.toString();
	    }
}
