package kr.or.ddit.member.notice.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.notice.vo.NoticeFileVO;
import kr.or.ddit.member.notice.vo.NoticeVO;
import kr.or.ddit.member.notice.vo.PaginationInfoVO;
@Service
public interface INoticeService {

	// NoticeController
	public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) throws Exception;
	public NoticeFileVO noticeDownload(int fileNo);


	// NoticeRetreiveController
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);
	public NoticeVO selectNotice(int ntPstNo);
	public ServiceResult deleteNotice(HttpServletRequest req, int ntPstNo);
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);
	public ServiceResult updateNotice(HttpServletRequest req, NoticeVO noticeVO);


	//
	public ServiceResult insertNoticeTag(HttpServletRequest req, NoticeVO noticeVO) throws Exception;
	
	
}
