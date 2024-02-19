package kr.or.ddit.member.login.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.login.mapper.ILoginMapper;
import kr.or.ddit.member.login.service.ILoginService;
import kr.or.ddit.vo.EnterpriseMemberVO;
import kr.or.ddit.vo.PrivateMemberVO;


@Service
public class LoginServiceImpl implements ILoginService {

    @Inject
    private ILoginMapper loginMapper; // 실제 프로젝트에서는 Mapper 인터페이스를 주입받아 사용합니다.

    @Override
    public boolean registerMember(PrivateMemberVO memberVO) {
        try {
            // 중복 아이디 체크
            if (checkDuplicateId(memberVO.getPrMbrId())) {
                return false; // 중복된 아이디이므로 회원가입 실패
            }

            // Mapper를 이용하여 회원 정보를 데이터베이스에 저장
            int result = loginMapper.signup(memberVO);

            // 결과에 따라 회원가입 성공 여부 반환
            return result > 0;
        } catch (Exception e) {
            // 예외 처리 - 로깅 등을 수행하거나 사용자에게 에러 메시지를 전달할 수 있음
            e.printStackTrace();
            return false;
        }
    }
   /* @Override
    public boolean registerEntMember(EnterpriseMemberVO entmemberVO) {
    	try {
    		// 중복 아이디 체크
    		if (checkDuplicateEntId2(entmemberVO.getEntMbrId())) {
    			return false; // 중복된 아이디이므로 회원가입 실패
    		}
    		
    		// Mapper를 이용하여 회원 정보를 데이터베이스에 저장
    		int result = loginMapper.entsignup(entmemberVO);
    		
    		// 결과에 따라 회원가입 성공 여부 반환
    		return result > 0;
    	} catch (Exception e) {
    		// 예외 처리 - 로깅 등을 수행하거나 사용자에게 에러 메시지를 전달할 수 있음
    		e.printStackTrace();
    		return false;
    	}
    }*/

    @Override
    public boolean checkDuplicateEntId2(String entId) {
    	System.out.println("기업"+entId);
    	try {
    		// Mapper를 이용하여 중복 아이디 체크
    		return loginMapper.selectOverlappedEntID(entId) > 0;
    	} catch (Exception e) {
    		// 예외 처리 - 로깅 등을 수행하거나 사용자에게 에러 메시지를 전달할 수 있음
    		e.printStackTrace();
    		return false;
    	}
    }
    @Override
    public boolean checkDuplicateId(String memId) {
        try {
            // Mapper를 이용하여 중복 아이디 체크
            return loginMapper.selectOverlappedID(memId) > 0;
        } catch (Exception e) {
            // 예외 처리 - 로깅 등을 수행하거나 사용자에게 에러 메시지를 전달할 수 있음
            e.printStackTrace();
            return false;
        }
    }
    
	@Override
	public boolean checkDuplicateNick(String memNickNm) {
		try {
			return loginMapper.selectOverlappedNick(memNickNm) >0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

    

	@Override
    public int entinsertMember(EnterpriseMemberVO entmemberVO, HttpServletRequest req) {
    	String goPage = "";
    	String uploadPath = req.getServletContext().getRealPath("/resources/profile");
    	File file = new File(uploadPath);
    	if(!file.exists()) {
    		file.mkdirs();
    	}
    	String proFileImg = ""; //기업회원정보에 추가될 프로필 이미지 경로
		try {
			// 넘겨받은 회원정보에서 파일 데이터 가져오기
			MultipartFile proFileImgFile = entmemberVO.getEntFile();
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(proFileImgFile != null && !proFileImgFile.isEmpty()/*proFileImgFile.getOriginalFilename() != null && !proFileImgFile.getOriginalFilename().equals("")*/) {
				String fileName = UUID.randomUUID().toString();		// UUID 파일명 생성
				fileName += "_" + proFileImgFile.getOriginalFilename();	// UUID_원본파일명으로 파일명 생성
				//uploadPath += "/" + fileName;	// /resources/profile/uuid_원본파일명
				 String filePath = uploadPath + File.separator + fileName;  // /resources/profile/uuid_원본파일명
		            
		         proFileImgFile.transferTo(new File(filePath));  // 해당 위치에 파일 복사
				//proFileImgFile.transferTo(new File(uploadPath));	// 해당 위치에 파일복사
				proFileImg = "/resources/profile/" + fileName;		// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			entmemberVO.setLogoImg(proFileImg);
		}catch(Exception e) {
			e.printStackTrace();
		}
    	
    	return loginMapper.entinsertMember(entmemberVO);
    }
	@Override
	public int insertMember(PrivateMemberVO memberVO) {
		// TODO Auto-generated method stub
		return loginMapper.insertMember(memberVO);
	}

	@Override
	public PrivateMemberVO selectMember(String prMbrId, String prMbrPswd) {
		Map<String, Object> params = new HashMap<>();
		params.put("prMbrId", prMbrId);
		params.put("prMbrPswd", prMbrPswd);
		return loginMapper.selectNormalMember(params);
	}

	@Override
	public EnterpriseMemberVO selectentMember(String id, String pw) {
		Map<String, Object> params = new HashMap<>();
		params.put("entMbrId", id);
		params.put("entMbrPswd", pw);
		return loginMapper.selectentMember(params);
	}
	@Override
	public int updateStopStatus(String id) {
		return loginMapper.updateStopStatus(id);
	}
	@Override
	public int updateEntStopStatus(String id) {
		return loginMapper.updateEntStopStatus(id);
	}
	
	//일반회원 아이디찾기
	@Override
	public PrivateMemberVO findMemberId(Map<String, Object> map) {
		return loginMapper.findMemberId(map);
	}
	
	//일반회원 비밀번호 찾기
	@Override
	public void updateMemberPw(Map<String, Object> map) {
		loginMapper.updateMemberPw(map);
	}
	
	//일반회원 아이디 찾기
	@Override
	public EnterpriseMemberVO findEntId(Map<String, Object> map) {
		return loginMapper.findEntId(map);
	}

	@Override
	public void updateEntPw(Map<String, Object> map) {
		loginMapper.updateEntPw(map);
	}

	@Override
	public String selectEntId(Map<String, Object> map) {
	 return	loginMapper.selectEntId(map);
	}

	@Override
	public int selectSSId(String id) {
		System.out.println("idddddddddd" + id);
		return	loginMapper.selectSSId(id);
	}
	

	@Override
	public int insertSSMember(Map<String,String> pMap) {
		return  loginMapper.insertSSMember(pMap);
	}



	
		
	
}