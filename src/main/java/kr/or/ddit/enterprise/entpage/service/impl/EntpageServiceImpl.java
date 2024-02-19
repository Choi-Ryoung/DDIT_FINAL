package kr.or.ddit.enterprise.entpage.service.impl;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enterprise.entpage.mapper.IEntpageMapper;
import kr.or.ddit.enterprise.entpage.service.IEntpageService;
import kr.or.ddit.vo.EnterpriseMemberVO;


@Service
public class EntpageServiceImpl implements IEntpageService {
	
	@Inject
	private IEntpageMapper  eaMapper;
	

	@Override
	public EnterpriseMemberVO getEntAccount(String entmemberId) {
		
		EnterpriseMemberVO entmember = eaMapper.getEntAccount(entmemberId);
		return entmember;
	}

	
	@Override
	public EnterpriseMemberVO getEntManage(String entmemberId) {
		EnterpriseMemberVO entmember = eaMapper.getEntManage(entmemberId);
		return entmember;
	}
	
	

	@Override
	public int entManageUpdate(HttpServletRequest req, EnterpriseMemberVO entmemberVO) {
		
		//프로필 기업로고 업로드 위한 서버 경로?
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		File file = new File(uploadPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String profileImg ="";
		try {
			MultipartFile proFileImgFile = entmemberVO.getEntFile();
			
			if(proFileImgFile != null && proFileImgFile.getOriginalFilename() != null && !proFileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); //uuid파일명생성
				uploadPath += "/" + fileName;
				proFileImgFile.transferTo(new File(uploadPath));	
				profileImg = "/resources/profile/" + fileName;
				
			}
			entmemberVO.setLogoImg(profileImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return eaMapper.entManageUpdate(entmemberVO);
	}


	@Override
	public EnterpriseMemberVO getEntAccountAll(String entmemberId) {
		// TODO Auto-generated method stub
		return eaMapper.getEntAccountAll(entmemberId);
	}


	@Override
	public int entAccountUpdate(HttpServletRequest req, EnterpriseMemberVO entmemberVO) {
		   int status = eaMapper.entAccountUpdate(entmemberVO);
		    
		    return status;
	}


}
