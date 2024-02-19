package kr.or.ddit.member.notice.mapper;

import java.util.List;

import kr.or.ddit.member.notice.vo.NoticeFileVO;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.member.notice.vo.PaginationInfoVO;

public interface INoticeMapper {

	public void insertNtFile(NoticeFileVO ntFileVO);

	public int insertNotice(NoticeVO noticeVO);

	public NoticeFileVO noticeDownload(int fileNo);

	
	// NoticeRetreiveController
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);

	public void incrementHit(Integer ntPstNo);

	public NoticeVO selectNotice(Integer ntPstNo);

	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	public int updateNotice(NoticeVO noticeVO);

	public void deleteNoticeFile(Integer integer);

	public NoticeFileVO selectNoticeFile(Integer integer);

	public void insertNoticeFile(NoticeFileVO noticeFileVO);

	public void deleteNoticeFileByNo(int ntPstNo);

	public int deleteNotice(int ntPstNo);

	public void insertNoticeTag(String string);
	
	public void incerementNoticeDowncount(int fileNo);

	
}
