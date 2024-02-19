<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>




  <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <!-- sh_sub_banner [s] -->
			<div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/멘토정보.jpg"
									width="1100px" height="300px">
							</div>
						</div>
						<br>
					</div>
					<nav>
						<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-home" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="true"
								onclick="location.href='${ctxp}/member/mypage/myInfo'">회원
								정보</button>
							<button class="nav-link active" data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false">멘토링
								정보</button>
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/mypage/applyList'">지원
								내역</button>
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업
								제안</button>
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/chart'">나의 통계</button>
							<button class="nav-link" data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서
								관리</button>

						</div>
					</nav>
				</div>
			</div> 
					<div class="card-body">
						<form action="/member/mentoUpdate.do" method="post" id="mentoForm">
						<div class="row">
							        <label for="menNcnm" class="form-label">닉네임</label>
									<div class="col-auto">
									    <input type="text" id ="menNcnm" name = "menNcnm" value="${mento.menNcnm }" class="form-control" readonly="readonly" >
									</div>
							</div><hr>
							
							<div class="row">
							   <div class="col-8 mb-3">
							        <label for="menPstCn" class="form-label">간단소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input type="text" id="menPstCn" name="menPstCn" class="form-control" value="${mento.menPstCn }"/>
										</div>
									</div>
							</div><hr>

						<div class="form-group">
							<select id="bankCd" name="bankCd" class="form-group">
								<option selected value="0">은행선택</option>
								<option value="shin han">신한은행</option>
								<option value="kakao">카카오뱅크</option>
								<option value="postbank">우체국</option>
							</select>
						</div>
					   <div class="col-8 mb-3">
					        <label for="menPstCn" class="form-label">계좌번호</label>
								<div class="col-auto">
								    <label for="inputPassword2" class="visually-hidden"></label>
								    <input type="text" id="actno" name="actno" class="form-control" value="${mento.actno }"/>
								</div>
						</div>
						<div class="row">
							<div class="col-8 mb-3">
								<label for="applyCareerCd" class="form-label">신입/경력</label> 
								<select id="applyCareerCd" name="applyCareerCd" class="form-select" aria-label="Default select example">
									<c:forEach items="${careerList}" var="careerList" varStatus="vs">
										<c:if test="${careerList.cmcd ne '01'}">
											<option value="${careerList.cmcdNm}">${careerList.cmcdNm}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
						<hr>

						<div class="row">
							<div class="col-8 mb-3">
								<label for="applyTaskCd" class="form-label">직무</label> <select
									id="applyTaskCd" name="applyTaskCd" class="form-select"
									aria-label="Default select example">
									<c:forEach items="${dutyList}" var="dutyList" varStatus="vs">
										<option value="${dutyList.cmcdNm}">${dutyList.cmcdNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<hr>

						<div class="row">
							<label for="tag" class="form-label">#태그</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label>
								<c:choose>
									<c:when test="${status eq 'u'}">
										<input type="text" id="tag" name="tag" class="form-control"
											value="<c:forEach items='${mento.tagList }' var='tag'><c:out value='${tag.menTag } '></c:out></c:forEach>" />
									</c:when>
									<c:otherwise>
										<input type="text" id="tag" name="tag" class="form-control"
											placeholder="태그를 입력해주세요">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
					   <div class="col-8 mb-3">
				        <label for="menPstCn" class="form-label">자기소개</label>
							<div class="col-auto">
							    <label for="inputPassword2" class="visually-hidden"></label>
							    <textarea rows="5" cols="150" id="menIndt" name="menIndt" style="white-space: pre;">${mento.menIndt }</textarea>
							</div>
						</div>
						<hr></div><hr>
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
								            <div class="icheck-primary d-inline">
								               <button type="button" class="btn btn-success"onclick="goDetail();">내 멘토정보</button>
								            </div>
								        </div>
								    </div>
								</div>				
							</div>
						</form>
					</div>	
				</div>    
            </div>
  <script>
     
     
 	$(document).ready(function(){
 		/* 	var id = $("#prMbrId").val();          
 			var pw = $("#prMbrPswd").val();        
 			var email = $("#prMbrEmail").val();      
 			var tel = $("#prMbrTelno").val();  */
 		
 			$("#updateBtn").click(function(){
 				  
 				 
 				 $.ajax({
 					type: "POST",
 					url: "/member/mentoUpdate.do",
 				 	//contentType: "application/json;charset=UTF-8",   
 					data: { 
 					 
 						menNcnm : $("#menNcnm").val(),
 						menIndt : $("#menIndt").val(),
 						applyCareerCd : $("#applyCareerCd").val(),
 						applyTaskCd : $("#applyTaskCd").val(),
 						entNm : $("#entNm").val(),
 						entLogo : $("#entLogo").val(),
 						actno : $("#actno").val(),
 						menPstCn : $("#menPstCn").val(),
 						bankCd : $("#bankCd").val(),
 					 },
 						
 					success: function(result) {
 						console.log("hhhh"+result);
 						if((result === "redirect:/member")){
 							alert("회원정보 수정이 완료 되었습니다!");
 							window.location.href = "/member/mypage/mentoinfo";
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
   	
   	function goDetail() {
   		location.href = "/mento/find?menNcnm=${mento.menNcnm}";
   	}
     
     </script>