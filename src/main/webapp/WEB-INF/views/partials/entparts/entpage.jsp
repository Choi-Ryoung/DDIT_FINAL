<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <!-- 반응형 [s] -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="imagetoolbar" content="no">
    <!-- 반응형 [e] -->
    <meta name="naver-site-verification" content=""/><!-- 네이버 소유확인 -->
    <meta name="description" content=""><!-- 사이트 설명문구 -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="HIT">
    <meta property="og:description" content=""><!-- 사이트 설명문구 -->
    <meta property="og:image" content="${ctxp}/resources/img/common/logo.png">
    <meta property="og:url" content="">
	<title>HIT</title>
    <script src="${ctxp}/resources/js/jquery-ui.js"></script>
    <script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
    <script src="${ctxp}/resources/js/jquery.easing.min.js"></script>
    <script src="${ctxp}/resources/js/topmenu_script.js"></script>
    <script src="${ctxp}/resources/js/swiper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${ctxp}/resources/css/swiper.min.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_common.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_main.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/cr_add.css">
</head>
<body>
	   <tiles:insertAttribute name="navbar"/>
       <tiles:insertAttribute name="entcontent"/>
       <tiles:insertAttribute name="footer"/>

	</body> 
		</html>