package kr.or.ddit.admin.manage.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.manage.mapper.IAdminEntMemberManageMapper;
import kr.or.ddit.admin.manage.service.IAdminEntMemberManageService;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class AdminEntMemberManageServiceImpl implements IAdminEntMemberManageService {
	
	@Inject
	private IAdminEntMemberManageMapper adminEntMemberManageMapper;

	@Override
	public int selectEntMemberCount(PaginationInfoVO<EnterpriseMemberVO> pagingVO) {
		return adminEntMemberManageMapper.selectEntMemberCount(pagingVO);
	}

	@Override
	public List<EnterpriseMemberVO> selectEntMemberList(PaginationInfoVO<EnterpriseMemberVO> pagingVO) {
		return adminEntMemberManageMapper.selectEntMemberList(pagingVO);
	}

	@Override
	public EnterpriseMemberVO selectEntMemberDetail(String entMbrId) {
		return adminEntMemberManageMapper.selectEntMemberDetail(entMbrId);
	}

	@Override
	public int updateEntMemberInfo(EnterpriseMemberVO entMemberVO) {
		return adminEntMemberManageMapper.updateEntMemberInfo(entMemberVO);
	}

	@Override
	public void updateUseStopEndYmd(EnterpriseMemberVO entMemberVO) {
		adminEntMemberManageMapper.updateUseStopEndYmd(entMemberVO);
	}
	

	
}
