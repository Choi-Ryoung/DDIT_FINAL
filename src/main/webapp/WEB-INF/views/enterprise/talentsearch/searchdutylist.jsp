<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
    background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}
#resultDiv{
	width: 94%;
	height: 100px;
	background-color: beige;
	margin-top: 10px;
	margin-left: 3px;
	padding-top: 6px;
}

#dutyDiv {
	margin-top: 15px;
}

table {
	width : 100%;
}

th:nth-child(1) {
	width: 3%;
}

th:nth-child(2) {
	width: 15%;
}

th:nth-child(3) {
	width: 30%;
}
</style>

 
    <div id="sh_container"> 
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <div id="greeting" class="pagecommon">
	                	<!-- 아래로 콘텐츠 추가  -->
						<div>
						<div class="row">
						    <div class="col-md-12">
					        	<div class="card card-outline card-danger mt-4">
									<img src="${ctxp}/resources/img/main/menu_banner/인재찾기.jpg" width="1100px" height="300px">
								</div>
						    </div>
						</div><hr>
							<div class="bd-example">
						        <nav>
						          <div class="nav nav-tabs " id="nav-tab" role="tablist">
						            <button class="nav-link active searchDiv" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" style="width: 250px;">직무별 검색</button>
						            <button class="nav-link active searchCareer" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"  type="button" role="tab" aria-controls="nav-profile" aria-selected="false" style="width: 250px;">경력별 검색</button>
						            <button class="nav-link active searchWork" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"  type="button" role="tab" aria-controls="nav-profile" aria-selected="false" style="width: 250px;">근무형태</button>
						            <button class="nav-link active searchSalary" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"  type="button" role="tab" aria-controls="nav-profile" aria-selected="false" style="width: 250px;">급여</button>
						            <form class="input-group input-group-sm" method="post" id="searchForm" style="width: 440px;">
										<input type="hidden" name="page" id="page" /> 
									</form>
						          </div>
						        </nav>
						     </div>
						     <div class="btn-group" id="dutyDiv" role="group" aria-label="Basic example">
							  <c:set var="cnt" value="1" />
								<c:forEach items="${dutyList}" var="dutyList"
									varStatus="vs">
									<c:if test="${dutyList.cmcd ne '01'}">
										<button type="button" class="btn-check jobType"
											name="workCd" id="work${cnt}"
											data-cd="${dutyList.cmcd}">${dutyList.cmcdNm}</button>
										<label class="btn btn-outline-primary" for="work${cnt}">${dutyList.cmcdNm}</label>
										<c:set var="cnt" value="${cnt + 1}" />
									</c:if>
								</c:forEach>
							</div>
							<div class="btn-group" id="careerDiv" role="group" aria-label="Basic example">
							  <c:set var="cnt" value="1" />
								<c:forEach items="${careerList}" var="careerList"
									varStatus="vs">
									<c:if test="${careerList.cmcd ne '01'}">
										<button type="button" class="btn-check jobType"
											name="careerYearCd" id="career${cnt}"
											data-cd="${careerList.cmcd}">${careerList.cmcdNm}</button>
										<label class="btn btn-outline-primary" for="career${cnt}">${careerList.cmcdNm}</label>
										<c:set var="cnt" value="${cnt + 1}" />
									</c:if>
								</c:forEach>
							</div>
							<div class="btn-group" id="workDiv" role="group" aria-label="Basic example">
							  <c:set var="cnt" value="1" />
								<c:forEach items="${workList}" var="workList"
									varStatus="vs">
									<c:if test="${workList.cmcd ne '01'}">
										<button type="button" class="btn-check jobType"
											name="dutyCd" id="duty${cnt}"
											data-cd="${workList.cmcd}">${workList.cmcdNm}</button>
										<label class="btn btn-outline-primary" for="duty${cnt}">${workList.cmcdNm}</label>
										<c:set var="cnt" value="${cnt + 1}" />
									</c:if>
								</c:forEach>
							</div>
							<div class="btn-group" id="salaryDiv" role="group" aria-label="Basic example">
							  <c:set var="cnt" value="1" />
								<c:forEach items="${salaryList}" var="salaryList"
									varStatus="vs">
									<c:if test="${salaryList.cmcd ne '01'}">
										<button type="button" class="btn-check jobType"
											name="salaryCd" id="salary${cnt}"
											data-cd="${salaryList.cmcd}">${salaryList.cmcdNm}</button>
										<label class="btn btn-outline-primary" for="salary${cnt}">${salaryList.cmcdNm}</label>
										<c:set var="cnt" value="${cnt + 1}" />
									</c:if>
								</c:forEach>
							</div>
							<div id="resultDiv">
								<span class="input-group-append">
									<button type="button" id="searchBtn" class="btn btn-primary" style="float:right; margin-top:53px;">
										 검색
									</button>
								</span>
							</div>
						</div>
							
							<hr>
							<c:set value="${pagingVO.dataList }" var="rList"/>
							<c:choose>
									<c:when test="${empty rList}">
											<p>등록된 이력서가 없습니다</p>
									</c:when>
								
									<c:otherwise>
										<c:forEach items="${rList}" var="rVo" varStatus="vs">
												<div class="row px-3 resumeData ">
												  <input type="hidden" name ="resNo" id="resNo" value="${rVo.resNo}">
												  <div class="col-md-8">
												    <div class="col mt-2 mb-2">
												    	<a class = "text-black fs-5 fw-bold" href="${ctxp}/search/resumedetail?resNo=${rVo.resNo}">${rVo.resTtl}</a>
												    </div>
												    <%-- <div class="col mt-2 mb-2"><span class="text-black">이메일 : ${rVo.prMbrEmail}</span></div>
												    <div class="col mt-2 mb-2"><span class="text-black">주소 : ${rVo.prMbrBscAddr} ${rVo.prMbrDaddr}</span></div> --%>
												    <div class="col-sm-3 mt-2 mb-2">
												    <c:if test="${rVo.careerCd eq '신입'}">
												    	 <span class="text-success">${rVo.careerCd}</span>
												    </c:if>
												    <c:if test="${rVo.careerCd eq '경력'}">
												     	<span class="text-warning">${rVo.careerCd}</span>
												    </c:if>
												    </div>
												    <div class="col-sm-12 mt-2 mb-2">
												    	<c:if test="${not empty rVo.careerYearCd}"> 경력 : ${rVo.careerYearCd} </c:if>
												    	<c:if test="${not empty rVo.salaryCd}"> 희망연봉 : ${rVo.salaryCd}  </c:if>
												    </div>
												    <div class="col-sm-12 mt-2 mb-2">
												    	<c:if test="${not empty rVo.dutyCd}"> 희망 직무/직업 : ${rVo.dutyCd} </c:if>
												    	<c:if test="${not empty rVo.workCd}"> 근무 형태 : ${rVo.workCd} </c:if>
												    </div>
												  </div>
												  <div class="col-md-4 text-end">
												  	<div class="col mt-2 mb-2"></div>
												  	<div class="col mt-2 mb-2"></div>
												  	<div class="col mt-2 mb-2"></div>
												  </div>
												</div>
											<hr>											
										</c:forEach>
									</c:otherwise>	
							</c:choose>		
							
				<!-- 페이징 -->
				<!--Bottom Table UI-->
				<div class="d-flex justify-content-center" style="margin-top: 15px;">
					<!--Pagination -->
					<div class="card-footer clearfix" id="pagingArea">
						<a>${pagingVO.pagingHTML }</a>
					</div>
					<!--/Pagination -->
				</div>

				<!-- greeting 끝 -->
           	</div>
         <!-- sh_content 끝 -->
         </div>
      <!-- sh_container_wrapper 끝 -->
      </div>
   <!-- sh_container 끝 -->
   </div>

