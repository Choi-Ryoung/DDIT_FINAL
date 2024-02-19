<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
<script src="${ctxp}/resources/js/jquery.easing.min.js"></script>

		<header class="navbar sticky-top bg-dark flex-md-nowrap p-0 shadow" data-bs-theme="dark">
			<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6 text-white" href="/admin/main">H I T</a>
			
			<ul class="navbar-nav flex-row d-md-none">
				<li class="nav-item text-nowrap">
					<button class="nav-link px-3 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSearch" aria-controls="navbarSearch" aria-expanded="false" aria-label="Toggle search">
						<svg class="bi"><use xlink:href="#search"/></svg>
					</button>
				</li>
				<li class="nav-item text-nowrap">
					<button class="nav-link px-3 text-white" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
						<svg class="bi"><use xlink:href="#list"/></svg>
					</button>
				</li>
			</ul>
			<div id="navbarSearch" class="navbar-search w-100 collapse">
				<input class="form-control w-100 rounded-0 border-0" type="text" placeholder="Search" aria-label="Search">
			</div>
		<span class="greeting" style="color:white">관리자님, 환영합니다.</span>
			<button type="button" class="btn btn-primary logoutBtn" id="adminLogout" >로그아웃</button>
			<%-- <c:if test="${not empty sessionScope.SessionInfo }">
		                    	${sessionScope.SessionInfo.adminId }님, 환영합니다!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${ctxp}/admin/logout">로그아웃</a>
	                		</c:if> --%>
			
		</header>
		
<script type="text/javascript">
  $(function(){
	  var adminLogout = $("#adminLogout");
	  
    $("#adminLogout").on("click", function(){
      // 서버에 로그아웃 요청을 보낼 수 있습니다.
      // 여기서는 단순히 로그인 페이지로 리다이렉트하는 예시입니다.
      window.location.href = "/admin/logout";
    });
  });
</script>