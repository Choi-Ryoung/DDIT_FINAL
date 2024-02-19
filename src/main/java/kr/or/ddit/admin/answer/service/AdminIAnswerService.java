package kr.or.ddit.admin.answer.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.admin.answer.vo.AnswerCommentVO;
import kr.or.ddit.admin.answer.vo.AnswerFileVO;
import kr.or.ddit.admin.answer.vo.AnswerVO;
import kr.or.ddit.admin.answer.vo.PaginationInfoVO;

public interface AdminIAnswerService {

	public int selectAnswerCount(PaginationInfoVO<AnswerVO> pagingVO);

	public List<AnswerVO> selectAnswerList(PaginationInfoVO<AnswerVO> pagingVO);

	public ServiceResult insertAnswer(HttpServletRequest req, AnswerVO answerVO) throws Exception;


	public ServiceResult updateAnswer(HttpServletRequest req, AnswerVO answerVO);

	public ServiceResult deleteAnswer(HttpServletRequest req, int ansNo);

	public AnswerVO selectAnswer(int ansNo);

	public AnswerFileVO answerDownload(int fileNo);

	public ServiceResult insertAnswerTag(HttpServletRequest req, AnswerVO answerVO) throws Exception;

	public List<AnswerCommentVO> selectCommentList(int ansNo);

	public int addComment(AnswerCommentVO commentVO);

	public int modifyComment(AnswerCommentVO commVO);

	public int deleteComment(AnswerCommentVO commentVO);



}
