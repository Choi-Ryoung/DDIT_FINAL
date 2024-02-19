<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
/* 전체 컨테이너 스타일 */
#sh_container {
}

/* 내용을 감싸는 컨테이너 스타일 */
#sh_container_wrapper {
	background-color: #ffffff;
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
				<div class="row">
				    <div class="col-md-12">
			        	<div class="card card-outline card-danger mt-4">
							<img src="${ctxp}/resources/img/main/menu_banner/인재찾기.jpg" width="1100px" height="300px">
						</div>
				    </div>
				</div><hr>
				<!-- 프로필 섹션 -->
				<div class="row align-items-center">
					<div class="col-sm-3 text-center">
						<img class="img-fluid profile-image-pic img-thumbnail my-3" id="provImg" src="${mVo.provPhoto}" alt="Profile Image">
						<%-- <img class="img-fluid profile-image-pic img-thumbnail my-3" id="provImg" src="${ctxp}/resources/img/resume/profile.png" alt="profile" style="width: 210px; height: 280px;"> --%>
					</div>
					<div class="col-sm-9">
						<div class="col mt-2 mb-2 text-black fs-6 px-2 section-header">기본정보</div>
						<hr class="my-hr">
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">이름 : ${mVo.prMbrNm}</div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">연락처 : ${fn:substring(mVo.prMbrTelno, 0, 3)}-${fn:substring(mVo.prMbrTelno, 3, 7)}-${fn:substring(mVo.prMbrTelno, 7, 11)}</div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">이메일 : ${mVo.prMbrEmail}</div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">생년월일 : ${mVo.prMbrBirthdy}</div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">
							성별:
							<c:if test="${mVo.sexdstnCd eq 'M'}">남성</c:if>
							<c:if test="${mVo.sexdstnCd eq 'F'}">여성</c:if>
						</div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">주소: ${mVo.prMbrBscAddr} ${mVo.prMbrDaddr}</div>
						<hr class="my-hr">
					</div>
				</div>
				<!-- 섹션1 -->
				<div class="row mt-4">
					<!-- Left Column -->
					<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
						<!-- 경력 섹션 -->
						<div class="text-black fs-6 px-2 section-header">경력</div>
						<c:set value="${mVo.careerList}" var="careerList" />
						<c:if test="${not empty careerList}">
							<div class="text-black fs-6 px-2 career-item">
								<div class="mb-2">
									<c:forEach items="${careerList}" var="career" varStatus="loop">
										<div class="mb-2">
											<span class="ms-1 fs-5 career-title">${career.coNm}</span>
											<span class="ms-1 fs-6 career-content">${career.jobPosNm}</span><br>
											<span class="ms-1 fs-6 career-content">${career.workBgngYmd} ~ ${career.workEndYmd}</span><br>
											<span class="ms-1 fs-6 career-content">${career.workDeptNm}</span><br>
											<span class="ms-1 fs-6 career-content">${career.assignTaskCn}</span>
										</div>
										<c:if test="${loop.index % 3 == 0 && not loop.last}">
								</div>
								<div class="text-black fs-6 px-2 career-item">
									<div class="mb-2">
						</c:if>
						</c:forEach>
					</div>
				</div>
				</c:if>
			</div>

			<!-- Middle Column -->
			<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
				<!-- 학력 섹션 -->
				<div class="text-black fs-6 px-2 section-header">학력</div>
				<c:set value="${mVo.abgList}" var="abgList" />
				<c:if test="${not empty abgList}">
					<div class="text-black fs-6 px-2 career-item">
						<div class="mb-2">
							<c:forEach items="${abgList}" var="abg" varStatus="loop">
								<div class="mb-2">
									<span class="ms-1 fs-5 career-title">${abg.acbgDtl}</span><br>
									<span class="ms-1 fs-6 career-content">${abg.mtcltnYmd} ~ ${abg.grdtnYmd}</span><br>
									<span class="ms-1 fs-6 career-content">
										<c:if test="${abg.grdtnYn eq '01'}">
											<c:out value="재학" />
										</c:if> <c:if test="${abg.grdtnYn eq '02'}">
											<c:out value="휴학" />
										</c:if> <c:if test="${abg.grdtnYn eq '03'}">
											<c:out value="중퇴" />
										</c:if> <c:if test="${abg.grdtnYn eq '04'}">
											<c:out value="졸업예정" />
										</c:if>
									</span>
								</div>
							<c:if test="${loop.index % 3 == 0 && not loop.last}">
									</div>
								<div class="text-black fs-6 px-2 career-item">
							<div class="mb-2">
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>

	<!-- Right Column -->
	<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
		<!-- 자격증 섹션 -->
		<div class="text-black fs-6 px-2 section-header">자격증</div>
		<c:set value="${mVo.certificateList}" var="certificateList" />
		<c:if test="${not empty certificateList}">
			<div class="text-black fs-6 px-2 career-item">
				<div class="mb-2">
					<c:forEach items="${certificateList}" var="ctfct" varStatus="loop">
						<div class="mb-2">
							<span class="ms-1 fs-6 career-content">${ctfct.qlfcNo}</span><br>
							<span class="ms-1 fs-5 career-title">${ctfct.crtfctNm}</span><br>
							<span class="ms-1 fs-6 career-content">취득일 : <c:out value="${ctfct.crtfctAcqsYmd}" escapeXml="true"></c:out></span><br>
							<span class="ms-1 fs-6 career-content">${ctfct.issueInstNm}</span>
						</div>
						<c:if test="${loop.index % 3 == 0 && not loop.last}">
				</div>
				<div class="text-black fs-6 px-2 career-item">
					<div class="mb-2">
					</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>
