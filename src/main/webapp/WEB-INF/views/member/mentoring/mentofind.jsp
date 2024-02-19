<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                        <button type="button" class="btn btn-outline-primary" id="mentoBtn" onclick="getPay()">대화 신청하기</button>
                        <input type="hidden" name="aprvYn" id="aprvYn" value="${mento.aprvYn}" />
                        <button type="button" class="btn btn-outline-primary" id="chatBtn">채팅방 이동</button>
                       	<button type="button" class="btn btn-outline-warning" id="modifyBtn" style="float: right;">수정</button>
                        <!-- <button type="button" class="btn btn-danger" id="delBtn">삭제</button> -->
                        <button type="button" class="btn btn-outline-info" id="listBtn" style="float: right;" onclick="javascript:location.href='/mento/list'">목록</button>
                    <div class="col-md-12">
                        <input type="hidden" name="prMbrId" value="${SessionInfo.prMbrId}" />
                        <input type="hidden" name="prMbrNcnm" value="${SessionInfo.prMbrNcnm}" />
                        <input type="hidden" name="prMbrId" id="settleId" value="${settleInfo.prMbrId}" />
                    </div>
                    <div class="col-md-12">
                        <input type="hidden" name="prMbrId" id="mentiId" value="${menti.prMbrId}" />
                        <input type="hidden" name="prMbrNcnm" id="mentiNcnm" value="${menti.prMbrNcnm}" />
                        <input type="hidden" name="menNcnm" id="mentoNcnm" value="${menti.menNcnm}" />
                    </div>
                    <div>
                        <input type="hidden" name="roomNo" id="roomNo" value="${roomVO.roomNo}" />
                    </div>
                    <form action="/mento/remove" method="post" id="delForm">
                        <input type="hidden" name="menNcnm" value="${mento.menNcnm}" />
                    </form>
                </div>
                <!-- 여기까지 -->
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
	var mentoDetail = $(".mentoDetail");
	var mentoReview = $(".mentoReview");
	var prMbrId = "${SessionInfo.prMbrId}";
	var prMbrNcnm = "${SessionInfo.prMbrNcnm}";
	var menNcnm = "${mento.menNcnm}";
	var mentiId = $("#mentiId").val();
	var mentiNcnm = $("#mentiNcnm").val();
	var mentoNcnm = $("#mentoNcnm").val();
	var roomNo = $("#roomNo").val();
	var procCd = "${mento.procCd}";
	var aprvYn = "${mento.aprvYn}";
	var rjctRsn = "${mento.rjctRsn}";
	console.log("rjctRsn : " + rjctRsn);
	console.log("procCd : " + procCd);
	console.log("aprvYn : " + aprvYn);
	console.log("roomNo : " + roomNo);
	console.log("mentiId : " + mentiId);
	console.log("mentiNcnm : " + mentiNcnm);
	console.log("mentoNcnm : " + mentoNcnm);
	var menNcnmVal = document.getElementsByName("menNcnm")[0].value;
	var mentoBtn = document.getElementById("mentoBtn");
	var reviewForm = $("#reviewForm");
	console.log(menNcnm + mentoBtn + prMbrId + prMbrNcnm);
	/* location.href = "/mento/pay"; */
	// 멘토 신청한 회원의 상태가 현재 대기중일 때
	if (menNcnm == prMbrNcnm && procCd == "대기중") {
		location.href = "/mento/alert?menNcnm="+menNcnm;
	// 멘토 신청한 회원의 상태가 현재 반려 상태일 때
	} else if (menNcnm == prMbrNcnm && procCd == "반려") {
		location.href = "/mento/alert2?menNcnm="+menNcnm;
	}
	
	if (menNcnm != prMbrNcnm && procCd == "대기중") {
		location.href = "/mento/alert?menNcnm="+menNcnm;
	} else if (menNcnm != prMbrNcnm && procCd == "반려") {
		location.href = "/mento/alert2?menNcnm="+menNcnm;
	}

	if (menNcnm == prMbrNcnm) {
		mentoBtn.innerHTML = "대화관리";
	} else {
		mentoBtn.innerHTML = "대화 신청하기";
	}
	$(function() {
		var modifyBtn = $("#modifyBtn");
		var delBtn = $("#delBtn");
		var delForm = $("#delForm");
		var mentoBtn = $("#mentoBtn");
		var aprvYn = $("#aprvYn").val();
		var chatBtn = $("#chatBtn");

		modifyBtn.on("click", function() {
			delForm.attr("action", "/mento/modify");
			delForm.attr("method", "get");
			delForm.submit();
		});

		delBtn.on("click", function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				delForm.submit();
			}
		});

		chatBtn.hide();

		if (mentoNcnm == menNcnm && mentiId == prMbrId) {
			mentoBtn.hide();
			chatBtn.show();
		}

		chatBtn.on("click", function() {
			location.href = "/mento/chat?roomNo=" + roomNo;
		});

		if (menNcnm != prMbrNcnm) {
			modifyBtn.hide();
			/* delBtn.hide(); */
		}

		mentoBtn.on("click", function() {
			if ($(this).html() == '대화관리') {
				location.href = "/mento/mentilist?menNcnm=" + menNcnm;
			} else {
				getPay();
			}
		});

	});
	
	mentoDetail.on("click", function(){
		mentoDetail.css("background-color", "lightgray");
		location.href = "/mento/find?menNcnm=" + menNcnm;
	})
	
	mentoReview.on("click", function(){
		mentoReview.css("background-color", "lightgray");
		location.href = "/mento/review?menNcnm=" + menNcnm;
	})
	
	function getPay() {
		location.href = "/mento/pay?menNcnm=${mento.menNcnm}";
	}

	function mentoList() {
		location.href = "/mento/list";
	}
</script>



