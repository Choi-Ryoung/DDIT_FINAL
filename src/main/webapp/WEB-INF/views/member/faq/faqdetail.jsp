<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<body>
		<h2>DETAIL</h2>
		<hr/>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>${faqVO.faqPstTtl }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${faqVO.faqWrtrNm }</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td>${faqVO.faqWrtDt }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${faqVO.faqPstCn }</td>
			</tr>
		</table>
		<form action="/faq/delete" method="post" id="delForm">
			<input type="hidden" name="faqPstNo" value="${faqVO.faqPstNo }"/>
		</form>
		<input type="button" id="updateBtn" value="수정"/>
		<input type="button" id="deleteBtn" value="삭제"/>
		<input type="button" id="listBtn" value="목록"/>
</body>

<script type="text/javascript">
$(function(){
	var delForm = $("#delForm");
	var updateBtn = $("#updateBtn");
	var deleteBtn = $("#deleteBtn");
	var listBtn = $("#listBtn");
	
	updateBtn.on("click", function(){
		delForm.attr("method","get");
		delForm.attr("action","/faq/update");
		delForm.submit();
	});
	
	deleteBtn.on("click",function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			delForm.submit();
		}
	});
	
	listBtn.on("click",function(){
		location.href = "/faq/list";
	});
	
});

</script>
</html>