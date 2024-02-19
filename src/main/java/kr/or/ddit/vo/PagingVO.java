package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class PagingVO<T> {
	private int totalRecord;		// ì´? ê²Œì‹œê¸? ?ˆ˜
	private int totalPage;			// ì´? ?˜?´ì§? ?ˆ˜
	private int currentPage;		// ?˜„?¬ ?˜?´ì§?
	private int screenSize = 5;	// ?˜?´ì§? ?‹¹ ê²Œì‹œê¸? ?ˆ˜
	private int blockSize = 5;		// ?˜?´ì§? ë¸”ë¡ ?ˆ˜
	private int startRow;			// ?‹œ?‘ row
	private int endRow;				// ? row
	private int startPage;			// ?‹œ?‘ ?˜?´ì§?
	private int endPage;			// ? ?˜?´ì§?	
	private List<T> dataList;		// ê²°ê³¼ë¥? ?„£?„ ?°?´?„° ë¦¬ìŠ¤?Š¸
	private String searchType;		// ê²??ƒ‰ ???…(? œëª?,?‘?„±?,? œëª?+?‘?„±? ?“±?“±)
	private String searchWord;		// ê²??ƒ‰ ?‹¨?–´(?‚¤?›Œ?“œ)
	
	public PagingVO() {}
	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// ceil?? ?˜¬ë¦¼ì— ?•´?‹¹?•œ?‹¤.
		// ì´? ê²Œì‹œê¸? ?ˆ˜ê°? 121ê°œì¼?•Œ, screenSizeë¡? ?‚˜?ˆ„ê²Œë˜ë©? ëª«ì? 12?´ì§?ë§? ?‚˜ë¨¸ì?ê°? ì¡´ì¬?•œ?‹¤.
		// ?´?•Œ, ?˜¬ë¦¼ì„ ?•˜ê²Œë˜ë©? ?‚˜ë¨¸ì??— ???•œ ë¶?ë¶„ì´ ëª«ìœ¼ë¡? ?˜¬ë¦¼ì´ ?˜ë¯?ë¡? 13?´ ?œ?‹¤.
		totalPage = (int)Math.ceil(totalRecord / (double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;	// ?˜„?¬ ?˜?´ì§?
		endRow = currentPage * screenSize;		// ? row = ?˜„?¬ ?˜?´ì§? * ?•œ ?˜?´ì§??‹¹ ê²Œì‹œê¸? ?ˆ˜
		startRow = endRow - (screenSize - 1);	// ?‹œ?‘ row = ? row - (?•œ ?˜?´ì§??‹¹ ê²Œì‹œê¸? ?ˆ˜ - 1)
		// ë§ˆì?ë§? ?˜?´ì§? = (?˜„?¬ ?˜?´ì§? + (?˜?´ì§? ë¸”ë¡ ?‚¬?´ì¦? - 1)) / ?˜?´ì§? ë¸”ë¡ ?‚¬?´ì¦? * ?˜?´ì§? ë¸”ë¡ ?‚¬?´ì¦?
		// blockSize * blockSize?Š” 1,2,3,4... ?˜?´ì§?ë§ˆë‹¤ ?‹¤?ˆ˜ ê³„ì‚°?´ ?•„?‹Œ ? •?ˆ˜ ê³„ì‚°?„ ?´?š©?•´ endPageë¥? êµ¬í•œ?‹¤.
		endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		startPage = endPage - (blockSize - 1);
	}
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append("<ul class='pagination pagination-sm m-0 float-right'>");
		
		if(startPage > 1) {
			html.append("<li class='page-item'><a href='' class='page-link' data-page='" + 
					(startPage - blockSize) + "'>Prev</a></li>");
		}
		
		// ?˜„?¬ ?˜?´ì§?ë¶??„° blockSize?— ?•´?‹¹?•˜?Š” ?˜?´ì§? ? •ë³´ë?? ì¶œë ¥?•  ë°˜ë³µë¬?
		for(int i = startPage; i <= (endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage) {
				html.append("<li class='page-item active'><span class='page-link'>" + i + "</span></li>");
			}else {
				html.append("<li class='page-item'><a href='' class='page-link' data-page='"+i+"'>"+i+"</a></li>");
			}
		}
		
		if(endPage < totalPage) {
			html.append("<li class='page-item'><a href='' class='page-link' data-page='"+(endPage+1)+"'>Next</a></li>");
		}
		html.append("</ul>");
		return html.toString();
	}
	
	
}





















