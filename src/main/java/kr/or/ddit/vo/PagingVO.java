package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class PagingVO<T> {
	private int totalRecord;		// μ΄? κ²μκΈ? ?
	private int totalPage;			// μ΄? ??΄μ§? ?
	private int currentPage;		// ??¬ ??΄μ§?
	private int screenSize = 5;	// ??΄μ§? ?Ή κ²μκΈ? ?
	private int blockSize = 5;		// ??΄μ§? λΈλ‘ ?
	private int startRow;			// ?? row
	private int endRow;				// ? row
	private int startPage;			// ?? ??΄μ§?
	private int endPage;			// ? ??΄μ§?	
	private List<T> dataList;		// κ²°κ³Όλ₯? ?£? ?°?΄?° λ¦¬μ€?Έ
	private String searchType;		// κ²?? ???(? λͺ?,??±?,? λͺ?+??±? ?±?±)
	private String searchWord;		// κ²?? ?¨?΄(?€??)
	
	public PagingVO() {}
	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// ceil?? ?¬λ¦Όμ ?΄?Ή??€.
		// μ΄? κ²μκΈ? ?κ°? 121κ°μΌ?, screenSizeλ‘? ??κ²λλ©? λͺ«μ? 12?΄μ§?λ§? ?λ¨Έμ?κ°? μ‘΄μ¬??€.
		// ?΄?, ?¬λ¦Όμ ?κ²λλ©? ?λ¨Έμ?? ??? λΆ?λΆμ΄ λͺ«μΌλ‘? ?¬λ¦Όμ΄ ?λ―?λ‘? 13?΄ ??€.
		totalPage = (int)Math.ceil(totalRecord / (double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;	// ??¬ ??΄μ§?
		endRow = currentPage * screenSize;		// ? row = ??¬ ??΄μ§? * ? ??΄μ§??Ή κ²μκΈ? ?
		startRow = endRow - (screenSize - 1);	// ?? row = ? row - (? ??΄μ§??Ή κ²μκΈ? ? - 1)
		// λ§μ?λ§? ??΄μ§? = (??¬ ??΄μ§? + (??΄μ§? λΈλ‘ ?¬?΄μ¦? - 1)) / ??΄μ§? λΈλ‘ ?¬?΄μ¦? * ??΄μ§? λΈλ‘ ?¬?΄μ¦?
		// blockSize * blockSize? 1,2,3,4... ??΄μ§?λ§λ€ ?€? κ³μ°?΄ ?? ? ? κ³μ°? ?΄?©?΄ endPageλ₯? κ΅¬ν?€.
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
		
		// ??¬ ??΄μ§?λΆ??° blockSize? ?΄?Ή?? ??΄μ§? ? λ³΄λ?? μΆλ ₯?  λ°λ³΅λ¬?
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





















