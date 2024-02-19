<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ctxp}/resources/css/button.css">
</head>
<body>
	<p>큰거</p>
	<button class="button button-antiman button-size-lg button-text-lg">button</button>
	<button class="button button-antiman button-size-md button-text-md">button</button>
	<button class="button button-antiman button-size-sm button-text-sm">button</button>
	
	<p>중간거</p>
	<button class="button button-antiman-2 button-text-lg button-size-lg">button</button>
	<button class="button button-antiman-2 button-text-md button-size-md">button</button>
	<button class="button button-antiman-2 button-text-sm button-size-sm">button</button>
	
	<p>작은거</p>
	<button class="button button-antiman-3 button-size-lg button-text-lg">button</button>
	<button class="button button-antiman-3 button-size-md button-text-md">button</button>
	<button class="button button-antiman-3 button-size-sm button-text-sm">button</button>
</body>
</html>