<script>
function fdel(pThis){
	var shSpan = pThis.parentElement;
	console.log("aaa",shSpan);
	var resultDiv = document.querySelector("#resultDiv");
	console.log(resultDiv);
	resultDiv.removeChild(shSpan);
//	alert("체킁");
	//$("#resultDiv")[0].removeChild(shSpan);
//	console.log($(pThis).closest("<span>"));
//	$(pThis).closest("<span>").remove();
}


$(function(){
	var searchDiv = $(".searchDiv");
	var searchSalary = $(".searchSalary");
	var searchWork = $(".searchWork");
	var dutyDiv = $("#dutyDiv");
	var careerDiv = $("#careerDiv");
	var workDiv = $("#workDiv");
	var salaryDiv = $("#salaryDiv");
	var searchCareer = $(".searchCareer");
	var divFlag = false;
	var careerFlag = false;
	var workFlag = false;
	var salaryFlag = false;
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	var remove = $(".fa-trash-o");
	console.log(remove);
	
	
	$("#dutyDiv").hide();
	$("#careerDiv").hide();
	$("#salaryDiv").hide();
	$("#workDiv").hide();
	
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	
	searchDiv.on("click", function(){
		if(divFlag) {	// 두번째 클릭
			divFlag = false;
			$("#dutyDiv").hide();
			console.log("확인 : ", divFlag)
		} else {		// 첫번째 클릭
				careerFlag = false;
				salaryFlag = false;
				workFlag = false;
				divFlag = true;
				$("#careerDiv").hide();
				$("#salaryDiv").hide();
				$("#workDiv").hide();
				$("#dutyDiv").show();
				console.log("확인1 : ", divFlag);
		}
	});
	
	$("#searchBtn").on("click", function(){
		
		searchForm.submit();
		
	})
	
	
	searchCareer.on("click", function(){
		
		if(careerFlag) {	// 두번째 클릭
			careerFlag = false;
			$("#careerDiv").hide();
			console.log("확인 : ", careerFlag);
		} else {		// 첫번째 클릭
				divFlag = false;
				careerFlag = true;
				$("#dutyDiv").hide();
				$("#salaryDiv").hide();
				$("#workDiv").hide();
				$("#careerDiv").show();
				console.log("확인1 : ", careerFlag);
		}
	});
	
	searchSalary.on("click", function(){
		
		if(salaryFlag) {	// 두번째 클릭
			salaryFlag = false;
			$("#salaryDiv").hide();
			console.log("확인 : ", careerFlag);
		} else {		// 첫번째 클릭
				divFlag = false;
				careerFlag = false;
				workFlag = false;
				salaryFlag = true;
				$("#dutyDiv").hide();
				$("#careerDiv").hide();
				$("#workDiv").hide();
				$("#salaryDiv").show();
				console.log("확인1 : ", careerFlag);
		}
	});
	
	searchWork.on("click", function(){
		
		if(workFlag) {	// 두번째 클릭
			workFlag = false;
			$("#workDiv").hide();
			console.log("확인 : ", workFlag);
		} else {		// 첫번째 클릭
				divFlag = false;
				careerFlag = false;
				salaryFlag = false;
				workFlag = true;
				$("#dutyDiv").hide();
				$("#careerDiv").hide();
				$("#salaryDiv").hide();
				$("#workDiv").show();
				console.log("확인1 : ", workFlag);
		}
	});
	
	allData = [];

	// 클릭 이벤트 핸들러에서 사용할 함수
/* 	function updateResultDiv(data) {
		console.log(data);
	    var datas = "";
	    for (var i = 0; i < data.length; i++) {
	        datas += data[i] + " ";
	    }
	    $("#resultDiv").html(datas);
	    console.log("datas : ", datas);
	} */

	dutyDiv.on("click", "button", function(){
		var duty = $("<span style='margin-left: 10px; margin-top: 10px; font-size: 20px; color: black;'>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
	    
		console.log(duty);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}

		$("#resultDiv").append(duty);
		
		$("#searchForm").append("<input type='hidden' name='dutyCd' value='"+$(this).data("cd")+"'/>");
	});
	
	salaryDiv.on("click", "button", function(){
		var salary = $("<span style='margin-left: 10px; margin-top: 10px; font-size: 20px; color: black;'>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
	    
		console.log(salary);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}

		$("#resultDiv").append(salary);
		
		$("#searchForm").append("<input type='hidden' name='salaryCd' value='"+$(this).data("cd")+"'/>");
	});
	
	workDiv.on("click", "button", function(){
		var work = $("<span style='margin-left: 10px; margin-top: 10px; font-size: 20px; color: black;'>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
	    
		console.log(work);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}

		$("#resultDiv").append(work);
		
		$("#searchForm").append("<input type='hidden' name='workCd' value='"+$(this).data("cd")+"'/>");
	});
	
	careerDiv.on("click", "button", function(){
	    var career = $("<span style='margin-left: 10px; margin-top: 10px; font-size: 20px; color: black;'>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
		console.log(career);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}
		
		$("#resultDiv").append(career);
		
		$("#searchForm").append("<input type='hidden' name='careerYearCd' value='"+$(this).data("cd")+"'/>");
		//$("#resultDiv").html(datas)
		/*
	    if (!allData.includes(career)) {
	        allData.push(career);
	        updateResultDiv(allData);
	       	console.log("세번째 allData : ", allData);
	    }
		*/
	});
	
	/*
	$(document).on("click",".fa-trash-o",function(){

		console.log($(this));
		console.log("너는? ", allData);
		
        updateResultDiv(allData); // 결과 갱신
		
	})
	*/
	
})
</script>