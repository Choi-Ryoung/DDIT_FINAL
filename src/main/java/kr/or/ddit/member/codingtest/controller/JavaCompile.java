package kr.or.ddit.member.codingtest.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class JavaCompile {

	public String compile(String clsName, String clsStr) {
		// 클래스 이름과, 자바 파일 내용 포함.
		// 자바 파일 생성.
		String msg = "";
		File file = wirteClass(clsName, clsStr);

		// 자바 파일 컴파일 명령어
		String command = "javac -encoding UTF-8 dynamic/" + clsName + ".java";
		ProcessBuild pb = new ProcessBuild();
		String result = pb.execute(command);
		String result1 = pb.execute("java dynamic/" + clsName);
		System.out.println("#### 실행 결과 result1 : " + result1);
		System.out.println("#### 실행 결과 result : " + result);
		// 임시 생성된 자바 파일 삭제.
		file.delete();
		
		if(result != null && result.contains("error")) {	// 에러 발생
			msg += result + "\r\n" + result1;
		}else {
			msg += result1;
		}
		
		return msg.replaceAll("\\r\\n", "<br/>");
	}

	public File wirteClass(String clsName, String stringClass) {
		String folder = System.getProperty("user.dir") + "\\dynamic";
		// 임의의 패키지명 부여
		return write(folder, clsName + ".java", "package dynamic; " + stringClass);
	}

	private File write(String folderName, String fileName, String result) {
		File folder = new File(folderName);
		if (!folder.exists())
			folder.mkdirs();
			FileWriter fw;
		try {
			File file = new File(folderName, fileName);
			fw = new FileWriter(file);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(result);
			bw.close();
			return file;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
