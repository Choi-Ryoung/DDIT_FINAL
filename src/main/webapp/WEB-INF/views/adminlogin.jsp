<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
	<script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
	<script src="${ctxp}/resources/js/jquery.easing.min.js"></script>
	<script src="${ctxp}/resources/js/swiper.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>

</head>
<body>

<div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      
        <h2 class="text-center text-dark mt-5">Admin Login</h2>
        <div class="card my-5">
		
			
          <form action="/admin/login.do" method="post" id="loginForm" class="card-body cardbody-color p-lg-5">
			
            <div class="mb-3">
              <input type="text" class="form-control" id="adminId" name="adminId" aria-describedby="emailHelp"
                placeholder="admin Name">
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" id="adminPswd" name="adminPswd" placeholder="password">
            </div>
            <div class="text-center">
            <button type="button" id="LoginBtn"  class="btn btn-color px-5 mb-5 w-100">Login</button>
            </div>
            <div id="emailHelp" class="form-text text-center mb-5 text-dark">
            </div>
          </form>
        </div>

      </div>
    </div>
  </div>
  
  <script type="text/javascript">
  $(function(){
    var LoginBtn = $("#LoginBtn"); // "$"를 추가하여 올바른 선택기를 사용
    var loginForm = $("#loginForm");
    
    LoginBtn.on("click", function(){
      var id = $("#adminId").val();
      var pw = $("#adminPswd").val();
      
      if(id == null || id ==""){
        alert("아이디를 입력하세요");
        return false;
      }
      if(pw == null || pw == ""){
        alert("비밀번호를 입력하세요");
        return false;
      }
      
      loginForm.submit();
    });
  });
</script>
  
</body>
</html>