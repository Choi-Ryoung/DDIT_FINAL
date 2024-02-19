package kr.or.ddit.member.mentoring.service;

import java.util.List;

import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;

public interface ReviewService {

	public MentiVO selectMento(String menNcnm);
	public int addReview(MentoringReviewVO reviewVO);
	public int updateReview(MentoringReviewVO reviewVO);
	public int deleteReview(MentoringReviewVO reviewVO);


}