</div>
<!-- 섹션1 끝 -->
<!-- 섹션2 -->
<div class="row mt-4">
	<!-- Left Column -->
	<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
		<!-- 경력 섹션 -->
		<div class="text-black fs-6 px-2 section-header">연수</div>
		<c:set value="${mVo.studyList}" var="studyList" />
		<c:if test="${not empty studyList}">
			<div class="text-black fs-6 px-2 career-item">
				<div class="mb-2">
					<c:forEach items="${studyList}" var="study" varStatus="loop">
						<div class="mb-2">
							<span class="ms-1 fs-5 career-title">${study.sdytrnNm}</span><br>
							<span class="ms-1 fs-6 career-content">${study.sdytrnBgngYmd} ~ ${study.sdytrnEndYmd}</span><br>
							<span class="ms-1 fs-6 career-content">${study.instNm}</span><br>
						</div>
						<c:if test="${loop.index % 3 == 0 && not loop.last}">
				</div>
				<div class="text-black fs-6 px-2 career-item">
					<div class="mb-2">
		</c:if>
		</c:forEach>
	</div>
</div>
</c:if>
</div>

<!-- Middle Column -->
<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
	<!-- 학력 섹션 -->
	<div class="text-black fs-6 px-2 section-header">프로젝트 경력</div>
	<c:set value="${mVo.procarList}" var="procarList" />
	<c:if test="${not empty procarList}">
		<div class="text-black fs-6 px-2 career-item">
			<div class="mb-2">
				<c:forEach items="${procarList}" var="procar" varStatus="loop">
					<div class="mb-2">
						<span class="ms-1 fs-5 career-title">${procar.ordererNm}</span><br>
						<span class="ms-1 fs-6 career-content">${procar.orderBgngYmd} ~ ${procar.orderEndYmd}</span><br>
						<span class="ms-1 fs-6 career-content">${procar.mainTask}</span>
					</div>
					<c:if test="${loop.index % 3 == 0 && not loop.last}">
			</div>
			<div class="text-black fs-6 px-2 career-item">
				<div class="mb-2">
	</c:if>
	</c:forEach>
</div>
</div>
</c:if>
</div>

<!-- Right Column -->
<div class="col-md-4" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
	<!-- 자격증 섹션 -->
	<div class="text-black fs-6 px-2 section-header">취업 우대사항</div>
	<c:set value="${mVo.preList}" var="preList" />
	<c:if test="${not empty preList}">
		<div class="text-black fs-6 px-2 career-item">
			<div class="mb-2">
				<c:forEach items="${preList}" var="pre" varStatus="loop">
					<div class="mb-2">
						<span class="ms-1 fs-6 career-content"> <c:if
								test="${pre.milYn eq 'Y' }">
								<c:out value="병역여부 : 예" />
							</c:if> <c:if test="${pre.milYn ne 'Y' }">
								<c:out value="병역여부 : 아니오" />
							</c:if>
						</span><br> <span class="ms-1 fs-6 career-content"> <c:choose>
								<c:when test="${pre.marYn eq 'Y'}">
									<c:out value="결혼여부 : 예" />
								</c:when>
								<c:otherwise>
									<c:out value="결혼여부 : 아니오" />
								</c:otherwise>
							</c:choose>
						</span><br> <span class="ms-1 fs-6 career-content"> <c:choose>
								<c:when test="${pre.disYn eq 'Y'}">
									<c:out value="장애여부 : 예" />
								</c:when>
								<c:otherwise>
									<c:out value="장애여부 : 아니오" />
								</c:otherwise>
							</c:choose>
						</span><br> <span class="ms-1 fs-6 career-content"> <c:choose>
								<c:when test="${pre.ntnMrtYn eq 'Y'}">
									<c:out value="국가보훈 여부 : 예" />
								</c:when>
								<c:otherwise>
									<c:out value="국가보훈 여부 : 아니오" />
								</c:otherwise>
							</c:choose>
						</span><br> <span class="ms-1 fs-6 career-content"> <c:choose>
								<c:when test="${pre.ntnSprtYn eq 'Y'}">
									<c:out value="국가지원 여부 : 예" />
								</c:when>
								<c:otherwise>
									<c:out value="국가지원 여부 : 아니오" />
								</c:otherwise>
							</c:choose>
						</span>
					</div>
				</c:forEach>
				<c:if test="${loop.index % 3 == 0 && not loop.last}">
			</div>
			<div class="text-black fs-6 px-2 career-item">
				<div class="mb-2">
	</c:if>
