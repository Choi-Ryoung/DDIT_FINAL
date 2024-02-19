<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctxp" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" type="text/css" media="screen"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
	border: 0;
}
</style>

<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->

				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/나의이력서.jpg" width="1100px" height="300px">
								</div>
						</div>
						<br>
					</div>
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-home" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/mypage/myInfo'">회원
								정보</button>
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/member/mentoUpdate'">멘토링
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
								onclick="location.href='${ctxp}/member/chart'">나의
								통계</button>
							<button class="nav-link active" data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="true"
								onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서
								관리</button>
						</div>
					</nav>
				</div>
				
				<div class="card-body">
					<div class="row align-items-center formDiv">
						<div class="col-md-10">
							<span class="col-md-9 mx-2 text-black fs-4"><c:out
									value="${prMbrNm}" escapeXml="true"></c:out>님의 이력서</span>
						</div>
						<div class="col-md-2 text-end">
							<span><a class="btn btn-primary addBtn bg-custom "
								href="${ctxp}/member/mypage/resumeInsert">이력서 등록</a></span>
						</div>
					</div>
					<hr>

					<c:choose>
						<c:when test="${empty rList}">
							<p>등록된 이력서가 없습니다</p>
						</c:when>

						<c:otherwise>
							<c:forEach items="${rList}" var="rVo" varStatus="vs">
								<hr>
								<div class="row px-3 resumeData ">
									<input type="hidden" name="resNo" id="resNo"
										value="${rVo.resNo}">
									<div class="col-md-8">
										<div class="col mt-2 mb-2">
											<c:if test="${rVo.rprsvResYn eq 'Y'}">
												<span class="text-primary fs-6 ">대표 이력서&emsp;</span>
											</c:if>
											<a class="text-black fs-5 fw-bold"
												href="${ctxp}/member/mypage/resumeDetail?resNo=${rVo.resNo}">${rVo.resTtl}</a>
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
											<c:if test="${not empty rVo.careerYearCd}"> 희망 경력 : ${rVo.careerYearCd} </c:if>
											<c:if test="${not empty rVo.salaryCd}"> 희망 연봉 : ${rVo.salaryCd}  </c:if>
										</div>
										<div class="col-sm-12 mt-2 mb-2">
											<c:if test="${not empty rVo.dutyCd}"> 희망 직무/직업 : ${rVo.dutyCd} </c:if>
											<c:if test="${not empty rVo.workCd}"> 근무형태 : ${rVo.workCd} </c:if>
										</div>
										<div class="col-sm-8 mt-2 mb-2">
											<a
												class="text-primary text-decoration-underline openWorkCondition"
												href="javascript:void(0);">희망 근무조건 수정</a>
										</div>
										<div class="col mt-3 mb-3 bg-light px-2 rounded">
											<c:if test="${empty rVo.resMemo }">
												<a class="text-black openResMemo "
													href="javascript:void(0);"><i
													class="bi bi-file-earmark-text"></i>&emsp;이력서에 관련된 중요한 내용을
													메모해보세요. ex)11월 25일까지 삼성전자에 제출 </a>
											</c:if>
											<c:if test="${not empty rVo.resMemo }">
												<a class="text-black openResMemo "
													href="javascript:void(0);"><i
													class="bi bi-file-earmark-text"></i>&emsp;${rVo.resMemo}</a>
											</c:if>
										</div>
									</div>
									<div class="col-md-4 text-end">
										<div class="col mt-2 mb-2"></div>
										<div class="col mt-2 mb-2"></div>
										<div class="col mt-2 mb-2"></div>
										<c:if test="${rVo.rprsvResYn eq 'N'}">
											<a
												class="btn btn-primary bg-custom  btn-inline setRprsResBtn"
												href="javascript:void(0);">대표이력서 설정</a>
											&emsp;
										</c:if>
										<a class="btn btn-primary bg-custom  btn-inline delResBtn"
											href="javascript:void(0);">삭제</a>
									</div>
								</div>
								<hr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="resMemoModal" tabindex="-1"
	aria-labelledby="resMemoModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title fs-6 text-black fw-bold"
					id="exampleModalLabel">메모 입력<br></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form>
					<div class="mb-2">
						<span class="modal-title fs-6 text-black px-5 "
							id="exampleModalLabel">이력서가 삭제될 경우, 작성한 메모 내용도 삭제됩니다.</span><br>
						<textarea class="form-control mt-3" id="resMemo" rows="10"
							placeholder="메모를 입력하세요."></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary memoSaveBtn">저장</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="workConditionModal" tabindex="-1"
	aria-labelledby="workConditionModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title fs-6 text-black fw-bold"
					id="exampleModalLabel">근무 조건 수정<br></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form>
					<div class="row align-items-center mb-3">
						<div class="mb-3 text-center">
							<span class="modal-title fs-6 text-black" id="exampleModalLabel">희망
								근무 조건을 설정하면 근무 조건을 반영한 추천 공고와 포지션 제안을 받을 수 있습니다.</span>
						</div>
						<div class="col-md-3 mb-1 px-5 fs-6 text-black text-center">
							직무</div>
						<div class="col-md-4 mb-1 text-center">
							<select id="dutyCd" name="dutyCd" class="form-select"
								aria-label="Default select example">
								<c:forEach items="${dutyList}" var="dutyVo" varStatus="vs">
									<option value="${dutyVo.cmcd}">${dutyVo.cmcdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row align-items-center mb-3">
						<div class="col-md-3 mb-1 px-5 fs-6 text-black text-center">
							연봉</div>
						<div class="col-md-4 mb-1 text-center">
							<select id="salaryCd" name="salaryCd" class="form-select"
								aria-label="Default select example">
								<c:forEach items="${salaryList}" var="salaryVo" varStatus="vs">
									<option value="${salaryVo.cmcd}">${salaryVo.cmcdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row align-items-center mb-3">
						<div class="col-md-3 mb-1 px-5 fs-6 text-black text-center">
							근무 형태</div>
						<div class="col-md-4 mb-1 text-center">
							<select id="workCd" name="workCd" class="form-select"
								aria-label="Default select example">
								<c:forEach items="${workList}" var="workVo" varStatus="vs">
									<option value="${workVo.cmcd}">${workVo.cmcdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row align-items-center mb-3">
						<div class="col-md-3 mb-1 px-5 fs-6 text-black text-center">
							경력</div>
						<div class="col-md-4 mb-1 text-center">
							<select id="careerYearCd" name="careerYearCd" class="form-select"
								aria-label="Default select example">
								<c:forEach items="${careerList}" var="careerVo" varStatus="vs">
									<option value="${careerVo.cmcd}">${careerVo.cmcdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary workConditionSaveBtn">저장</button>
			</div>
		</div>
	</div>
</div>


<script>

//------------- 희망 근무 조건 설정 ------------------------
$('.openWorkCondition').off('click').on('click', function () {
	
    const resumeData = $(this).closest('.resumeData');
    const resNo = resumeData.find("#resNo").val();
    
    $.ajax({
        type: "POST",
        url: "${ctxp}/member/mypage/getWorkConditionData.do",
        data: {resNo : resNo},
        success: function (response) {
           {
	       		if(response.careerYearCd != null)
	       		{
	       			if(response.careerYearCd.trim() !== "")
	       			{
	       				// 해당 값과 일치하는 option을 선택
	       				$("select[name='careerYearCd'] option[value=" + response.careerYearCd + "]").prop("selected", true);
	       				$("select[name='salaryCd'] option[value=" + response.salaryCd + "]").prop("selected", true);
	       				$("select[name='workCd'] option[value=" + response.workCd + "]").prop("selected", true);
	       				$("select[name='dutyCd'] option[value=" + response.dutyCd + "]").prop("selected", true);
	       			}
	       		}
           }
        }
    });
    
    openWorkConditionModal(resNo);
});

function openWorkConditionModal(resNo) {
    $('#workConditionModal').modal('show');
    
    $(".workConditionSaveBtn").off('click').on('click', () => 
    {
        if (confirm("희망 근무 조건을 저장 하시겠습니까?")) {

            const careerYearCd = $("select[name='careerYearCd']").find(":selected").val();
            const salaryCd =  $("select[name='salaryCd']").find(":selected").val();
            const workCd =  $("select[name='workCd']").find(":selected").val();
            const dutyCd = $("select[name='dutyCd']").find(":selected").val();
            
            const workCondition = 
            {
            	 resNo : resNo,
        	     careerYearCd: careerYearCd,
        	     salaryCd: salaryCd,
        	     workCd: workCd,
        	     dutyCd: dutyCd
            			
            };
        	
        	saveWorkCondition(workCondition);
        }
    });   
    
}

function saveWorkCondition(workCondition) {
	
	const resume = JSON.stringify(workCondition);
    $.ajax({
        type: "POST",
        url: "${ctxp}/member/mypage/saveWorkCondition.do",
        contentType: "application/json",
        data: resume,
        success: function (response) {
            if (response === "OK") {
                alert("희망 근무 조건이 저장되었습니다");
                $('#workConditionModal').modal('hide');
                location.href = `${ctxp}/member/mypage/resumeList`;
            }
        }
    });
}
// ------------- 희망 근무 조건 설정 ------------------------


// ------------- 이력서 메모 ------------------------
$('.openResMemo').off('click').on('click', function () {
    const resumeData = $(this).closest('.resumeData');
    const resNo = resumeData.find("#resNo").val();

    openResMemoModal(resNo);
});

function openResMemoModal(resNo) {
    $('#resMemoModal').modal('show');

    $(".memoSaveBtn").off('click').on('click', () => {
        if (confirm("메모를 저장하시겠습니까?")) {
        	const resMemo = $("#resMemo").val();
        	if(!resMemo)
        	{	
				alert("메모를 입력해주세요");
				return;
        	}

            saveMemo(resNo,resMemo);
        }
    });
}

function saveMemo(resNo,resMemo) {
    $.ajax({
        type: "POST",
        url: `${ctxp}/member/mypage/saveMemo.do`,
        data: { 
        		resNo: resNo ,
        		resMemo : resMemo	
        },
        success: function (response) {
            if (response === "OK") {
                alert("메모가 저장되었습니다");
                $('#resMemoModal').modal('hide');
                location.href = `${ctxp}/member/mypage/resumeList`;
            }
        }
    });
}



$(".setRprsResBtn").off('click').on('click',function(){
	
	if(confirm("대표 이력서를 변경 하시겠습니까?"))
	{
		let resumeData = $(this).closest('.resumeData');
		let resNo = resumeData.find("#resNo").val();
		
		$.ajax({
			 type: "POST",
	            url: "${ctxp}/member/mypage/rprsvResSet.do",
	            data: { resNo: resNo },
	            success: function(response) 
	            {
	            	   if (response === "OK") 
	            	   {
	            			alert("대표 이력서가 변경 되었습니다");	
	                        location.href='${ctxp}/member/mypage/resumeList';
	                      	return;
	                   } 
	            }
		})
	}
	
})

$(".delResBtn").off('click').on('click',function(){
	
	if(confirm("삭제하시겠습니까?"))
	{
		let resumeData = $(this).closest('.resumeData');
		let resNo = resumeData.find("#resNo").val();
		
		$.ajax({
			 type: "POST",
	            url: "${ctxp}/member/mypage/resumeDelete.do",
	            data: { resNo: resNo },
	            success: function(response) 
	            {
	            	   if (response === "OK") 
	            	   {
	            			alert("삭제되었습니다");	
	                       location.href='${ctxp}/member/mypage/resumeList';
	                      	return;
	                   } 
	            }
		})
		
		
	}
	
})



</script>

