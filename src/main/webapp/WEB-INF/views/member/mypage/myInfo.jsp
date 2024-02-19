<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
 
 
 
  <div id="sh_container"> 
        <div id="sh_container_wrapper">
			<div id="sh_content">
                <div id="greeting" class="pagecommon">
                
                
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/개인회원정보.jpg" width="1100px" height="300px">
								</div>
						</div><br>
					</div>						
					        <nav>
					          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
					            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="true">회원 정보</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mentoUpdate'">멘토링 정보</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/applyList'">지원 내역</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/selectPrpsList'" >이직/취업 제안</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/chart'">나의 통계</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서 관리</button>

					          </div>
					        </nav>
					     </div>
					</div> 
					<div class="card-body">
						<form action="${ctxp }/member/mypage/myInfo" method="post" id="mypageForm">
							<div class="row">
							        <label for="prMbrId" class="form-label">아이디</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrId" name = "prMbrId" class="form-control" value="${member.prMbrId }" readonly="readonly" >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="prMbrPswd" class="form-label">비밀번호</label>
									<div class="col-auto">
									    <input type="password" id ="prMbrPswd" name = "prMbrPswd" value="${member.prMbrPswd }" class="form-control" >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="prMbrNm" class="form-label">이름</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrNm" name = "prMbrNm" value="${member.prMbrNm }" class="form-control" >
									</div>
							</div><hr>
							<div class="row">
							        <label for="prMbrNm" class="form-label">닉네임</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrNcnm" name = "prMbrNcnm" value="${member.prMbrNcnm }" class="form-control" >
									</div>
									<div class="col-auto">
									    <button type="button" class="btn btn-primary">중복확인</button>
									</div>        
							</div><hr>
							
							<div class="row">
							        <label for="prMbrTelno" class="form-label">전화번호</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrTelno" name = "prMbrTelno" value="${member.prMbrTelno }" class="form-control"  >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="prMbrEmail" class="form-label">이메일</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrEmail" name = "prMbrEmail" value="${member.prMbrEmail }"class="form-control"  >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="prMbrBirthdy" class="form-label">생년월일</label>
									<div class="col-auto">
									    <input type="text" id ="prMbrBirthdy" name = "prMbrBirthdy" class="form-control" value="${member.prMbrBirthdy }" readonly="readonly" >
									</div>
							</div><hr>
							
							<div class="row">
							       <div class="col-auto">
								        <label for="prMbrBscAddr" class="form-label">우편번호</label>
										<div class="col-auto">
										    <input type="text" id ="prMbrZip" name = "prMbrZip" class="form-control" value="${member.prMbrZip }">
										    <br>
										    <span class="input-group-append">
													<button type="button" onclick="DaumPostcode()" class="btn btn-primary">우편번호 찾기</button>
											</span>
										</div>
							        </div>
							       <div class="col-auto">
								        <label for="prMbrBscAddr" class="form-label">기본 주소</label>
										<div class="col-auto">
										    <input type="text" id ="prMbrBscAddr" name = "prMbrBscAddr" class="form-control" value="${member.prMbrBscAddr }" >
										</div>
							        </div>
							       <div class="col-auto">
								        <label for="prMbrDaddr" class="form-label">상세 주소</label>
										<div class="col-auto">
										    <input type="text" id ="prMbrDaddr" name = "prMbrDaddr" class="form-control" value="${member.prMbrDaddr }"  >
										</div>
							        </div>
							</div><hr>								
							
							<div class="row">
							       <div class="col-auto">
							       		<label for="bankCd" class="form-label ">은행</label>
							        	<select id="bankCd" name = "bankCd" class="form-select" aria-label="Default select example">
							        		<c:forEach items="${genderList}" var="genderVo" varStatus="vs">
							        			<option value="${genderVo.cmcd}">${genderVo.cmcdNm}</option>
							            	</c:forEach>
							        	</select>
							        </div>
							        <div class="col-auto">
										<label for="entNm" class="form-label ">계좌번호</label>
									    <input type="text" id ="entNm" name = "entNm" class="form-control" >
									</div>
							</div><hr>							
							<div class="row">
							    <div class="col-8 mb-3">
							        <label for="sexdstnCd" class="form-label">성별</label>
							        <select id="sexdstnCd" name = "sexdstnCd" class="form-select" aria-label="Default select example">
							        	<c:forEach items="${genderList}" var="genderVo" varStatus="vs">
							        		<option value="${genderVo.cmcd}">${genderVo.cmcdNm}</option>
							            </c:forEach>
							        </select>
							    </div>
							</div><hr>
							
							<div class="row">
								<div class="col-6">
								    <div class="input-group mb-3">
								        <div class="form-group clearfix">
								            <div class="icheck-primary d-inline">
								                 <button type="button" class="btn btn-warning" id="updateBtn">수정하기</button>
								            </div>
								            <div class="icheck-primary d-inline">
								               <button type="button" class="btn btn-danger"onclick="goBack();">뒤로가기</button>
								            </div>
								        </div>
								    </div>
								</div>				
							</div>
							
						</form>
					</div>	
				</div>    
            </div>
       </div>
     </div>
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>


	$(document).ready(function(){
	/* 	var id = $("#prMbrId").val();          
		var pw = $("#prMbrPswd").val();        
		var email = $("#prMbrEmail").val();      
		var tel = $("#prMbrTelno").val();  */
	
		$("#updateBtn").click(function(){
			  
			 
			 $.ajax({
				type: "POST",
				url: "/member/mypage/myInfo.do",
			 	//contentType: "application/json;charset=UTF-8",   
				data: { 
				 
					prMbrId : $("#prMbrId").val(),
					prMbrNm : $("#prMbrNm").val(),
					prMbrNcnm : $("#prMbrNcnm").val(),
					prMbrPswd : $("#prMbrPswd").val(),
					prMbrTelno : $("#prMbrTelno").val(),
					prMbrEmail : $("#prMbrEmail").val(),
					prMbrZip : $("#prMbrZip").val(),
					prMbrBscAddr : $("#prMbrBscAddr").val(),
					prMbrDaddr : $("#prMbrDaddr").val(),
					sexdstnCd : $("#sexdstnCd").val()
				 },
					
				success: function(result) {
					console.log("hhhh"+result);
					if((result === "redirect:/member")){
						alert("회원정보 수정이 완료 되었습니다!");
						window.location.href = "/member/loginform";
					}else{
						alert("수정 실패요 다시확인요");
					}
				},
				error:function(request,status,error){
					    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); 
		});
	});
//뒤로가기 
function goBack() {
    window.history.go(-1);
}
     
//daum 주소 API(주소찾기)
function DaumPostcode() {
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

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('prMbrBscAddr').value = data.zonecode;
            document.getElementById("prMbrDaddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("prMbrDaddr").focus();
        }
    }).open();
}     
</script>

