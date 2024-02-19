package kr.or.ddit.member.chat.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	private static Map<String, MediaType> mediaMap;
	
	// static 그룹 선언
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	// 넘겨받은 확장자가 포함되어 있는 MemiaType이 존재한다면 null이 아니므로 참
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
