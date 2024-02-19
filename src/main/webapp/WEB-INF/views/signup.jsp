<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
<style type="text/css">
body{
    background-color: #dee9ff;
}

.registration-form{
	padding: 50px 0;
}

.registration-form form{
    background-color: #fff;
    max-width: 600px;
    margin: auto;
    padding: 50px 70px;
    border-top-left-radius: 30px;
    border-top-right-radius: 30px;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
}

.registration-form .form-icon{
	text-align: center;
    background-color: #5891ff;
    border-radius: 50%;
    font-size: 40px;
    color: white;
    width: 100px;
    height: 100px;
    margin: auto;
    margin-bottom: 50px;
    line-height: 100px;
}

.registration-form .item{
	border-radius: 20px;
    margin-bottom: 25px;
    padding: 10px 20px;
}

.registration-form .create-account{
    border-radius: 30px;
    padding: 10px 20px;
    font-size: 18px;
    font-weight: bold;
    background-color: #5791ff;
    border: none;
    color: white;
    margin-top: 20px;
}

.registration-form .social-media{
    max-width: 600px;
    background-color: #fff;
    margin: auto;
    padding: 35px 0;
    text-align: center;
    border-bottom-left-radius: 30px;
    border-bottom-right-radius: 30px;
    color: #9fadca;
    border-top: 1px solid #dee9ff;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
}

.registration-form .social-icons{
    margin-top: 30px;
    margin-bottom: 16px;
}

.registration-form .social-icons a{
    font-size: 23px;
    margin: 0 3px;
    color: #5691ff;
    border: 1px solid;
    border-radius: 50%;
    width: 45px;
    display: inline-block;
    height: 45px;
    text-align: center;
    background-color: #fff;
    line-height: 45px;
}

.registration-form .social-icons a:hover{
    text-decoration: none;
    opacity: 0.6;
}

@media (max-width: 576px) {
    .registration-form form{
        padding: 50px 20px;
    }

    .registration-form .form-icon{
        width: 70px;
        height: 70px;
        font-size: 30px;
        line-height: 70px;
    }
}

#sexdstnCd{
	height: 45px;
}
.button-container{
	margin-left: 45%;
	margin-top: 3%;
}


</style>
</head>
<body>
	
        
    	<div class="button-container">
			<button type="button" id="normalBtn" name="membership" onclick="showForm('normalForm')" class="btn btn-primary btn-sm">일반회원가입</button>
			<button type="button" id="businessBtn" name="membership" onclick="showForm('businessForm')" class="btn btn-primary btn-sm">기업회원가입</button>
		</div>
    <div class="registration-form">
    		<!-- 일반회원 -->
	 <form action="/member/signup.do" method="POST" id="normalForm" class="joinForm">
	 	<h2>일반회원</h2>
	       <div class="form-group">
	           <input type="text" id="memId" name="prMbrId" class="form-control item"  placeholder="아이디" value="${memberVO.prMbrId }">
	       </div>
		    <span class="input-group-append">
	            <button type="button" id="idCheckBtn" name="prMbrId" class="btn btn-primary btn-sm"  >중복확인</button>
	        </span><br>
	       <div class="form-group">
	           <input type="password" class="form-control item" id="memPw" name="prMbrPswd" placeholder="비밀번호">
	       </div>
	       <div class="form-group">
	           <input type="password" class="form-control item" id="memPw2" name="prMbrPswdConfirm" placeholder="비밀번호확인">
	           <font color="red" id="errMsg" style="font-size:18px;"></font><br/>
	       </div>
	       <div class="form-group">
	           <input type="text" class="form-control item" id="memName" name="prMbrNm" placeholder="이름">
	       </div>
	       <div class="form-group">
	           <input type="text" class="form-control item" id="memNickNm" name="prMbrNcnm" placeholder="닉네임">
	           <button type="button" class="btn btn-primary btn-sm" id="nickCheckBtn" >중복확인</button>
	       </div>
	       <div class="form-group">
	           <input type="text" class="form-control item" name="prMbrTelno" id="memTelNo" placeholder="전화번호">
	       </div>
	       <div class="form-group">
	           <input type="text" class="form-control item" name="prMbrEmail" id="memEmail" placeholder="이메일">
	       </div>
	        <div class="textForm">
	            <div class="icheck-primary d-inline">
		            <select id="sexdstnCd" name = "sexdstnCd" class="form-control item" aria-label="Default select example">
			        		<option selected>성별</option>
			        	<c:forEach items="${genderList}" var="genderVo" varStatus="vs">
			        		<option value="${genderVo.cmcd}">${genderVo.cmcdNm}</option>
			            </c:forEach>
		        	</select>
	            </div>
	        </div>
	       <div class="form-group">
	           <input type="date" id="memBir" name="prMbrBirthdy" class="form-control item"  placeholder="생년월일" value="${memberVO.prMbrBirthdy }">
	       </div>

			<div class="form-group">
				<span class="input-group-append">
					<button type="button" class="btn btn-primary btn-sm" onclick="DaumPostcode1()">우편번호 찾기</button>
				</span> 
				<input type="text" id="prMbrZip" name="prMbrZip" class="form-control item" placeholder="우편번호" readonly>
			</div>
			<div class="form-group">
				<input name="prMbrBscAddr" type="text" class="form-control item" id="prMbrBscAddr" placeholder="기본주소" readonly>
			</div>
			<div class="form-group">
				<input name="prMbrDaddr" type="text" class="form-control item" id="prMbrDaddr" placeholder="상세주소">
			</div>
			<div class="form-group">
				<input name="trmsAgreCd" type="checkbox" class="trmsAgreCd" id="trmsAgreCd" value="Y"> 
				<label for="trmsAgreCd">개인정보처리방침</label>
			</div>


	       <button type="button" id="autoBtn1" class="btn btn-outline-info">자동완성</button>
			<div class="form-group">
	           <input type="button" class="btn btn-block create-account" id="signupBtn" value="회원가입"/>
	       </div>
