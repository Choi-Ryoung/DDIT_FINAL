package kr.or.ddit.admin.main.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.main.mapper.IAdminMapper;
import kr.or.ddit.admin.main.service.IAdminService;
import kr.or.ddit.admin.main.vo.AdminMainGraphVO;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;

@Service
public class AdminServiceImpl implements IAdminService {

	@Inject
	private IAdminMapper adminMapper;
	
	@Override
	public List<PrivateMemberVO> selectTopTenPrMbr() {
		return adminMapper.selectTopTenPrMbr();
	}

	@Override
	public List<EnterpriseMemberVO> selectTopTenEntMbr() {
		return adminMapper.selectTopTenEntMbr();
	}

	@Override
	public List<AdminMainGraphVO> getCountMembersList(AdminMainGraphVO graphVO) {
		return adminMapper.getCountMembersList(graphVO);
	}

	@Override
	public List<AdminMainGraphVO> getCountEntMemberList(AdminMainGraphVO graphVO) {
		return adminMapper.getCountEntMemberList(graphVO);
	}

}
