package kr.or.ddit.admin.manage.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.manage.mapper.IAdminMemberManageMapper;
import kr.or.ddit.admin.manage.service.IAdminMemberManageService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Service
public class AdminMemberManageServiceImpl implements IAdminMemberManageService {
	
	@Inject
	private IAdminMemberManageMapper adminMemberManageMapper;
	
	@Override
	public int selectMemberCount(PaginationInfoVO<PrivateMemberVO> pagingVO) {
		return adminMemberManageMapper.selectMemberCount(pagingVO);
	}

	@Override
	public List<PrivateMemberVO> selectMemberList(PaginationInfoVO<PrivateMemberVO> pagingVO) {
		return adminMemberManageMapper.selectMemberList(pagingVO);
	}

	@Override
	public PrivateMemberVO selectMemberDetail(String prMbrId) {
		return adminMemberManageMapper.selectMemberDetail(prMbrId);
	}

	@Override
	public int updateMemberInfo(PrivateMemberVO pqVO) {
//		int useStopCnt = pqVO.getUseStopCnt();
//		
//		if(useStopCnt > 0) {
//			adminMemberManageMapper.insertUseStopEndYmd(pqVO);
//		}else if(useStopCnt == 0) {
//			adminMemberManageMapper.updateUseStopEndYmd(pqVO);
//		}
//		
		return adminMemberManageMapper.updateMemberInfo(pqVO);
	}

	@Override
	public void updateUseStopEndYmd(PrivateMemberVO pqVO) {
		adminMemberManageMapper.updateUseStopEndYmd(pqVO);
	}

}
