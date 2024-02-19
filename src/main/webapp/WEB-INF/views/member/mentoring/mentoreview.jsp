<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
    background-color: cornflowerblue;
    /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

.card-body img {
    width: 20rem;
}

.card-footer button {
    margin-right: 5px;
}

.btn-secondary {
    color: #fff;
    background-color: #6c757d;
    border-color: #6c757d;
}

/* 전체 컨테이너 스타일 */
#sh_container {
	padding: 20px;
}

/* 내용을 감싸는 컨테이너 스타일 */
#sh_container_wrapper {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* 각 섹션의 헤더 스타일 */
.section-header {
	font-size: 2rem;
	color: #333333;
	margin-bottom: 20px;
}

/* 프로필 이미지 스타일 */
.profile-image-pic {
	width: 210px;
	height: 280px;
}

/* 각 정보 항목 스타일 */
.info-item {
	margin-top: 15px;
	margin-bottom: 15px;
	font-size: 1rem;
	color: #333333;
}

/* 가로선 스타일 */
.custom-hr {
	margin: 0.4rem 0;
	color: black;
	background-color: currentColor;
	opacity: 0.5;
	height: 2px;
}

/* 경력 항목 스타일 */
.career-item {
	margin-bottom: 20px;
}

/* 경력 제목 스타일 */
.career-title {
	font-size: 1.5rem;
	color: #333333;
	margin-bottom: 10px;
}

/* 경력 내용 스타일 */
.career-content {
	font-size: 1rem;
	color: #555555;
}

.my-hr {
	width: 40%;
}

.me-hr {
	width: 100%;
}

.btnSize{
	width: 500px;
	margin-left: 30%;;
}

</style>

