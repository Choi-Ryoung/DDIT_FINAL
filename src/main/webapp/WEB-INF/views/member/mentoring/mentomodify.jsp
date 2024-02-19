<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
margin-top:20px;
 --bs-font-sans-serif:margin:0; padding:0;font-size:17px;line-height:1.6;font-family:'Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400;
}

</style>

<body>
    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <!-- sh_sub_banner [s] -->
            <div id="sh_sub_banner">
                <div id="sh_content_tit">
                    <h3>회사소개</h3>
                    <p><a href="/"><i class="fa fa-home"></i><span class="sound_only">홈으로</span></a> 
                    <i class="fa fa-angle-right"></i> 회사소개 <i class="fa fa-angle-right"></i> 회사소개</p>
                </div>
            </div>
            <div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
					  	
							<div class="card-body">
								<form action="/mento/modify" method="post" id="modifyForm" enctype="multipart/form-data">
								<div class="row">
								        <label for="men_ncnm" class="form-label">닉네임</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input type="text" id ="menNcnm" name = "menNcnm" class="form-control" placeholder="닉네임을 입력해주세요" value="${mento.menNcnm }" readonly="readonly">
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
								
								<div class="row">
								        <label for="bankCd" class="form-label">은행이름</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input type="text" id="bankCd" name ="bankCd" class="form-control" value="${mento.bankCd }"/>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="actno" class="form-label">계좌번호</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input type="text" id="actno" name="actno" class="form-control" value="${mento.actno }"/>
										</div>
								</div><hr>
								
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="applyCareerCd" class="form-label">신입/경력</label>
								        <select id="applyCareerCd" name="applyCareerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="careerList" varStatus="vs">
								        		<c:if test="${careerList.cmcd ne null}">
								        			<option value="${careerList.cmcdNm}">${careerList.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
					
								<div class="row">
									<div class="col-8 mb-3">
								        <label for="applyTaskCd" class="form-label">직무</label>
								        <select id="applyTaskCd" name="applyTaskCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="dutyList" varStatus="vs">
								          		<c:if test="${dutyList ne null}">
									        		<option value="${dutyList.cmcdNm}">${dutyList.cmcdNm}</option>
								          		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
								
								<div class="row">
								        <label for="tag" class="form-label">#태그</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
												    <input type="text" id="tag" name="tag" class="form-control" value="<c:forEach items='${mento.tagList }' var='tag'><c:out value='${tag.menTag } '></c:out></c:forEach>"/>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="menPstCn" class="form-label">소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <textarea rows="30" cols="50" id="menIndt" name="menIndt" style="white-space: pre;">${mento.menIndt }</textarea>
										</div>
								</div><hr>
								
								
								<div class="row">
									<div class="col-6">
									    <div class="input-group mb-3">
									        <div class="form-group clearfix">
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="modifyBtn" class="btn btn-secondary btn-inline">수정하기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									               <button type="button" id="cancelBtn" class="btn btn-secondary btn-inline">뒤로가기</button>
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
</body>
<script>
	var modifyForm = $("#modifyForm");
	var modifyBtn = $("#modifyBtn");
	var cancelBtn = $("#cancelBtn");
	
	$(function(){
		
		modifyBtn.on("click", function(){
			modifyForm.submit();
		});
		
		cancelBtn.on("click", function(){
			location.href = "/mento/find?menNcnm=${mento.menNcnm}";
		});
		
	});
</script>