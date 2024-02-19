package kr.or.ddit.member.codingtest.controller;

import java.io.File;
import java.lang.reflect.Method;
import java.nio.file.Files;

public class FileClassLoader extends ClassLoader {
	
	public String process(String clsName, String clsString) {
		String folder = System.getProperty("user.dir") + "\\dynamic";

		JavaCompile jc = new JavaCompile();
		// 자바 파일 생성 및 클래스 생성
		String result = jc.compile(clsName, clsString);
		File file = new File(folder, clsName + ".class");
		byte[] classByte;
		
		try {
			classByte = classByte = Files.readAllBytes(file.toPath());
			Class dynamic = findClass(classByte, "dynamic." + clsName);
			file.delete();
			
			Object obj = dynamic.newInstance();
			Method main = dynamic.getMethod("main", String[].class);
			String[] params = null;
			main.invoke(obj, (Object) params);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	public Class findClass(byte[] classByte, String name) throws ClassNotFoundException {
		return defineClass(name, classByte, 0, classByte.length);
	}
}
