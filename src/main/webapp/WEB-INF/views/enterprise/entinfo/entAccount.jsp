<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/> 
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css"> -->
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/기업계정관리.jpg"
									width="1100px" height="300px">
							</div>
						</div>
						<br>
					</div>
							 <nav>
					          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
					            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onclick="location.href='${ctxp}/ent/entpage/entAccount'">기업계정 정보</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/ent/entpage/entManage'">기업정보 관리</button>
					          </div>
					        </nav> 						
					     </div>
					</div> 
					<div class="card-body">
						<form action="${ctxp }/ent/entpage/entAccount.do" method="post" id="entAccForm">
							
							<div class="row">
							        <label for="entMbrId" class="form-label">아이디</label>
									<div class="col-auto">
									    <input type="text" id ="entMbrId" name = "entMbrId" class="form-control" value="${entmember.entMbrId }" readonly="readonly" >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="entMbrPswd" class="form-label">비밀번호</label>
									<div class="col-auto">
									    <input type="password" id ="entMbrPswd" name = "entMbrPswd" value="${entmember.entMbrPswd }" class="form-control" >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="entNm" class="form-label">기업명</label>
									<div class="col-auto">
									    <input type="text" id ="entNm" name = "entNm" value="${entmember.entNm }" class="form-control" >
									</div>
     
							</div><hr>
							<div class="row">
							        <label for="entRprsTelno" class="form-label">기업 대표번호</label>
									<div class="col-auto">
									    <input type="text" id ="entRprsTelno" name = "entRprsTelno" value="${entmember.entRprsTelno }" class="form-control" >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="entPicTelno" class="form-label">기업담당자 연락처</label>
									<div class="col-auto">
									    <input type="text" id ="entPicTelno" name = "entPicTelno" value="${entmember.entPicTelno }" class="form-control"  >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="entMbrEmail" class="form-label">이메일</label>
									<div class="col-auto">
									    <input type="text" id ="entMbrEmail" name = "entMbrEmail" value="${entmember.entMbrEmail }"class="form-control"  >
									</div>
							</div><hr>
							
							<div class="row">
							        <label for="brno" class="form-label">사업자번호</label>
									<div class="col-auto">
									    <input type="text" id ="brno" name = "brno" class="form-control" value="${entmember.brno }" readonly="readonly" >
									</div>
							</div><hr>
							
							<div class="row">
							       <div class="col-auto">
								        <label for="entZip" class="form-label">우편번호</label>
										<div class="col-auto">
										    <input type="text" id ="entZip" name = "entZip" class="form-control" value="${entmember.entZip }">
										    <span class="input-group-append">
													<button type="button" onclick="DaumPostcode()" class="btn btn-primary">우편번호 찾기</button>
											</span>
										</div>
							        </div>
							       <div class="col-auto">
								        <label for="entBscAddr" class="form-label">기본 주소</label>
										<div class="col-auto">
										    <input type="text" id ="entBscAddr" name = "entBscAddr" class="form-control" value="${entmember.entBscAddr }" >
										</div>
							        </div>
							       <div class="col-auto">
								        <label for="entDaddr" class="form-label">상세 주소</label>
										<div class="col-auto">
										    <input type="text" id ="entDaddr" name = "entDaddr" class="form-control" value="${entmember.entDaddr }"  >
										</div>
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
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>







<script>

$(document).ready(function(){
	
	$("#updateBtn").click(function(){
		
		
		$.ajax({
			type: "POST",
			url: "/ent/entpage/entAccount.do",
		 	//contentType: "application/json;charset=UTF-8",   
			data: { 
			 
				entMbrId : $("#entMbrId").val(),
				entMbrPswd : $("#entMbrPswd").val(),
				entNm : $("#entNm").val(),
				entRprsTelno : $("#entRprsTelno").val(),
				entPicTelno : $("#entPicTelno").val(),
				entMbrEmail : $("#entMbrEmail").val(),
				brno : $("#brno").val(),
				entZip : $("#entZip").val(),
				entBscAddr : $("#entBscAddr").val(),
				entDaddr : $("#entDaddr").val(),
		
			 },
				
			success: function(result) {
				console.log("hhhh"+result);
				if(result == "OK"){
					alert("회원정보 수정이 완료 되었습니다!");
					window.location.href = "/ent/entpage/entAccount";
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
            document.getElementById('entZip').value = data.zonecode;
            document.getElementById("entBscAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("entDaddr").focus();
        }
    }).open();
}     
//뒤로가기 
function goBack() {
    window.history.go(-1);
}
</script>
