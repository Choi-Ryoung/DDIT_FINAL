package kr.or.ddit.member.mentoring.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.mentoring.mapper.ReviewMapper;
import kr.or.ddit.member.mentoring.service.ReviewService;
import kr.or.ddit.member.mentoring.vo.MentiVO;
import kr.or.ddit.member.mentoring.vo.MentoringReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewMapper reviewMapper;

	@Override
	public MentiVO selectMento(String menNcnm) {
		return reviewMapper.selectMento(menNcnm);
	}

	@Override
	public int addReview(MentoringReviewVO reviewVO) {
		return reviewMapper.addReview(reviewVO);
	}

	@Override
	public int updateReview(MentoringReviewVO reviewVO) {
		return reviewMapper.updateReview(reviewVO);
	}

	@Override
	public int deleteReview(MentoringReviewVO reviewVO) {
		return reviewMapper.deleteReview(reviewVO);
	}
	

}
