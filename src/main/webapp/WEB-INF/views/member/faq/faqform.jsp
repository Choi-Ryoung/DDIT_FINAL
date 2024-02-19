<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<body>
	<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>
		
	</c:if>
		<h2>${name }</h2>
		<hr/>
		<form action="/faq/insert" method="post" id="insertForm">
			<c:if test="${status eq 'u' }">
				<input type="hidden" name="faqPstNo" value="${faqVO.faqPstNo }"/>
			</c:if>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="faqPstTtl" id="faqPstTtl" value="${faqVO.faqPstTtl }"/>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="faqWrtrNm" id="faqWrtrNm" value="${faqVO.faqWrtrNm }"/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="10" cols="40" name="faqPstCn" id="faqPstCn" >${faqVO.faqPstCn }</textarea>
				</td>
			</tr>
		</table>
		<input type="button" id="insertBtn" value="${name }"/>
		<c:if test="${status eq 'u' }"></c:if>
		<input type="button" id="cancelBtn" value="취소"/>
		<c:if test="${status ne 'u' }"></c:if>
		<input type="button" id="listBtn" value="목록"/>
		</form>
</body>
<script type="text/javascript">
$(function(){
	var insertForm = $("#insertForm");
	var insertBtn = $("#insertBtn");
	var listBtn = $("#listBtn");
	
	insertBtn.on("click",function(){
		var title = $("#faqPstTtl").val();
		var writer = $("#faqWrtrNm").val();
		var content = $("#faqPstCn").val();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(writer == null || writer == ""){
			alert("작성자를 입력해주세요");
			return false;
		}
		if(content == null || content == ""){
			alert("내용을입력해주세요.");
			return false;
		}
		if($(this).val() == "수정"){
			insertForm.attr("action", "/faq/update");
		}
		
		insertForm.submit();
	});
	listBtn.on("click",function(){
		location.href = "/faq/list";
	});
});
</script>
</html>