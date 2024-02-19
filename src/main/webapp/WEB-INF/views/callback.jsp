<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	접근정보
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("byJHAZYSGyUodPqo2Y10",
				"http://192.168.36.103/member/login/oauth2/code/naver");
		
		


		// 접근 토큰 값 출력
		//alert(naver_id_login.oauthParams.access_token);
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");

		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			var prMbrId = naver_id_login.getProfileData('email');
			var prMbrEmail = naver_id_login.getProfileData('email');
			var prMbrPswd = naver_id_login.oauthParams.access_token;
			var prMbrNm = naver_id_login.getProfileData('name');
			var prMbrNcnm = naver_id_login.getProfileData('nickname');
			var prMbrBirthdy = naver_id_login.getProfileData('birthday');
			var prMbrTelno = naver_id_login.getProfileData('mobile');

			var data = {
				prMbrId : prMbrId,
				prMbrEmail : prMbrEmail,
				prMbrNm : prMbrNm,
				prMbrPswd : prMbrPswd,
				prMbrNcnm : prMbrNcnm,
				prMbrBirthdy : prMbrBirthdy,
				prMbrTelno : prMbrTelno
			}

			$.ajax({
				type : "post",
				url : "/member/socialLogin",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success : function(res){
					if(res >0){
						console.log("계정있음 바로 로그인진행시켜!");
						console.log(prMbrNm)
						
						// 로그인 된 화면으로 이동 시키기
						
						window.opener.location.href = "http://192.168.36.103/member" ;  // opener  나를 열어 준 창을 가리킴!
						// naver 팝업 끄는 거 찾기
						window.close();						
					}else{
						console.log("계정없음 가입 시켜 ");
						naverMemberInit(prMbrId,prMbrEmail,prMbrPswd,prMbrNcnm,prMbrNm,prMbrBirthdy,prMbrTelno);
						
					}
				}
			});

		}

		function naverMemberInit(prMbrId,prMbrEmail,prMbrPswd,prMbrNcnm,prMbrNm,prMbrBirthdy,prMbrTelno) {
			
			var data = {
					prMbrId : prMbrId,
					prMbrEmail : prMbrEmail,
					prMbrPswd : prMbrPswd,
					prMbrNcnm : prMbrNcnm,
					prMbrNm : prMbrNm,
					prMbrBirthdy : prMbrBirthdy,
					prMbrTelno : prMbrTelno
				}

				$.ajax({
					type : "post",
					url : "/member/socialCreateUser",
					data : JSON.stringify(data),
					contentType : "application/json;charset=utf-8",
					success : function(res){
						if(res >0){
							
							// naver 팝업 끄는 거 찾기
							window.location.href = "http://192.168.36.103/member"
							window.close();
							// 로그인 된 화면으로 이동 시키기
							console.log("가입 성공 ");
						}else{
							console.log("가입 실패 ");
						}
					}
				});			
		}
	</script>
</body>
</html>