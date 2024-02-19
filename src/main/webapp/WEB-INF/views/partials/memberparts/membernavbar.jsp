<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<style>
.dropdown-menu {
    padding: 0 !important;
}
#logoImg{
	width: 136px;
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
	                <h1 id="sh_top_logo"><a href="/"><img src="${ctxp}/resources/img/common/logo.png" alt="Sample" id="logoImg"/></a></h1>
	                <!-- sh_nav [s] -->
	                <ul id="sh_nav">
						<li class="menu-item">
	                        <a href="${ctxp}/employment/list">채용정보</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/employment/list">채용 공고</a></li>
	                            <li><a href="${ctxp}/employment/briefingList">채용 설명회</a></li>
	                            <li><a href="${ctxp}/member/jobAssist">취업도우미</a></li>
	                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="${ctxp}/mento/list">멘토링</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/mento/list">멘토 찾기</a></li>
	                            <li><a href="${ctxp}/mento/form">멘토 신청</a></li>
	                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="${ctxp}/member/enterpriseinfo/entReviewList">기업정보</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/member/enterpriseinfo/entReviewList">기업 리뷰</a></li>
	                            <li><a href="${ctxp}/member/enterpriseinfo/intReviewList">면접 후기</a></li>
	                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="${ctxp}/member/codingTestList">코딩테스트 연습</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/member/codingTestList">연습문제 조회</a></li>
	                            <li><a href="${ctxp}/member/myCodingTest">내 풀이 조회</a></li>
	                        </ul>
	                    </li>
	                    <li class="menu-item">
	                        <a href="">커뮤니티</a>
	                        <ul class="sh_nav_s">
	                            <li><a href="${ctxp}/notice/list.do">공지사항</a></li>
	                            <li><a href="${ctxp}/freeboard/list.do">자유게시판</a></li>
	                            <li><a href="${ctxp}/faq/list">FAQ</a></li>
	                            <li><a href="${ctxp}/answer/list.do">1:1문의</a></li>
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
		                    	<a href="${ctxp }/member/mypage/myInfo">${sessionScope.SessionInfo.prMbrNm }님, 환영합니다!</a>&nbsp;&nbsp;&nbsp;
	                		&nbsp;&nbsp;<a href="${ctxp}/member/logout">로그아웃</a>
	                		</c:if>
	                    </li>
	                </ul>
	                	</div>
	                </div>
	            </div>
	            <!-- sh_nav_wrap [e] -->
			</div>            
	    </div>