<!-- 	   <div class="social-media">
	       <h5>소셜로그인</h5>
	       <div class="social-icons">
	           <a href="#"><i class="icon-social-" title="Facebook"></i></a>
	       </div>
	   </div> -->
	   </form>
        
        
        
        
        		<!-- 기업회원 -->
	        <form action="/member/entsignup.do" method="POST" id="businessForm" class="joinForm" enctype="multipart/form-data">
	        <h2>기업회원</h2>
	         <div class="text-center">
 				<img class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3" id="profileImg"
					 src="/resources/img/logo/개죽이.jpg" alt="profile"
					 style="width: 150px;"> 
			</div>
            <div class="input-group mb-3">
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="entFile" id="imgFile"> 
					<label class="custom-file-label" for="imgFile" >기업로고를 선택해주세요</label>
				</div>
			</div>
            <div class="form-group">
                <input type="text" id="entId" name="entMbrId" class="form-control item"  placeholder="아이디">
            </div>
	            <span class="input-group-append">
	           	 	<button type="button" class="btn btn-primary btn-sm" id="idCheckBtn2" >중복확인</button>
	        	</span><br>
            <div class="form-group">
                <input type="password" id="entPw" name="entMbrPswd" class="form-control item"  placeholder="비밀번호">
            </div>
            <div class="form-group">
                <input type="password" id="entPw2" name="entMbrPswdConfirm" class="form-control item"  placeholder="비밀번호 확인">
                	<font color="red" id="errMsg" style="font-size:18px;"></font><br/>
            </div>
            <div class="form-group">
                <input type="text" id="brno" name="brno" class="form-control item"  placeholder="사업자등록번호">
		       <!--  <button type="button" class="btn btn-primary btn-sm" id="brNoBtn">사업자등록번호</button> -->
            </div>
            <div class="form-group">
                <input type="text" id="entName" name="entNm" class="form-control item"  placeholder="기업명">
            </div>
            <div class="form-group">
                <input type="text" id="rprsvNm" name="rprsvNm" class="form-control item"  placeholder="대표자명">
            </div>
            
            <div class="form-group">
		        <select id="entSe" name = "entSe" class="form-group"  >
		        		<option selected value="0">기업구분</option>
		        		<option value="major company">대기업</option>
		        		<option value="mid company">중소</option>
		        		<option value="small company">소</option>
		        </select>
        	</div>
            
            <div class="form-group">
                <input type="text" id="entEmail" name="entMbrEmail" class="form-control item"  placeholder="이메일">
            </div>
            <div class="form-group">
                <input type="text" id="entTelNo" name="entRprsTelno" class="form-control item"  placeholder="전화번호">
            </div>
            <div class="form-group">
                <input type="text" id="entpTelNo" name="entPicTelno" class="form-control item"  placeholder="담당자 전화번호">
            </div>

			<div class="form-group">
				<span class="input-group-append">
					<button type="button" class="btn btn-primary btn-sm" onclick="DaumPostcode2()">우편번호 찾기</button>
				</span> 
					<input type="text" id="entZip" name="entZip" class="form-control item" placeholder="우편번호" readonly>
			</div>
			<div class="form-group">
				<input name="entBscAddr" type="text" class="form-control item" id="entBscAddr" placeholder="기본주소" readonly>
			</div>
			<div class="form-group">
				<input name="entDaddr" type="text" class="form-control item" id="entDaddr" placeholder="상세주소">
			</div>
			
	<!-- 		<div class="textForm">
	          <label for="scdPswdUseYn">2차비번을 사용할꺼에요? ㅠㅠㅠ</label>
					<input name="scdPswdUseYn" type="radio" class="scdPswdUseYn" id="scdPswdUseYn1" value="Y">
				<span id="label1">Y</span>
					<input name="scdPswdUseYn" type="radio" class="scdPswdUseYn" id="scdPswdUseYn2" value="N">
				<span id="label2">N</span>
	        </div> -->
	        
	        <div class="form-group">
				<input id="empCnt" name="empCnt"  type="text" class="form-control item"  placeholder="사원수">
			</div>
	        <div class="form-group">
				<input id="hmpgAddr" name="hmpgAddr"  type="text" class="form-control item"  placeholder="홈페이지주소">
			</div>
	        <div class="form-group">
	            <label for="bizCn">사업및소개</label>
				<textarea id="bizCn" name="bizCn" rows="4" cols="50"></textarea>
			</div>
	    <div class="form-group">
            <input name="trmsAgreCd" type="checkbox" class="trmsAgreCd" id="trmsAgreCd2" value="Y">
            <label for="trmsAgreCd">개인정보처리방침</label>
        </div>
			<button type="button" id="autoBtn2" class="btn btn-outline-info">자동완성</button>
			<div class="form-group">
                <button type="button" id="signupBtn2" class="btn btn-block create-account">기업 회원가입</button>
            </div>
        </form>
    </div>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script type="text/javascript">
			//선택폼 보이기
		function showForm(formId) {
			$("#businessForm").hide();
	        $("#normalForm").hide();
	        
	        $("#" + formId).show();
		}
		
		$(function(){
	    	
	    	$("#businessForm").hide();
	        $("#normalForm").show();
	//@@@@@@@@@@@@@@일반회원 가입폼@@@@@@@@@@@@@@@@@@@


	        
	    	var signupForm = $("#normalForm");	// 폼 태그 Element
	    	var signupBtn = $("#signupBtn");	// 가입하기 버튼 Element
	    	var idCheckBtn = $("#idCheckBtn");	// 중복확인 버튼 Element
	    	var nickCheckBtn = $("#nickCheckBtn"); //닉네임 중복화인 Element
	    	
	    	var idCheckFlag = false;			// 중복확인 flag
	    	var nickCheckFlag = false;			// 중복확인 flag
	    	
	    	
	    	var address2 = $("#address2");// 상세주소 Element
	    	
	    	 
	    	idCheckBtn.on("click",function(){
	            var id = $("#memId").val();
	            var idPattern = /^[a-zA-Z0-9]{6,20}$/;
	            
	            
	            
	            if (id == null || id == "") {
	                alert("아이디를 입력해주세요");
	                return false;
	            }
	            
	        	if (!idPattern.test(id)) {
	    		    alert("아이디는 영문자와 숫자로 이루어지며, 최소 6자 이상, 최대 20자 이하여야 합니다.");
	    		    return false;
	    		}
	         
	             
	             // AJAX를 이용하여 중복 아이디 체크 요청
	            $.ajax({
	                type: "GET",
	                url: "/member/checkDuplicateId",
	                data: { memId: id},
	                success: function (result) {
	                    if (result === "false") {
	                        alert("사용 가능한 아이디입니다.");
	                        idCheckFlag = true;	
	                    } else {
	                    	
	                        alert("이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
	                    }
	                },
	                error: function () {
	                    alert("서버 오류 발생. 다시 시도해주세요.");
	                }
	            });
	    	});
	    	
	    	

	    	

	    	nickCheckBtn.on("click", function () {
	    	    var nick = $("#memNickNm").val();
	    		var nickPattern =/^(?:(?=.*[가-힣]{2})|(?=.*[a-zA-Z]{4})|(?=.*[가-힣a-zA-Z\d]{2}))[가-힣a-zA-Z\d]+$/;

	    	    if (nick == null || nick == "") {
	    	        alert("닉네임을 입력해주세요");
	    	        return false;
	    	    }

	    	    if (!nickPattern.test(nick)) {
	    	        alert("닉네임은 한글 2글자 이상, 영문 4글자 이상, 숫자 4개 이상으로 이루어져야 합니다.");
	    	        return false;
	    	    }

	    	    // AJAX를 이용하여 중복 닉네임 체크 요청
	    	    $.ajax({
	    	        type: "GET",
	    	        url: "/member/checkDuplicateNick",
	    	        data: { memNickNm: nick },
	    	        success: function (result) {
	    	            if (result === "false") {
	    	                alert("사용 가능한 닉네임입니다.");
	    	                nickCheckFlag = true;
	    	            } else {
	    	                alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
	    	            }
	    	        },
	    	        error: function () {
	    	            alert("서버 오류 발생. 다시 시도해주세요.");
	    	        }
	    	    });
	    	});

	    	
	    	
	    	signupBtn.on("click",function(){
	    		// 아이디, 비밀번호, 이름까지만 일반적인 데이터 검증
	    		// 개인정보 처리방침 동의를 체크했을때만 가입하기가 가능하도록
	    		// 중복확인 처리가 true일때만 가입하기가 가능하도록
	        	var agreeFlag = false; 
	    		
	    		var memId = $("#memId").val();
	    		
	    		
	    		var memPw = $("#memPw").val();
	    		var memPw2 = $("#memPw2").val();
	    		var memName = $("#memName").val();
	    		var memNickNm = $("#memNickNm").val();
	    		var memTelNo = $("#memTelNo").val();
	    		var memEmail = $("#memEmail").val();
	    		var memBir = $("#memBir").val();
	    		var prMbrZip = $("#prMbrZip").val();
	    		
	    		
	    	
	    		
	   	       if (memId == null || memId == "") {
	                  alert("아이디를 입력해주세요");
	                  return false;
	              }
	    		
	   	       if (memPw == null || memPw == "") {
	 	                alert("비밀번호를 입력해주세요");
	 					return false;
	              }
	   	       if (memPw2 != memPw) {
	   	    	$("#errMsg").text("비밀번호가 맞지 않습니다.");
	 					return false;
	              }
	   	       if (memName == null || memName == "") {
	                  alert("이름을 입력해주세요");
	                  return false;
	              }   
	   	       if (memNickNm == null || memNickNm == "") {
	                  alert("닉네임을 입력해주세요");
	                 	console.log
	                  return false;
	              }   
	   	       if (memTelNo == null || memTelNo == "") {
	                  alert("전화번호를 입력해주세요");
	                  return false;
	              }   
	   	       if (memEmail == null || memEmail == "") {
	                  alert("이메일을을 입력해주세요");
	                  return false;
	              }   
	   	       if (memBir == null || memBir == "") {
	                  alert("생년월일을 입력해주세요");
	                  return false;
	              }   
	   	     
	   	       if (prMbrZip == null || prMbrZip == "") {
	                  alert("우편번호 찾기를 해주세요");
	                  return false;
	              }   
	   	       

	   	       //약관동의하면 Y  동의여부는 true로 설정
	   		var trmsAgreCd = $("#trmsAgreCd:checked").val();
			if(trmsAgreCd == "Y"){
				agreeFlag = true;
			}
			
			// 개인정보 처리방침을 동의했습니까?
			// 아이디 중복 체크를 이행하고 오셨습니까?
			// 오셨다구요? 그럼 가입하기를 진행하겠습니다.
			// 예? 안했다구요? 그럼 가입하기를 할 수 업습니다.
					
			if(agreeFlag){
				if(idCheckFlag){
					normalForm.submit();
				}else{
					alert("아이디 중복체크를 해주세요!");
				}
			}else{
				alert("개인정보 동의를 체크해주세요!");
			}
			

	    	});
	    	
	 //@@@@@@@@@@@@@@@@@@@@@@일반회원 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	 
	//@@@@@@@@@@@@@@@@@@@@@@@기업회원@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var imgFile = $("#imgFile");		// 파일선택 Element
	 
	     	var businessForm = $("#businessForm");	// 폼 태그 Element
	    	var signupBtn2 = $("#signupBtn2");	// 가입하기 버튼 Element
	    	var idCheckBtn2 = $("#idCheckBtn2");	// 중복확인 버튼 Element
	    	var idCheckFlag2 = false;			// 중복확인 flag
	    	
	    	//var entaddress = $("#entaddress");// 상세주소 Element
	    	
	    	
	    	idCheckBtn2.on("click",function(){
	            var id2 = $("#entId").val();
	            // var idPattern2 = /^[a-zA-Z0-9]{6,20}$/; 
	            
	            
	            if (id2 == null || id2 == "") {
	                alert("아이디를 입력해주세요");
	                return false;
	            }
	            
	        /*  	if (!idPattern2.test(id2)) {
	    		    alert("아이디는 영문자와 숫자로 이루어지며, 최소 6자 이상, 최대 20자 이하여야 합니다.");
	    		    return false;
	    		} 
	          */
	             
	             // AJAX를 이용하여 중복 아이디 체크 요청
	            $.ajax({
	                type: "GET",
	                url: "/member/checkDuplicateEntId2",
	                data: { entId: id2 },
	                success: function (result) {
	                    if (result === "false") {
	                        alert("사용 가능한 아이디입니다.");
	                        idCheckFlag2 = true;	
	                    } else {
	                    	
	                        alert("이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
	                    }
	                },
	                error: function () {
	                    alert("서버 오류 발생. 다시 시도해주세요.");
	                }
	            });
	    	});
	    	
	    	imgFile.on("change", function(event){
				
	    		var file = event.target.files[0];
	    		
	    		if(isImageFile(file)){
	    			var reader = new FileReader();
	    			reader.onload = function(e){
	    				$("#profileImg").attr("src", e.target.result);
	    			}
	    			reader.readAsDataURL(file);
	    			console.log("file : " + file);
	    			//file 전역
	    			
	    		}else{	// 이미지 파일이 아닐때
	    			alert("이미지 파일을 선택해주세요!");
	    		}
	    	});
	    	
	    	
	    	signupBtn2.on("click",function(){
	    		// 아이디, 비밀번호, 이름까지만 일반적인 데이터 검증
	    		// 개인정보 처리방침 동의를 체크했을때만 가입하기가 가능하도록
	    		// 중복확인 처리가 true일때만 가입하기가 가능하도록
	        	var agreeFlag2 = false; 
	    		var memId2 = $("#entId").val();
	    		var brno = $("#brno").val()
	    		
	    		var brnoPattern = /^\d{10}$/;
	    		
	    		/* 
	    		var memPw = $("#memPw").val();
	    		var memPw2 = $("#memPw2").val();
	    		var memName = $("#memName").val();
	    		var memNickNm = $("#memNickNm").val();
	    		var memTelNo = $("#memTelNo").val();
	    		var memEmail = $("#memEmail").val();
	    		var memBir = $("#memBir").val();
	    		var prMbrZip = $("#prMbrZip").val(); */
	    		
	   	       if (memId == null || memId == "") {
	                  alert("아이디를 입력해주세요");
	                  return false;
	              }
	    		
	    	if (!brnoPattern.test(brno)) {
		    	        alert("정규화된 사업자 번호가 아닙니다.");
		    	        return false;
		    	  }
	    		
	   	    /*    if (memPw == null || memPw == "") {
	 	                alert("비밀번호를 입력해주세요");
	 					return false;
	              }
	   	       if (memPw2 == null || memPw2 == "") {
	   	    	$("#errMsg").text("비밀번호가 맞지 않습니다.");
	 					return false;
	              } */
	   	     
	   	       //약관동의하면 Y  동의여부는 true로 설정
	   		var trmsAgreCd = $("#trmsAgreCd2:checked").val();
			if(trmsAgreCd == "Y"){
				agreeFlag2 = true;
			}
			
			// 개인정보 처리방침을 동의했습니까?
			// 아이디 중복 체크를 이행하고 오셨습니까?
			// 오셨다구요? 그럼 가입하기를 진행하겠습니다.
			// 예? 안했다구요? 그럼 가입하기를 할 수 업습니다.
					
			if(agreeFlag2){
				if(idCheckFlag2){
					businessForm.submit();
				}else{
					alert("아이디 중복체크를 해주세요!");
				}
			}else{
				alert("개인정보 동의를 체크해주세요!");
			}
	    		
	    	});
	    
	    	//@@@@@@기업회원@@@@@@@@@@@
	 	
	 
	 
	    });
		// 이미지 파일인지 체크
		function isImageFile(file){
			var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 가져옵니다.
			return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
		}
		
	        function DaumPostcode1() {
	            new daum.Postcode({
	                oncomplete: function(data) {
	                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                    var addr = ''; // 주소 변수
	                    var extraAddr = ''; // 참고항목 변수

	                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                        addr = data.roadAddress;
	                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                        addr = data.jibunAddress;
	                    }

	                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                    if(data.userSelectedType === 'R'){
	                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                            extraAddr += data.bname;
	                        }
	                        // 건물명이 있고, 공동주택일 경우 추가한다.
	                        if(data.buildingName !== '' && data.apartment === 'Y'){
	                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                        }
	                    
	                    } 

	                    
	                    document.getElementById('prMbrZip').value = data.zonecode;
	                    
	                    document.getElementById("prMbrBscAddr").value = addr;
	                    document.getElementById("prMbrDaddr").focus();
	                    
	                   
	                }
	            }).open();
	        }
	        
	        function DaumPostcode2() {
	            new daum.Postcode({
	                oncomplete: function(data) {
	                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                    var addr = ''; // 주소 변수
	                    var extraAddr = ''; // 참고항목 변수

	                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                        addr = data.roadAddress;
	                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                        addr = data.jibunAddress;
	                    }

	                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                    if(data.userSelectedType === 'R'){
	                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                            extraAddr += data.bname;
	                        }
	                        // 건물명이 있고, 공동주택일 경우 추가한다.
	                        if(data.buildingName !== '' && data.apartment === 'Y'){
	                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                        }
	                    
	                    } 

	                    
	                    
	                    
	                    document.getElementById('entZip').value = data.zonecode;
	                    
	                    document.getElementById("entBscAddr").value = addr;
	                    document.getElementById("entDaddr").focus();
	                    
	                   
	                }
	            }).open();
	        }
	        
	        $(function(){
	            $("#autoBtn1").on("click", function(){
	                $("#memId").val("joonsker");
	                $("#memPw").val("asdqwe12");
	                $("#memPw2").val("asdqwe12");
	                $("#memName").val("조현준");
	                $("#memNickNm").val("306수호천사");
	                $("#memTelNo").val("01041444444");
	                $("#memEmail").val("joonsker@naver.com");
	                // 수정된 부분: 성별 셀렉트 박스 선택
	                $("#sexdstnCd").val("M");
	                $("#memBir").val("1992-05-05");
	                // 수정된 부분: 체크 박스 선택
	                $("#trmsAgreCd").prop("checked", true);
	            });
	        });
	
			
	        $(function(){
	            $("#autoBtn1").on("click", function(){
	                $("#memId").val("joonsker");
	                $("#memPw").val("asdqwe12");
	                $("#memPw2").val("asdqwe12");
	                $("#memName").val("조현준");
	                $("#memNickNm").val("306수호천사");
	                $("#memTelNo").val("01041444444");
	                $("#memEmail").val("joonsker@naver.com");
	                // 수정된 부분: 성별 셀렉트 박스 선택
	                $("#sexdstnCd").val("M");
	                $("#memBir").val("1992-05-05");
	                // 수정된 부분: 체크 박스 선택
	                $("#trmsAgreCd").prop("checked", true);
	            });
	        });
	        
	        $(function(){
	            $("#autoBtn2").on("click", function(){
	                $("#entId").val("ent99");
	                $("#entPw").val("asdqwe12");
	                $("#entPw2").val("asdqwe12");
	                $("#brno").val("1012255555");
	                $("#entName").val("대덕인재개발원");
	                $("#rprsvNm").val("하재관");
	                $("#entEmail").val("kinggodH@naver.com");
	                $("#entSe").val("major company");
	                // 수정된 부분: 성별 셀렉트 박스 선택
	                $("#empCnt").val("33");
	                $("#entpTelNo").val("01012347890");
	                $("#hmpgAddr").val("4sung@4sung.co.kr");
	                $("#bizCn").val("저희는 사랑과 평화를 중요시하는 2조입니다 유후~");
	                // 수정된 부분: 체크 박스 선택
	                $("#trmsAgreCd2").prop("checked", true);
	            });
	        });
	
	</script>
    
    
    
</body>
</html>