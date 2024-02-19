<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>

img {

	border-radius: 4px; /* 이미지 모서리를 둥글게 만듭니다. */
	padding: 5px; /* 테두리와 이미지 사이의 간격 조절 */
}

@keyframes blink-effect {
  50% {
    opacity: 0;
  }
}
</style>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/announcement/list'">채용공고</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/briefing/list'">채용설명회</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/채용공고.jpg" width="1100px" height="300px">
							</div>
						</div>
					</div>
				</div>
				<br>
				
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="submit" class="btn me-md-2" id="newBtn">
							<i class="fas btn btn-success">채용공고 등록</i>
					</button>
				</div>
				
				<br>

				<c:set value="${pagingVO.dataList }" var="employmentList" />
				<div class="container-fluid">
					<div>
						<div class="row">
							<c:choose>
								<c:when test="${empty employmentList }">
									<h1> 채용공고 없음!</h1>
								</c:when>
								<c:otherwise>
									<c:forEach items="${employmentList }" var="employment" varStatus="vs">
											<hr>
												<div class="row px-3 resumeData" data-no="${employment.empmnPbancNo}">
												  <div class="col-md-2 mb-3">
												    	<img src="${ctxp}${employment.logoImg }" alt="" class="img-fluid card-img-top" width="230" height="230">
												  </div>
												  <div class="col-sm-7 mt-2 mb-2">
												    	<a class = "text-black fs-5 fw-bold" href="/announcement/detail?empmnPbancNo=${employment.empmnPbancNo}" title="${employment.empmnPbancTtl }">${employment.empmnPbancTtl }</a>
												    	<div class="col mt-2 mb-2">
												   		<%-- 성별 : ${employment.genderCd}   --%> 
												   			경력 사항 : ${employment.careerCd }
												 	 	</div>
												 		<div class="col mt-2 mb-2 text-danger">
												    		공고 마감일 : ${fn:substring(employment.empmnPbancDdlnYmd, 0, 4)}년 ${fn:substring(employment.empmnPbancDdlnYmd, 5, 7)}월 ${fn:substring(employment.empmnPbancDdlnYmd, 8, 10)}일<br>
												    		<%-- 지역 : ${employment.rgn } --%> 
												  		</div>
												  		<div class="col mt-2 mb-2 text-primary">
												    		직무 : ${employment.dutyCd}
												  		</div>
												  		<div class="col mt-2 mb-2">
												  		</div>
												  </div>
												  <div class="col-sm-3 ">
												  	<div class="col mt-3 mb-3 text-end">
												  		<a class = "btn btn-outline-success delResBtn" id="applyCnt_${employment.empmnPbancNo}" style="animation: ;" href="${ctpx}/entapply/list?empmnPbancNo=${employment.empmnPbancNo}">지원자 ${applicantList[vs.index]} 명</a>
												  		<a class = "btn btn-outline-success delResBtn" href="javascript:void(0);">최종합격 ${applicantAllPassCntList[vs.index]}명</a>
												  	</div>
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
	</div>
</div>


<script type="text/javascript">

function timer() {
    $.ajax({
        type: "POST",
        url: "/apply/newBell",
        success: function (res) {
        	if(res.length > 0) {
	        	$('.resumeData').each(function() {
	        		let flag = false;
	        		const empmnPbancNo = $(this).data("no");
	        		for(let i=0; i < res.length; i++) {
	        			if(empmnPbancNo == res[i].empmnPbancNo) {
	        				$("#applyCnt_" + empmnPbancNo).css("animation", "blink-effect 1s step-end infinite");
	        				flag = true;
	        				break;
	        			}
	        		}
	        		
	        		if(!flag) {
	        			$("#applyCnt_" + empmnPbancNo).css("animation", "none"); // 애니메이션을 멈추는 경우
	        		}
	        	});
        	}
        	
        	/* 
            if (res > 0) {
                $("#applyCnt").css("animation", "blink-effect 1s step-end infinite");
            } else {
                $("#applyCnt").css("animation", "none"); // 애니메이션을 멈추는 경우
            }
             */
        },
        error: function () {
            console.log("서버 오류 발생. 다시 시도해주세요.");
        }
    });
}

timer();
setInterval(timer, 1000); 

$(function(){
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	newBtn.on("click", function(){
		location = "/announcement/insert";
	})
	
	
    // 공고 마감일이 null이면 '상시채용'으로 표시
	$(".text-danger").each(function() {
		var deadline = $(this).text().trim();
		if (deadline == "공고 마감일 : 년 월 일") {
			$(this).text("공고 마감일 : 상시채용");
		}
	});
	
	
});
</script>