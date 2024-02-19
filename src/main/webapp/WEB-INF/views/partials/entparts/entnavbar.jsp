<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<style>
.msg {
    position: absolute;
    top: 28px;
    /* top: 68px;
    right: 360px; */
    z-index: 2;
}
.msg a {
	color: red;
	animation: animate 2s infinite;
	transform-origin: center;
}

#logoImg{
	width: 136px;
}

@keyframes animate {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.15);
  }
  100% {
    transform: scale(1);
  }
}
</style>

<div id="container">
	<!-- sh_wrapper [s] -->
	<div id="sh_wrapper">
	    <!-- sh_hd [s] -->
	    <div id="sh_hd">
	        <div class="top_nav_bg"></div>
	    	<div id="sh_hd_wrapper">
	            <!-- sh_nav_wrap [s] -->
	            <div id="sh_nav_wrap">	
	            
	            
					
	                <h1 id="sh_top_logo"><a href="/ent"><img src="${ctxp}/resources/img/common/logo.png" alt="Sample" id="logoImg"/></a></h1>
	                <!-- sh_nav [s] -->
	                <ul id="sh_nav">
						<li class="menu-item">
	                        <a href="${ctxp}/announcement/list">공고 관리</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/announcement/list">채용 공고</a></li>
	                            <li><a href="${ctxp}/briefing/list">채용 설명회</a></li>
	                            <li><a href="${ctxp}/announcement/list">지원자 관리</a></li>
	                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="/search/searchdutylist">인재 찾기</a>
		                        <ul class="sh_nav_s">
		                            <li><a href="/search/searchdutylist">직무별 검색</a></li>
		                            <li><a href="/search/searchcareerlist">경력별 검색</a></li>
		                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="${ctxp}/ent/codingTest">코딩테스트</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/ent/codingTest">코딩테스트 조회</a></li>
	                            <li><a href="${ctxp}/ent/registerEntCodingTest">코딩테스트 등록</a></li>
	                        </ul>
	                    </li>
	    
	                    <li class="menu-item">
	                        <a href="${ctxp}/ent/freeboardlist">커뮤니티</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/ent/noticelist">공지사항</a></li>
	                            <li><a href="${ctxp}/ent/freeboardlist">자유게시판</a></li>
	                            <li><a href="${ctxp}/ent/freeboardlist">FAQ</a></li>
	                            <li><a href="${ctxp}/ent/freeboardlist">1:1문의</a></li>
	                        </ul>
	                    </li>
	                </ul>
	                <!-- sh_nav [e] -->
      				 <ul id="sh_nav_ex">
	                	<li class="loginBtn">
		                	<c:if test="${empty sessionScope.SessionInfo }">
		                    	<a href="${ctxp}/member/loginform">로그인/회원가입</a>
		                	</c:if>
		                	<c:if test="${not empty sessionScope.SessionInfo }">
		                		<a href="${ctxp}/ent/entpage/entAccount">${sessionScope.SessionInfo.entNm }님, 환영합니다</a>&nbsp;&nbsp;&nbsp;
								<!-- <span id="bell">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
								  		<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z" />
									</svg>
								</span> -->
								<!-- 메시지 -->
								<p class="msg" style="display: none;"><a href="${ctpx}/announcement/list">새로운 지원자가 있습니다.</a></p>
								<span id="redbell" style="display: none;">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-bell-fill" viewBox="0 0 16 16">
									  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
									</svg>
								</span>	
		             
		                		&nbsp;&nbsp;<a href="${ctxp}/member/logout" style="z-index: 100;">로그아웃</a>
		                	</c:if>
	                    </li>
	                </ul>
	            </div>
	            <!-- sh_nav_wrap [e] -->
			</div>            
	    </div>
	</div>    <!-- sh_hd [e] -->
</div>   

<script>
function timer() {    
	$.ajax({
	    type: "POST",
	    url: "/apply/newBell",
	    success: function (res) {
	    	if(res.length == 0){
		    	$("#redbell").css("display", "none");
		    	$(".msg").css("display", "none");
	    	} else if(res.length > 0) {
		    	$("#redbell").css("display", "block");
		    	$(".msg").css("display", "block");
	    	};
	    },
		error: function () {
			console.log("서버 오류 발생. 다시 시도해주세요.");
	    }
  	});
}
timer();
setInterval(timer, 1000); 
</script>