<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<link href="${ctxp}/resources/css/intreview/company_info.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/common_ui_keeping.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/components.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/gnb_default_override.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/header_default.css" rel="stylesheet">
<%-- <link href="${ctxp}/resources/css/intreview/layout.css" rel="stylesheet"> --%>
<link href="${ctxp}/resources/css/intreview/pattern.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/sticky_assist.css" rel="stylesheet">



    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
							<div>
								<div class="bd-example">
									<nav>
										<div class="nav nav-tabs " id="nav-tab" role="tablist">
											<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab"
												data-bs-target="#nav-home" type="button" role="tab"
												aria-controls="nav-home" aria-selected="true" onclick="location.href='${ctxp}/member/enterpriseinfo/entReviewList';">기업리뷰</button>
											<button class="nav-link active" id="nav-profile-tab"
												data-bs-toggle="tab" data-bs-target="#nav-profile"
												type="button" role="tab" aria-controls="nav-profile"
												aria-selected="false" onclick="location.href='${ctxp}/member/enterpriseinfo/intReviewList';">면접후기</button>
										</div>
									</nav>
							     </div>
							</div><hr>              
							    
						<div class="header_interview_review">
						    <div class="inner">
						    <h2 class="blind">면접 경험, 공유해줘서 고마워요!</h2>
						        <p class="txt_noti">
						            면접의 A~Z까지 HIT 면접후기에서 확인해보세요!<br>
						            #전형 #진행방식 #면접질문 #면접후기
						        </p>
						    </div>
						</div><hr>
					  	
							<div class="card-body">
								<form action="${ctxp }/member/enterpriseinfo/intReviewInsert.do" method="post" id="intReviewForm">
								
							<div class="row">
									<div class="col-md-6 mb-1">
									   	 <input type="text" id ="entNm" name = "entNm" class="form-control" placeholder="기업명">
									</div>
							</div><hr>
							
								<div class="row align-items-center">
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										성별
									</div>
									<div class="col-md-4 mb-1 text-center">
								        <select id="sexdstnCd" name = "sexdstnCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${genderList}" var="genderVo" varStatus="vs">
								        		<option value="${genderVo.cmcd}">${genderVo.cmcdNm}</option>
								            </c:forEach>
								        </select>
									</div>
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										재직여부
									</div>
									<div class="col-md-4 mb-1 text-center">
								        <select id="serveYn" name = "serveYn" class="form-select" aria-label="Default select example">
								            <option value="Y" selected>재직</option>
								            <option value="N">퇴사</option>
								        </select>
									</div>
								</div><hr>	
								
								
								<div class="row align-items-center">
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										신입/경력
									</div>
									<div class="col-md-4 mb-1 text-center">
								        <select id="applyCareerCd" name ="applyCareerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="careerVo" varStatus="vs">
								        		<c:if test="${careerVo.cmcd ne '01'}">
								        			<option value="${careerVo.cmcd}">${careerVo.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
									</div>
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										직무
									</div>
									<div class="col-md-4 mb-1 text-center">
								        <select id="applyTaskCd" name = "applyTaskCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="dutyVo" varStatus="vs">
								        		<option value="${dutyVo.cmcd}">${dutyVo.cmcdNm}</option>
								            </c:forEach>
								        </select>
									</div>
								</div><hr>
								
								<div class="row align-items-center">
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										면접 난이도
									</div>
									<div class="col-md-4 mb-1 text-center">
								        <c:forEach items="${ivLevelList}" var="ivLevelVo" varStatus="vs">
												<input type="radio" id="option${vs.count}" name="ivDfflyCd" value="${ivLevelVo.cmcd}" class="btn-check">
												<label class="btn btn-outline-primary" for="option${vs.count}">${ivLevelVo.cmcdNm}</label>
								        </c:forEach>   
									</div>
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										면접 당시 경력
									</div>
									<div class="col-md-4 mb-1 text-center">
								       <c:forEach items="${ivCareerList}" var="ivCareerVo" varStatus="vs">
												<input type="radio" id="career${vs.count}" name="ivCareerCd" value="${ivCareerVo.cmcd}" class="btn-check">
												<label class="btn btn-outline-primary" for="career${vs.count}">${ivCareerVo.cmcdNm}</label>
								       </c:forEach>   
									</div>
								</div><hr>									
								
								<div class="row align-items-center">
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										면접 인원
									</div>
									<div class="col-md-4 mb-1 text-center">
											<c:forEach items="${ivPcntList}" var="ivPcntVo" varStatus="vs">
												<input type="checkbox" id="pCnt${vs.count}" name = "ivPcntCd" class="btn-check" value="${ivPcntVo.cmcd}">
												<label class="btn btn-outline-primary" for="pCnt${vs.count}">${ivPcntVo.cmcdNm}</label>
								            </c:forEach>    
									</div>
								    <div class="col-md-2 mb-1 px-5 text-black text-center">
										면접 합격 여부
									</div>
									<div class="col-md-4 mb-1 text-center">
										<c:forEach items="${ivPassList}" var="ivPassVo" varStatus="vs">
												<input type="radio" id="pass${vs.count}" name="passYn" value="${ivPassVo.cmcd}" class="btn-check">
												<label class="btn btn-outline-primary" for="pass${vs.count}">${ivPassVo.cmcdNm}</label>
								        </c:forEach>    
									</div>
								</div><hr>									
								
							<div class="row align-items-center">
									 <div class="col-md-3 mb-1 px-5 text-black text-start">
										면접 전반적 평가
									</div>
									<div class="col-md-6 mb-1 text-center">
										 	<c:forEach items="${ivEvalueList}" var="ivEvalueVo" varStatus="vs">
												<input type="checkbox" id="evalueOption${vs.count}" name = "ivEvalueCd" class="btn-check" value="${ivEvalueVo.cmcd}">
												<label class="btn btn-outline-primary" for="evalueOption${vs.count}">${ivEvalueVo.cmcdNm}</label>
								            </c:forEach>   
									</div>
							</div><hr>		
								
							<div class="row align-items-center">
									 <div class="col-md-2 mb-1 px-5 text-black text-center">
										면접 유형
									</div>
									<div class="col-md-10 mb-1 text-center">
										 	<c:forEach items="${ivTypeList}" var="ivTypeVo" varStatus="vs">
												<input type="checkbox" id="typeOption${vs.count}" name = "ivTypeCd" class="btn-check" value="${ivTypeVo.cmcd}">
												<label class="btn btn-outline-primary" for="typeOption${vs.count}">${ivTypeVo.cmcdNm}</label>
								            </c:forEach>   
									</div>
							</div><hr>
							
								
								
								 <div class="form-group">
								 <div class="col-md-12 text-center text-black mb-3">전형 및 면접 진행방식</div>
									<textarea id="ivTypeCn" name="ivTypeCn" class="form-control" rows="4" placeholder="서류 합격 후 어떤 전형과 면접을 경험하셨나요?
"></textarea>
								 </div><br><hr>
								
								 <div class="form-group">
								 <div class="col-md-12 text-center text-black mb-3">면접 질문</div>
										<textarea id="ivQues" name="ivQues" class="form-control" rows="4" placeholder="ex) 경력 사항에 대한 상세한 질문"></textarea>
								 </div><br><hr>
								
								<div class="form-group">
								<div class="col-md-12 text-center text-black mb-3">면접 특이사항</div>
										<textarea id="ivPstSft" name="ivPstSft" class="form-control" rows="4" placeholder="분위기, 준비 tip을 공유해주세요."></textarea>
								</div><br><hr>
								
								<div class="row">
									<div class="col-6">
									    <div class="input-group mb-3">
									        <div class="form-group clearfix">
									            <div class="icheck-primary d-inline">
									                 <button type="submit" class="btn btn-primary btn-inline">등록하기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									               <button type="button" class="btn btn-primary btn-inline" onclick="javascript:history.back()">뒤로가기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									               <button type="button" class="btn btn-primary  btnAuto">자동완성</button>
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
      </div>





<script>
$(function(){
	$(".btnAuto").on("click",function(){
		$("#entNm").val("레드캡");
	/* 	$("select[name='serveYn'] option[value='01']").prop("selected", true);
		$("select[name='sexdstnCd'] option[value='01']").prop("selected", true);
		$("select[name='applyCareerCd'] option[value='01']").prop("selected", true); */
		$("input[name='ivDfflyCd'][value='01']").prop("checked", true);
		$("input[name='ivTypeCd'][value='03']").prop("checked", true);
		$("input[name='ivCareerCd'][value='01']").prop("checked", true);
		$("input[name='ivPcntCd'][value='02']").prop("checked", true);
		$("input[name='ivEvalueCd'][value='01']").prop("checked", true);
		$("input[name='passYn'][value='02']").prop("checked", true);
		
		$("#ivTypeCn").val(`원데이 면접으로 직무, 인성을 하루에 보았다.
각 직무별 사전과제가 있었고 발표자료를 제작해서 마감일까지 제출하면 원데이 면접 당일에 PT를 진행하는 형식으로 진행되었다.
직무, 인성 모두 40~50분정도 했고 사이 쉬는시간은 5분정도 있었다.`);
		
		$("#ivQues").val(`해당 업무는 어떤 일을 한다고 생각하는지?
프로젝트에서 그 방법론을 활용한 이유는?
새로운 시도를 했을 때 발생했던 어려움이 있다면?`);
		
		$("#ivPstSft").val(`회사의 현 상황과 경쟁사, 국제 정세를 알아가면 좋을거 같습니다.`);
	})
})
</script>
