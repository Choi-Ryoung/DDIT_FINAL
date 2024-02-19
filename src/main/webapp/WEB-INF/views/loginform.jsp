<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ctxp}/resources/js/jquery-ui.js"></script>
<script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
<script src="${ctxp}/resources/js/jquery.easing.min.js"></script>
<script src="${ctxp}/resources/js/topmenu_script.js"></script>
<script src="${ctxp}/resources/js/swiper.min.js"></script>
<link rel="stylesheet" href="${ctxp}/resources/css/loginform.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
</head>
<style>

  .loginBtn,
  .registerBtn {
    width: 48% !important;
  }


.button-link{
	margin-left: 15%;
	color: green;
}
#bgBox {
	height: 130vh;
    width: 100%;
	overflow: hidden;
    box-sizing: border-box;
    z-index: 11;
    position: relative;
    top: 0;
    left: 0;
    pointer-events: none;
}
.login-wrapper{
	z-index: 11;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
}
</style>
<body style="overflow:hidden !important;">
<div id="bgBox">
	<iframe id="youtube" width="100%" height="100%" 
		src="https://www.youtube.com/embed/PgGZN9hGXK8?si=5n3INSP1j9n8WE88&amp;controls=0&autoplay=1&mute=1&amp;" 
		title="YouTube video player" 
		frameborder="0" 
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
		 allowfullscreen>
	 </iframe>

</div>
  <div class="login-wrapper">
    <h2>Login</h2>
    
	<form method="post" action="/member/login.do" id="login-form">
        <label>
            <input type="radio" name="membership" value="normal" checked="checked">
            	일반회원
        </label>

        <label>
            <input type="radio" name="membership" value="business">
           	 기업회원
        </label>
    	<a id="findLink" class="button-link" href="/member/ForgetIdAndPw">아이디&비밀번호 찾기</a>
        <input id="memId" name="id" placeholder="id" >
        <input id="memPw" type="password" name="pw" placeholder="Password">
        <font color="red" id="errMsg" style="font-size:18px;"></font><br/>
	   <!--  <label for="remember-check">
			<input type="checkbox" id="remember-check">&nbsp&nbsp아이디 저장하기
		</label> -->
		<input type="button" class="loginBtn" value="로그인" id="loginBtn">
		<input type="button" class="registerBtn" value="회원가입" onclick="fn_register()" id="registerBtn"><br>
			

				<div class="social-group">
					 <div id="naver_id_login"></div>
				</div>

				<span class="mb-1" id="findIdPwBtn">
				
				</span>
			<!-- 네이버 로그인 -->
			
    </form>
			 
  </div>
</body>

<script>

var YT = {
        PlayerState: { ENDED: 0, PLAYING: 1 }
    };

    function onYouTubeIframeAPIReady() {
        var player = new YT.Player('youtube');

        player.addEventListener('onStateChange', function(e) {
            if (e.data === YT.PlayerState.ENDED || e.data === YT.PlayerState.PLAYING) {
                player.seekTo(0);
            }
        });

        var stopTime = 39; // 정지 시간(초)
        setInterval(function() {
            var currentTime = player.getCurrentTime();
            if (currentTime >= stopTime) {
                player.pauseVideo();
            }
        }, 1000); // 1초마다 체크
    }


$(function(){
	var loginBtn = $("#loginBtn");
	var loginForm = $("#login-form");
	var naverLoginDiv = $(".social-group");
	

	loginBtn.on("click",function(){
		var id = $("#memId").val();
		var pw = $("#memPw").val();
		
		if(id == null || id == ""){
			$("#errMsg").text("아이디를 입력해주세요.");
			return false;
		}
		
		if(pw == null || pw == ""){
			$("#errMsg").text("비밀번호를 입력해주세요.");
			return false;
		}
		
		loginForm.submit();

	});
	
	
	 // 라디오 버튼 변경 이벤트
    $('input[name="membership"]').on('change', function() {
        updateFindLink();
        updateNaverLoginVisibility();
    });

    // 초기 페이지 로딩시 한 번 실행
    updateFindLink();
    updateNaverLoginVisibility()
    function updateFindLink() {
        var selectedMembership = getSelectedMembership();

        // "아이디&비밀번호 찾기" 링크 업데이트
        var findLink = $("#findLink");
        if (selectedMembership === "normal") {
            findLink.attr('href', '/member/ForgetIdAndPw');
        } else if (selectedMembership === "business") {
            // 기업회원에 대한 URL 설정
            findLink.attr('href', '/member/entForgetIdAndPw');
        }
  	  }
    
	function updateNaverLoginVisibility() {
	    var selectedMembership = getSelectedMembership();
	    // 기업회원이면 네이버 로그인 버튼을 숨깁니다.
	    if (selectedMembership === "business") {
	        naverLoginDiv.hide();
	    } else {
	        naverLoginDiv.show();
	    }
	}
	function getSelectedMembership() {
        var radios = document.getElementsByName('membership');
        var selectedMembership;

        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                selectedMembership = radios[i].value;
                break;
            }
        }
        
        return selectedMembership;
    }	
});

	var registerBtn = $('#registerBtn');
	registerBtn.on('click', function(){
		location.href = "signup";
	});
	
	
	

	
	//네이버 아이디로 로그인을 처리하는 객체를 생성합니다
	//괄호안에 첫번째 클라이언트  id  , 두번째 네이버 로그인후 리다이렉트될 URL로 설정
	var naver_id_login = new naver_id_login("byJHAZYSGyUodPqo2Y10", "http://192.168.36.103/member/login/oauth2/code/naver");
	//네이버 로그인에서 사용하는 보안을 강화하기 위해 사용되는 고유ㅜ한 상태정보를 얻어옵니다.
	var state = naver_id_login.getUniqState();
	
    naver_id_login.setButton("red", 2,40);
    //로그인 처리ㅏ 도메인을 설정
    //일반적으로 서버의 도메인을 여기에 설정합니다
    naver_id_login.setDomain("http://192.168.36.103/member/social/");
    
    naver_id_login.setState(state);
    //앞서 얻어온 고유한 상태 정보를 설정합니다
    
    naver_id_login.setPopup();
    //로그인 창을 팝업 형태로 띄우도록 설정합니다
    
    naver_id_login.init_naver_id_login();
    //네이버 아이디로 로그인 초기화를 수행합니다.
    //설정된 옵션들을 적용하고, 실제로 네이버 로그인 기능을 활성화 합니다

	</script>
</html>