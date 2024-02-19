package kr.or.ddit.member.answer.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.answer.vo.AnswerCommentVO;
import kr.or.ddit.member.answer.vo.AnswerFileVO;
import kr.or.ddit.member.answer.vo.AnswerVO;
import kr.or.ddit.member.answer.vo.PaginationInfoVO;

public interface IAnswerService {

	public int selectAnswerCount(PaginationInfoVO<AnswerVO> pagingVO);

	public List<AnswerVO> selectAnswerList(PaginationInfoVO<AnswerVO> pagingVO);

	public ServiceResult insertAnswer(HttpServletRequest req, AnswerVO answerVO) throws Exception;


	public ServiceResult updateAnswer(HttpServletRequest req, AnswerVO answerVO);

	public ServiceResult deleteAnswer(HttpServletRequest req, int ansNo);

	public AnswerVO selectAnswer(int ansNo);

	public AnswerFileVO answerDownload(int fileNo);

	public int addComment(AnswerCommentVO commentVO);

	public int deleteComment(int ansCmtnNo);

	public int modifyComment(AnswerCommentVO commVO);


}