<div id="sh_container">
    <div id="sh_container_wrapper">
        <div id="sh_content">
            <div id="greeting" class="pagecommon">
                <!-- 아래로 콘텐츠 추가  -->
                <div>
                    <!-- <div class="bd-example"></div> -->
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
                <div class="bd-example">
			        <nav>
			          <div class="nav nav-tabs " id="nav-tab" role="tablist">
			            <button class="nav-link active mentoDetail" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">멘토 정보</button>
			            <button class="nav-link active mentoReview" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"  type="button" role="tab" aria-controls="nav-profile" aria-selected="false">멘토 리뷰</button>
			            <form class="input-group input-group-sm" method="post" id="searchForm" style="width: 440px;">
			            
						</form>
			          </div>
			        </nav>
			     </div>
                <div>
                	<div class="row align-items-center">
					<div class="col-sm-3 text-center">
						<c:set value="${mento.menFileList}" var="menFileList" />
                        <c:if test="${not empty menFileList}">
                            <div class="row">
                                <c:forEach items="${menFileList}" var="mentoFile">
                                    <c:choose>
                                        <c:when test="${fn:split(mentoFile.menFileMime, '/')[0] eq 'image'}">
                                            <img src="/resources/profile/${mento.menNcnm}/${fn:split(mentoFile.menFileSavepath, '/')[1]}" style="width: 14rem;" alt="img-blur-shadow">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty menFileList }">
                        	<img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg" style="width: 20rem;">
                        </c:if>
					</div>
					<div class="col-sm-9">
						<div class="col mt-2 mb-2 text-black fs-6 px-2 section-header" style="padding-top:5px;">멘토정보</div>
						<hr class="my-hr">
						<br>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">닉네임 : <c:out value="${mento.menNcnm}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">직무정보 : <c:out value="${mento.applyTaskCd}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">경력정보 : <c:out value="${mento.applyCareerCd}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">
							<c:set value="${mento.tagList}" var="tagList"/>
                            <c:if test="${not empty tagList}">
                                <c:forEach items="${tagList}" var="tag">
                                    <c:if test="${tag ne null}">
                                        <span class="badge bg-warning">#<c:out value="${tag.menTag}" escapeXml="true"></c:out></span>
                                    </c:if>
                                    <c:if test="${tag eq null}"></c:if>
                                </c:forEach>
                            </c:if>
						</div>
						<br>
						<hr class="my-hr">
					</div>
				</div>
				<div class="col-md-12">
		<div class="text-black fs-6 px-2">소개글</div>
			<div class="text-black fs-6 px-2 career-item">
							<span class="ms-1 fs-5 career-title" style="white-space: pre-line">
								<c:out value="${mento.menIndt }"></c:out>
							</span><br>
									</div>
							</div>
			<hr class="me-hr"/>
                    <div class="col-md-12">
                        <input type="hidden" name="prMbrId" value="${SessionInfo.prMbrId}" />
                        <input type="hidden" name="prMbrNcnm" value="${SessionInfo.prMbrNcnm}" />
                    </div>
                    <div class="col-md-12">
                        <input type="hidden" name="prMbrId" id="mentiId" value="${mentiVO.prMbrId}" />
                        <input type="hidden" name="prMbrNcnm" id="mentiNcnm" value="${mentiVO.prMbrNcnm}" />
                        <input type="hidden" name="mentiYn" id="mentiYn" value="${mentiVO.mentiYn}" />
                        <input type="hidden" name="menNcnm" id="mentoNcnm" value="${mentiVO.menNcnm}" />
                    </div>
                </div>
                <!-- 여기까지 -->
            </div>
			<div class="col-md-12 pt-5">
			<div class="card">
				<div class="card-header">
					<h5 class="card-title">리뷰 목록</h5>
				</div>
				<div class="card-body" id="rvBody">
					<c:if test="${not empty reviewList }">
						<c:forEach items="${reviewList }" var="review">
							<div class="card" data-rv-no="${review.menrvNo }" data-men-ncnm="${review.menNcnm }">
								<div class="card-header pt-2">
									<div class="d-flex justify-content-between align-items-center">
						                <div class="btn-group" id="btnGroup">
						                	<span id="prMbrNcnm2">${review.prMbrNcnm }</span>
						                </div>
						                <small class="text-body-secondary">
						                	<i class="bi-pencil-fill" id="menrvUdt"></i>
						                	<i class="bi-trash-fill" id="menrvDel"></i>
						                </small>
						              </div>
								</div>
								<div class="card-body"> 
									<pre><c:out value="${review.menrvPstCn }" escapeXml="true"/></pre>
								</div>	
							</div>
							<br/>
						</c:forEach>
					</c:if>
				</div>
			</div>
            	<br><br>
            		<form action="/mento/deleteReview" id="deleteForm" method="post">
						<input type="hidden" name="menNcnm" id="rvMenNcnm" value="${mento.menNcnm }" />
						<input type="hidden" name="menrvNo" id="menrvNo" value=""/>
						<input type="hidden" name="menrvPstCn" id="menrvPstCn" value=""/>
						
						<input type="hidden" name="menrvWrtDt" id="menrvWrtDt" value=""/>
					</form>
            		<div class="card-footer" id="insertForm">
						<form action="/mento/addReview" method="POST">
							<input type="hidden" name="menNcnm" value="${mento.menNcnm }" />
							<input type="hidden" name="prMbrNcnm" id="menrvncnm" value="${review.prMbrNcnm }"/>
							<textarea style="width:100%; height: 80px; white-space: pre;" cols="70" rows="2" name="menrvPstCn" placeholder="리뷰 내용을 입력해주세요."></textarea>
							<input type="submit" class="btn btn-outline-primary" value="등록" /> 
						</form>
					</div>
					<br>
                       <button type="button" class="btn btn-outline-info" id="listBtn" onclick="javascript:location.href='/mento/list'" style="float: right;">목록</button>
            	<br><br>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	var insertForm = $("#insertForm");
	var mentiNcnm = "${mentiVO.menNcnm}";
	console.log("mentiNcnm : " + mentiNcnm);
	var prMbrNcnm = "${SessionInfo.prMbrNcnm}";
	console.log("prMbrNcnm : " + prMbrNcnm);
	var mentoDetail = $(".mentoDetail");
	var mentoReview = $(".mentoReview");
	var menNcnm = "${mento.menNcnm }";
	var rvMenNcnm = "${mentiInfo.menNcnm }";
	console.log("menNcnm : ", menNcnm);
	console.log("rvMenNcnm : ", rvMenNcnm);
	var mentiYn = $("#mentiYn").val();
	console.log("mentiYn : " + mentiYn);
	
	//var prMbrNcnm2 = $('#prMbrNcnm2').text();
	var prMbrNcnm2 = "${review.prMbrNcnm }";
	console.log("prMbrNcnm2 : ", prMbrNcnm);
	
	mentoDetail.on("click", function(){
		mentoDetail.css("background-color", "lightgray");
		location.href = "/mento/find?menNcnm=" + menNcnm;
	})
	
	mentoReview.on("click", function(){
		mentoReview.css("background-color", "lightgray");
		location.href = "/mento/review?menNcnm=" + menNcnm;
	});
	
	insertForm.hide();
	if (mentiYn === "Y") {
	    insertForm.show();
	}
	/* 클릭이벤트 끝 */
	
	// 리뷰 컨텐츠 영역
	var rvBody = $("#rvBody");	// 리뷰 영역 body
	
	// 리뷰 수정 아이콘 클릭 시
	rvBody.on("click", "#menrvUdt", function(){
		console.log("수정 버튼 누름!");
		var rvNo = $(this).parents(".card").data("rv-no");
		$("#deleteForm").find("#menrvNo").val(rvNo);
		
		var body = $(this).parents(".card").find(".card-body");
		
		var html = "<textarea cols='70' rows='2' style='width:100%;' id='rvtInCn'>"+body[0].innerText+"</textarea>";
		html += "<button class='btn btn-sm btn-primary' id='rvInUdtBtn'>수정</button><button class='btn btn-sm btn-danger' id='rvtInCancelBtn'>취소</button>";
		body[0].innerHTML = html;
	});
	
	rvBody.on("click", "#rvInUdtBtn", function(){
		var rv = $(this).parents(".card-body").find("#rvtInCn").val();
		$("#menrvPstCn").val(rv);
		$("#deleteForm").attr("action", "/mento/updateReview");
		$("#deleteForm").submit();
	});
	
	rvBody.on("click", "#rvtInCancelBtn", function(){
		var rv = $(this).parents(".card-body").find("#rvtInCn").text();
		var body = $(this).parents(".card-body");
		body[0].innerHTML = rv;
	});
	
	rvBody.on("click", "#menrvDel", function(){
		console.log("삭제 버튼을 눌렀습니다!");
		var rvNo = $(this).parents(".card").data("rv-no");
		var menNcnm = $(this).parents(".card").data("men-ncnm");
		
		if(confirm("정말로 삭제하시겠습니까?")){
			 $("#menrvNo").val(rvNo);
			 $("#deleteForm").submit();
		}
	});
	
</script>