</div>
</div>
</c:if>
</div>
</div>
<!-- 섹션1 끝 -->
<hr class="me-hr">
<!-- 자기소개서 -->
<div class="col-md-12">
		<div class="text-black fs-6 px-2 section-header">자기소개서</div>
		<c:set value="${mVo.selfList}" var="selfList" />
		<c:if test="${not empty selfList}">
			<div class="text-black fs-6 px-2 career-item">
				<div class="mb-2">
					<c:forEach items="${selfList}" var="sfint" varStatus="loop">
						<div class="mb-2">
							<span class="ms-1 fs-5 career-title">
								<c:if test="${sfint.siTtl eq '01'}">
									<c:out value="가족소개"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '02'}">
									<c:out value="성장과정"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '03'}">
									<c:out value="학창시절"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '04'}">
									<c:out value="교외활동"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '05'}">
									<c:out value="전공선택 이유와 적성"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '06'}">
									<c:out value="성격의 장단점"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '07'}">
									<c:out value="지원동기"/>
								</c:if>
								<c:if test="${sfint.siTtl eq '08'}">
									<c:out value="입사 후 포부"/>
								</c:if>
							</span><br>
							<span class="ms-1 fs-6 career-content" style="white-space: pre-wrap">${sfint.siCn}</span>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if>
					<div class="text-black fs-6 px-2 career-item">
						<div class="mb-2">
						</div>
					</div>
				</div>
			<hr class="me-hr"/>
<!-- 자기소개서 끝 -->
				<button type="button" class="btn btn-outline-danger btn-lg btnSize" id="proposalBtn">제안하기</button>
			</div>
		</div>
	</div>
</div>
<script>
/* $(function() {
	var proposalBtn = $("#proposalBtn");
	
	proposalBtn.on("click", function(){
		Swal.fire({
			  title: "제안 문자를 보내시겠습니까?",
			  showDenyButton: true,
			  confirmButtonText: "예",
			  denyButtonText: "아니오"
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire("예", "", "success");
			  } else if (result.isDenied) {
			    Swal.fire("아니오", "", "info");
			  }
			});
		
		
		if(confirm("제안 문자를 보내시겠습니까?")) {
			
			$.ajax({
				url: "/search/resumeDetail.do",
				type: "POST",
				data: null,
				contentType:'application/json;charset=UTF-8',
				success: function (res) {
					console.log("전송 성공 : ", res);
					
					if(res.result == "success"){
						Swal.fire({
							  position: "top-end",
							  icon: "success",
							  title: "Your work has been saved",
							  showConfirmButton: false,
							  timer: 1500
							});
						location.href = "/search/searchdutylist";						
					} else if(res.result == "fail"){
						alert("전송 실패!");
						return;
					}

				}
			});
		}
	})
}) */

$(function() {
    var proposalBtn = $("#proposalBtn");

    proposalBtn.on("click", function() {
        Swal.fire({
            title: "제안 문자를 보내시겠습니까?",
            showDenyButton: true,
            confirmButtonText: "예",
            denyButtonText: "아니오"
        }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {

                // Ajax 호출
                $.ajax({
                    url: "/search/resumeDetail.do",
                    type: "POST",
                    data: null,
                    contentType: 'application/json;charset=UTF-8',
                    success: function(res) {
                        console.log("전송 성공 : ", res);

                        if (res.result == "success") {
                            Swal.fire({
                                icon: "success",
                                title: "정상적으로 전송되었습니다",
                                showConfirmButton: false,
                                timer: 1500
                            });
                        } else if (res.result == "fail") {
                        	Swal.fire({
                                icon: "error",
                                title: "전송 실패하였습니다.",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            return;
                        }
                    }
                });

            } else if (result.isDenied) {
                Swal.fire("아니오", "", "info");
            }
        });
    })
})
</script>