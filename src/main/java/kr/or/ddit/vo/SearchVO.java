package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SearchVO {
	private String searchType;		// 검색 타입(제목,작성자,제목+작성자 등등)
	private String searchWord;		// 검색 단어(키워드)
	private String prMbrId;
	private String entMbrId;
}
