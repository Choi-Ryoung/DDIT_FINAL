package kr.or.ddit.admin.answer.mapper;

import java.util.List;

import kr.or.ddit.admin.answer.vo.AnswerCommentVO;
import kr.or.ddit.admin.answer.vo.AnswerFileVO;
import kr.or.ddit.admin.answer.vo.AnswerVO;
import kr.or.ddit.admin.answer.vo.PaginationInfoVO;

public interface AdminIAnswerMapper {

	public int selectAnswerCount(PaginationInfoVO<AnswerVO> pagingVO);

	public List<AnswerVO> selectAnswerList(PaginationInfoVO<AnswerVO> pagingVO);


	public int insertAnswer(AnswerVO answerVO);

	public void insertAnsFile(AnswerFileVO ansFileVO);

	public void incrementHit(int ansNo);

	public AnswerVO selectAnswer(int ansNo);

	public int updateAnswer(AnswerVO answerVO);

	public void deleteAnswerFile(Integer integer);

	public AnswerFileVO selectAnswerFile(Integer integer);

	public void deleteAnswerFileByNo(int ansNo);

	public int deleteAnswer(int ansNo);

	public AnswerFileVO answerDownload(int fileNo);

	public void insertAnswerFile(AnswerFileVO answerFileVO);
	
	public void incrementAnswerDowncount(int fileNo);

	public void insertAnswerTag(String string);

	public List<AnswerCommentVO> selectCommentList(int ansNo);

	public int addComment(AnswerCommentVO commentVO);

	public void deleteAnswerComment(int ansNo);

	public int modifyComment(AnswerCommentVO commVO);

	public int deleteComment(AnswerCommentVO commentVO);

}

