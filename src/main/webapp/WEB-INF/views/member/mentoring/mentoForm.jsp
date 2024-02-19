<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
body{
margin-top:20px;
 --bs-font-sans-serif:margin:0; padding:0;font-size:17px;line-height:1.6;font-family:'Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400;
}
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: cornflowerblue;
	/* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}
</style>

<c:set value="등록하기" var="name"/>
<c:if test="${status eq 'u'}">
<c:set value="수정하기" var="name" />
</c:if>
    <div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example"></div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<img src="${ctxp}/resources/img/main/menu_banner/멘토링.jpg" width="1200px" height="300px">
						</div>
					</div>
				</div>
				<hr>
				<!-- 여기부터 -->
				<div class="card-body">
								<form action="/mento/insert" method="post" id="mentoringForm" enctype="multipart/form-data">
									<input type="hidden" name="prMbrId" value="${SessionInfo.prMbrId }"/>
									<c:if test="${status eq 'u'}">
										<input type="hidden" name="menNcnm" id="mentoncnm" value="${mento.menNcnm}"/>
									</c:if>
									
								<div class="mb-3">
								        <label for="menFile" class="form-label">프로필 사진</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input class="form-control" type="file" name="menFile" id="menFile" multiple="multiple">
										</div>
								<c:if test="${status eq 'u'}">
								<c:set value="${mento.menFileList }" var="menFileList" />
									<c:if test="${not empty menFileList }">
										<div class="col-md-12">
											<div class="row">
											<c:forEach items="${menFileList }" var="mentoFile">
												<div class="col-md-2">
												<c:choose>
													<c:when test="${fn:split(mentoFile.menFileMime, '/')[0] eq 'image' }">
														<img src="/resources/upload/${mento.menNcnm}/${fn:split(mentoFile.menFileSavepath, '/')[1] }" style="width:20rem;" alt="img-blur-shadow">
													</c:when>
													<c:otherwise>
														<img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
													</c:otherwise>
												</c:choose>
												<p class="mb-0 text-xs font-weight-bolder text-info text-uppercase">
													<button type="button" id="btn_${mentoFile.menFileSn }" class="btn btn-primary fileDelete">delete</button>
												</p>
											</div>
											</c:forEach>
											</div>
										</div>
									</c:if>
								</c:if>
								</div><hr>
								
								<div class="row">
								        <label for="menNcnm" class="form-label">닉네임</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="menNcnm" name = "menNcnm" class="form-control" value="${SessionInfo.prMbrNcnm }" readonly="readonly">
											    </c:when>
											    <c:otherwise>
												    <input type="text" id ="menNcnm" name = "menNcnm" class="form-control" value="${SessionInfo.prMbrNcnm }" readonly="readonly">
											    </c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
									   <div class="col-8 mb-3">
								        <label for="menPstCn" class="form-label">간단소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="menPstCn" name = "menPstCn" class="form-control" value="${mento.menPstCn}">
											    </c:when>
											    <c:otherwise>
												    <input type="text" id="menPstCn" name="menPstCn" class="form-control" placeholder="자신을 나타내는 간단한 소개글입니다"/>
											    </c:otherwise>
										    </c:choose>
										</div>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="bankCd" class="form-label">은행이름</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="bankCd" name = "bankCd" class="form-control" value="${mento.bankCd}">
											    </c:when>
										    	<c:otherwise>
												    <input type="text" id ="bankCd" name = "bankCd" class="form-control" placeholder="은행을 입력해주세요">
										    	</c:otherwise>	
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="actno" class="form-label">계좌번호</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="actno" name = "actno" class="form-control" value="${mento.actno}">
											    </c:when>
										    	<c:otherwise>
												    <input type="text" id ="actno" name = "actno" class="form-control" placeholder="계좌번호를 입력해주세요">
										    	</c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="trmsAgreCd" class="form-label">약관동의여부</label>
								        <c:choose>
								        	<c:when test="${status eq 'u' }">
										        <input type="checkbox" id="trmsAgreCd" name="trmsAgreCd" value="Y" checked="checked" class="form-checkbox" aria-label="Default checkbox example"/>
								        	</c:when>
								        	<c:otherwise>
										        <input type="checkbox" id="trmsAgreCd" name="trmsAgreCd" value="Y" class="form-checkbox" aria-label="Default checkbox example"/>
								        	</c:otherwise>
								        </c:choose>
								    </div>
								</div><hr>
								
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="applyCareerCd" class="form-label">신입/경력</label>
								        <select id="applyCareerCd" name ="applyCareerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="careerList" varStatus="vs">
								        		<c:if test="${careerList.cmcd ne '01'}">
								        			<option value="${careerList.cmcdNm}">${careerList.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
					
								<div class="row">
									<div class="col-8 mb-3">
								        <label for="applyTaskCd" class="form-label">직무</label>
								        <select id="applyTaskCd" name = "applyTaskCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="dutyList" varStatus="vs">
								        		<option value="${dutyList.cmcdNm}">${dutyList.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
								
								<div class="row">
								        <label for="tag" class="form-label">#태그</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
											    	<input type="text" id="tag" name="tag" class="form-control" value="<c:forEach items='${mento.tagList }' var='tag'><c:out value='${tag.menTag } '></c:out></c:forEach>"/>
											    </c:when>
											    <c:otherwise>
												    <input type="text" id ="tag" name = "tag" class="form-control" placeholder="태그를 입력해주세요">
											    </c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="menPstCn" class="form-label">소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
										    	<c:when test="${status eq 'u'}">
										    		<textarea rows="5" cols="150" id="menIndt" name="menIndt" style="white-space: pre;">${mento.menIndt }</textarea>
										    	</c:when>
										    	<c:otherwise>
												    <textarea rows="5" cols="150" id="menIndt" name="menIndt" style="white-space: pre;"></textarea>
										    	</c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								
								<div class="row">
									<div class="col-6">
									    <div class="input-group mb-3">
									        <div class="form-group clearfix">
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="signUpBtn" class="btn btn-secondary btn-inline">${name}</button>
									            </div>
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="backBtn" class="btn btn-secondary btn-inline">뒤로가기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="autoBtn" class="btn btn-secondary btn-inline">자동완성</button>
									            </div>
									        </div>
									    </div>
									</div>				
								</div>
								
							</form>
						</div>


				<!-- 여기까지 -->
			</div>
		</div>
	</div>
</div>
<script>
	var mentoringForm = $("#mentoringForm");
	var signUpBtn = $("#signUpBtn");
	var idCheckBtn = $("#idCheckBtn");
	var idCheckFlag = $("#idCheckFlag");
	var autoBtn = $("#autoBtn");
	var backBtn = $("#backBtn");
	var prMbrNcnm = "${SessionInfo.prMbrNcnm }";
	var menNcnm = "${mentoInfo.menNcnm}";
	console.log("menNcnm : " + menNcnm);
	console.log("prMbrNcnm : " + prMbrNcnm);
	console.log($("#menNcnm").val());
	var status = "${status}";
	
	$(function(){
		
		if(status != 'u' && prMbrNcnm == menNcnm) {
			alert("멘토 신청이 완료된 계정입니다.");
			location.href = "/mento/list";
		}
		
		autoBtn.on("click", function(){
			/* $("#menNcnm").val(); */
			$("#menPstCn").val("현재 카카오 재직중입니다.");
			$("#entNm").val("카카오");
			$("#bankCd").val("국민은행");
			$("#actno").val("47845781215");
			$("#trmsAgreCd").prop("checked", true);
			$("#tag").val("자바스크립트 이력서작성 자기소개서작성");
			var text = "안녕하세요." + prMbrNcnm +"입니다.";
			text += "\n";
			text += "여러분의 취업을 도와드리고 싶습니다.";
			text += "\n";
			text += "최선을 다해 도와드리겠습니다.";
			$("#menIndt").val(text);
		});
		
		idCheckBtn.on("click", function(){
			var nickName = $("#menNcnm").val();
			
			if(!nickName) {
				alert("닉네임을 입력해주세요.");
				return false;
			}
			
			var data = {
				menNcnm : nickName
			}
			
			$.ajax({
				type : "post",
				url : "/mento/idCheck",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success: function(res) {
					console.log("넘겨받은 결과 : " + res);
					
					if(res == "NOTEXIST") {
						alert("사용 가능한 아이디입니다.");
						idCheckFlag = true;
					} else {
						alert("이미 사용중인 아이디입니다.");
					}
				}
			});
			
			
		});
		
		backBtn.on("click", function(){
			location.href = "/mento/list";
		})
		
		
		signUpBtn.on("click", function(){
			var agreeFlag = false;
			var nickName = $("#menNcnm").val();
			console.log("nickName : " + nickName);
			var menIndt = $("#menIndt").val();
			var menPstCn = $("#menPstCn").val();
			
			if(!menIndt) {
				alert("소개글을 입력해주세요!");
				return;
			}
			if(!menPstCn) {
				alert("소개글을 입력해주세요!");
				return;
			}
			
			var trmsAgreCd = $("#trmsAgreCd").val();
			if(trmsAgreCd == "Y") {
				agreeFlag = true;
			}
			
 			if(!agreeFlag){
				alert("개인정보 동의하고 오세요");
			} 
			
			if($(this).text() == '수정하기') {
				mentoringForm.attr("action", "/mento/modify");
				mentoringForm.attr("method", "post");
			}
			
			mentoringForm.submit();
			
			
		});
		
		$(".fileDelete").on("click", function(){
			var id = $(this).prop("id");
			var idx = id.indexOf("_");
			var menFileSn = id.substring(idx + 1); // menFileSn 가져오기
			var ptrn = "<input type='hidden' name='delmenNcnm' value='%V'/>";
			mentoringForm.append(ptrn.replace("%V", menFileSn));
			$(this).parents("div[class=col-md-2]").hide();
		});
		
	})
	
</script>