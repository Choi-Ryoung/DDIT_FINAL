<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
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

    <script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
    <script src="${ctxp}/resources/js/jquery.easing.min.js"></script>
    <script src="${ctxp}/resources/js/swiper.min.js"></script>
    <link rel="stylesheet" href="${ctxp}/resources/css/swiper.min.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_common.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_main.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/button.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/cr_add.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/member/memregister.css">
    <c:if test="${not empty message }">
	<script type="text/javascript">
	alert("${message}");
	<c:remove var="message" scope="request"/>
	<c:remove var="message" scope="session"/>
</script>
</c:if>
   <title>회원가입 선택</title>
<!--     <style>
        .hidden {
            display: none;
        }
    </style>  -->
</head>
<body>
<h1>회원가입</h1>
<button id="normalBtn" type="button" name="membership" onclick="showForm('normalForm')">일반회원가입</button>
<button id="businessBtn" type="button" name="membership" onclick="showForm('businessForm')">기업회원가입</button>
    <form action="/member/signup.do" method="POST" id="normalForm" class="joinForm" >
        <h2>일반 회원가입</h2>
    <!-- onsubmit="return submitForm()" -->
        <div class="textForm">
            <input name="prMbrId" type="text" id="memId" class="id" placeholder="아이디" value="${memberVO.prMbrId }">
        </div>
        <span class="input-group-append">
            <button type="button" class="btn btn-secondary btn-flat" id="idCheckBtn" >중복확인</button>
        </span>
        <div class="textForm">
            <input name="prMbrPswd" id="memPw" type="password" class="pw" placeholder="비밀번호" >
        </div>
        <div class="textForm">
            <input name="prMbrPswdConfirm" id="memPw2" type="password" class="pw" placeholder="비밀번호 확인" >
             <font color="red" id="errMsg" style="font-size:18px;"></font><br/>
        </div>
        <div class="textForm">
            <input name="prMbrNm" id="memName"type="text"  class="name" placeholder="이름" value="${memberVO.prMbrNm }">
        </div>
        <div class="textForm">
            <input name="prMbrNcnm" id="memNickNm" type="text" class="name" placeholder="닉네임" value="${memberVO.prMbrNcnm }">
        </div>
        <div class="textForm">
            <input name="prMbrTelno" id="memTelNo" type="number" class="cellphoneNo" placeholder="전화번호" value="${memberVO.prMbrTelno }">
        </div>
        <div class="textForm">
            <input name="prMbrEmail" id="memEmail" type="text" class="email" placeholder="이메일" value="${memberVO.prMbrTelno }">
        </div>
        <div class="textForm">
            <div class="icheck-primary d-inline">
            <label for="sexdstnCd" class="form-label">성별</label>
            <select id="sexdstnCd" name = "sexdstnCd" class="form-select" aria-label="Default select example">
	        	<c:forEach items="${genderList}" var="genderVo" varStatus="vs">
	        		<option value="${genderVo.cmcd}">${genderVo.cmcdNm}</option>
	            </c:forEach>
        	</select>
            </div>
        </div>
        <div class="textForm">
            <input name="prMbrBirthdy" id="memBir" type="text" class="birthday" placeholder="생년월일" value="${memberVO.prMbrBirthdy }">
        </div>
        <div class="textForm">
            <span class="input-group-append">
                <button type="button" class="btn btn-secondary btn-flat" onclick="DaumPostcode1()">우편번호 찾기</button>
            </span>
            <input type="text"  id="prMbrZip" name="prMbrZip" class="postcode" placeholder="우편번호"  readonly> 
        </div>	
        <div class="textForm">
            <input name="prMbrBscAddr" type="text" class="address1" id="prMbrBscAddr" placeholder="기본주소"  readonly>
        </div>
        <div class="textForm">
            <input name="prMbrDaddr" type="text" class="address2" id="prMbrDaddr" placeholder="상세주소">
        </div>
        <div class="textForm">
            <input name="trmsAgreCd" type="checkbox" class="trmsAgreCd" id="trmsAgreCd" value="Y">
            <label for="trmsAgreCd">개인정보처리방침</label>
        </div>
        <input type="button" class="btn" id="signupBtn" value="J O I N"/>
    </form>
 <!-- @@@@@@@@@@@@@@@@@@@@@@@@일반회원끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->   
    
    <!-- 기업회원 폼 -->
     <form action="/member/entsignup.do" method="POST" id="businessForm" class="joinForm" >
        <h2>기업 회원가입</h2>
    <!-- onsubmit="return submitForm()" -->
  		<div class="input-group mb-3">
			<label for="inputDescription">프로필 이미지</label> 
		</div>
		<div class="input-group mb-3">
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="imgFile" id="imgFile"> 
				<label class="custom-file-label" for="imgFile">프로필 이미지를 선택해주세요</label>
			</div>
		</div>
    
        <div class="textForm">
            <input name="entMbrId" type="text" id="entId" class="id" placeholder="아이디" >
        </div>
        <span class="input-group-append">
            <button type="button" class="btn btn-secondary btn-flat" id="idCheckBtn2" >중복확인</button>
        </span>
        <div class="textForm">
        	<input name="brno" type="text" id="brno" class="brno" placeholder="사업자등록번호" ><!-- readonly="readonly" -->
        </div>
        <span>
        	<button type="button" class="btn btn-secondary btn-flat" id="brNoBtn">사업자등록번호</button>
        </span>
        <div class="textForm">
            <input name="entMbrPswd" id="entPw" type="password" class="pw" placeholder="비밀번호" >
        </div>
        <div class="textForm">
            <input name="entMbrPswdConfirm" id="entPw2" type="password" class="pw" placeholder="비밀번호 확인" >
             <font color="red" id="errMsg" style="font-size:18px;"></font><br/>
        </div>
             <div class="textForm">
            <input name="entNm" id="entName"type="text"  class="name" placeholder="기업명" >
        </div>
        </div>
             <div class="textForm">
            <input name="rprsvNm" id="rprsvNm"type="text"  class="name" placeholder="대표자명" >
        </div>
        <div class="textForm">
             <label  class="form-label">기업구분</label>
		        <select id="entSe" name = "entSe" class="form-select" aria-label="Default select example">
		        		<option value="">선택</option>
		        		<option value="major company">대기업</option>
		        		<option value="mid company">중소</option>
		        		<option value="small company">소</option>
		        </select>
        </div>
        <div class="textForm">
            <input name="entMbrEmail" id="entEmail" type="text" class="email" placeholder="이메일" >
        </div>
        <div class="textForm">
            <input name="entRprsTelno" id="entTelNo" type="number" class="cellphoneNo" placeholder="전화번호" >
        </div>
        <div class="textForm">
            <input name="entPicTelno" id="entpTelNo" type="number" class="cellphoneNo" placeholder="담당자전화번호" >
        </div>
        <div class="textForm">
            <span class="input-group-append">
                <button type="button" class="btn btn-secondary btn-flat" onclick="DaumPostcode2()">우편번호 찾기</button>
            </span>
            <input type="text"  id="entZip" name="entZip" class="postcode" placeholder="우편번호"  readonly> 
        </div>	
        <div class="textForm">
            <input name="entBscAddr" type="text" class="address1" id="entBscAddr" placeholder="기본주소"  readonly>
        </div>
        <div class="textForm">
            <input name="entDaddr" type="text" class="address2" id="entDaddr" placeholder="상세주소">
        </div>
        <div class="textForm">
          <label for="scdPswdUseYn">2차비번을 사용할꺼에요? ㅠㅠㅠ</label>
				<input name="scdPswdUseYn" type="checkbox" class="scdPswdUseYn" id="scdPswdUseYn1" value="Y">
			<span id="label1">Y</span>
				<input name="scdPswdUseYn" type="checkbox" class="scdPswdUseYn" id="scdPswdUseYn2" value="N">
			<span id="label2">N</span>
        </div>
          <div class="textForm">
	     	<input name="empCnt" type="text" class="empcnt" id="empCnt" placeholder="사원수">
        </div>
          <div class="textForm">
	     	<input name="hmpgAddr" type="text" class="hmpgAddr" id="hmpgAddr" placeholder="홈페이지주소">
        </div>
        <div>
        <label for="bizCn">사업및소개</label>
			<textarea id="bizCn" name="bizCn" rows="4" cols="50"></textarea>
        </div>
      
        <div class="textForm">
            <input name="trmsAgreCd" type="checkbox" class="trmsAgreCd" id="trmsAgreCd2" value="Y">
            <label for="trmsAgreCd">개인정보처리방침</label>
        </div>
        <input type="button" class="btn" id="signupBtn2" value="J O I N"/>
    </form>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script type="text/javascript">
    
    //선택폼 보이기

   function showForm(formId) {
       
        $("#businessForm").hide();
        $("#normalForm").hide(); 

      
        $("#" + formId).show();
        /* 
        if (formId === "businessForm") {
            $("#businessForm").attr("action", "/member/entsignup.do");
            $("#normalForm").attr("action", "/member/signup.do"); // 추가된 부분
        } else {
            $("#normalForm").attr("action", "/member/signup.do");
            $("#businessForm").attr("action", "/member/entsignup.do"); // 추가된 부분
        }
         */
    } 

    $(function(){
    	
    	$("#businessForm").hide();
        $("#normalForm").show();
//@@@@@@@@@@@@@@일반회원 가입폼@@@@@@@@@@@@@@@@@@@


        
    	var signupForm = $("#normalForm");	// 폼 태그 Element
    	var signupBtn = $("#signupBtn");	// 가입하기 버튼 Element
    	var idCheckBtn = $("#idCheckBtn");	// 중복확인 버튼 Element
    	var idCheckFlag = false;			// 중복확인 flag
    	
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
                data: { memId: id },
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
   	       if (memPw2 == null || memPw2 == "") {
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
				signupForm.submit();
			}else{
				alert("아이디 중복체크를 해주세요!");
			}
		}else{
			alert("개인정보 동의를 체크해주세요!");
		}
    		
    	});
    	
 //@@@@@@@@@@@@@@@@@@@@@@일반회원 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 
//@@@@@@@@@@@@@@@@@@@@@@@기업회원@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 
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
    	
    	
    	signupBtn2.on("click",function(){
    		// 아이디, 비밀번호, 이름까지만 일반적인 데이터 검증
    		// 개인정보 처리방침 동의를 체크했을때만 가입하기가 가능하도록
    		// 중복확인 처리가 true일때만 가입하기가 가능하도록
        	var agreeFlag2 = false; 
    		
    		var memId2 = $("#entId").val();
    		
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
    </script>
</body>
</html>
