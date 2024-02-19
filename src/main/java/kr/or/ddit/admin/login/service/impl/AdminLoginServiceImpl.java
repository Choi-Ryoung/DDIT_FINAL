package kr.or.ddit.admin.login.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.login.mapper.AdminLoginMapper;
import kr.or.ddit.admin.login.service.IAdminLoginService;
import kr.or.ddit.vo.AdminVO;

@Service
public class AdminLoginServiceImpl implements IAdminLoginService {
	@Inject
	 AdminLoginMapper adminLoginMapper;
	
	@Override
	public AdminVO adminLogin(AdminVO admin) {
		return adminLoginMapper.adminLogin(admin);
		
	}

}
