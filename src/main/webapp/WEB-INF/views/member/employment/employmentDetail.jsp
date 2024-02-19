<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=333244cf97d81be4e95fc71e60d91a74&libraries=services"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }" />


<script>

$(function(){
	
	var deadLine = $('#deadLine').text();
	var deadLine2 = $('#allnull1').text();
	var deadLine3 = $('#allnull2').text();
	var deadLine4 = $('#allnull3').text();
	
	if(deadLine === "년 월 일까지"){
		$('#deadLine').text("상시채용");
	}
	if(deadLine2 === "년 월 일"){
		$('#nullval1').remove();
	}
	if(deadLine3 === "년 월 일"){
		$('#nullval2').remove();
	}
	if(deadLine4 === "년 월 일"){
		$('#nullval3').remove();
	}

	// KakaoMap API 사용 자원들
	var mapContainer = null;
	var map = null;
	var geocoder = null; 
	
	const empBackBtn = $("[empBackBtn]");
	const applyBtn = $("#applyBtn");
	
	applyBtn.on("click", function(){
		   var resumeChk = document.getElementById('resumeFiles');
		    var applyVO = new FormData(applyForm);

		    // 파일이 존재하는 경우 FormData에 추가
		    if(resumeChk.files.length > 0) {
		    	applyVO.append('resumeFiles', resumeChk.files[0]);
		    } else {
		        alert("이력서가 첨부되지 않았습니다.");
		        return false;
		    }

		    // AJAX 요청 보내기
		    $.ajax({
		        url: '/apply/insert.do',
		        type: 'POST',
		        data: applyVO,
		        processData: false,
		        contentType: false,
		        success: function(response) {
		            // 성공적으로 서버에서 응답을 받았을 때 처리
		            if(confirm("지원이 완료되었습니다.\n나의 지원내역으로 바로 이동하시겠습니까?")) {
		                location.href = "/member/mypage/applyList";
		            }
		            else
		            {
		            	//location.href = "/employment/detail?empmnPbancNo="+${employment.empmnPbancNo};
		            	location.reload();
		            }
		        },
		        error: function(xhr, status, error) {
		            // 에러 처리
		            alert("오류가 발생하였습니다: " + error);
		        }
		    });

	});

	empBackBtn.on("click", function(){
		location.href="/employment/list";
	});
	
	
	// 카카오맵 주소로 뜨게 하기
	/* var address = $("#address").val(); */
	var address = "${employment.powkNm }";
	
	if(address != null && address != ""){
		// map 공간에 지도를 출력
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapContainer.style.display = "block"; 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(address, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">본사</div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});   
		/*$("#card-signup").css("top", "140px"); */
	}
});

</script>


<style>
.redf{
	color : blue;
}

#empcn {
	overflow: auto;
	width: 50%;
	height: 850px;
}

#wTitle{
	font-weight: bold;
}

</style>

<!-- Modal -->
<form action="${ctxp }/apply/insert.do" method="post" id="applyForm" enctype="multipart/form-data">
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-black fs-5" id="exampleModalLabel">${employment.empmnPbancWrtrNm }&nbsp;지원하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h2>이력서 첨부&emsp;(jpg, jpeg, pdf)</h2><br>
					<input type="file" name="resumeFiles" id="resumeFiles" accept="image/jpeg, image/jpg, .pdf">
					<input type="hidden" name="entMbrId" value="${employment.entMbrId}">
					<input type="hidden" name="empmnPbancNo" value="${employment.empmnPbancNo}">
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" value="지원하기" id="applyBtn" />
					<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
				</div>
			</div>
		</div>
	</div>
</form>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs " id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/employment/list'">채용공고</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/employment/briefingList'">채용설명회</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onClick="location.href='${cxtp}/member/jobAssist'">취업도우미</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4 mb-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/채용공고.jpg" width="1100px" height="300px">
							</div>
						</div>
					</div>
				</div>

				<hr>
				<div class="container mt-2 mb-3 text-black">
					<br>
					<h1 class="display-6 text-truncate" id="wTitle" title="${employment.empmnPbancTtl }">${employment.empmnPbancTtl}</h1>
					<br>
					<hr>
					<br>
					<div class="row">
						<div id="empcn" class="col-md-6 border p-3">
							<!-- 왼쪽 영역의 내용 -->
							<span class="lead">공고내용</span>
							<pre>${employment.empmnPbancCn }</pre>

							<span class="lead"></span>
						</div>
						<div class="col-md-6 border p-3">
							<!-- 오른쪽 영역의 내용 -->
							경력&nbsp; : &nbsp;<span class="redf">${employment.careerCd }</span><br>
							<br> 성별&nbsp; : &nbsp;<span class="redf">${employment.genderCd }</span><br>
							<br> 학력&nbsp; : &nbsp;<span class="redf">${employment.acbgCd }</span><br>
							<br> 근무지역&nbsp; : &nbsp;<span class="redf">${employment.rgn }&nbsp;${employment.sigungu }</span><br>
							<br> 마감일&nbsp; : &nbsp;
							<span id="deadLine" class="redf">${fn:substring(employment.empmnPbancDdlnYmd, 0, 4)}년 ${fn:substring(employment.empmnPbancDdlnYmd, 5, 7)}월 ${fn:substring(employment.empmnPbancDdlnYmd, 8, 10)}일까지</span><br>
							<span id="nullval1"><br> 이력서 마감일자&nbsp; : &nbsp;
							<span id="allnull1" class="redf">${fn:substring(employment.docPassYmd, 0, 4)}년 ${fn:substring(employment.docPassYmd, 5, 7)}월 ${fn:substring(employment.docPassYmd, 8, 10)}일</span><br></span>
							<span id="nullval2"><br> 면접 응시일자&nbsp; : &nbsp;
							<span id="allnull2" class="redf">${fn:substring(employment.interviewPassYmd, 0, 4)}년 ${fn:substring(employment.interviewPassYmd, 5, 7)}월 ${fn:substring(employment.interviewPassYmd, 8, 10)}일</span><br></span>
							<span id="nullval3"><br> 코딩테스트 응시일자&nbsp; : &nbsp;
							<span id="allnull3" class="redf">${fn:substring(employment.codingPassYmd, 0, 4)}년 ${fn:substring(employment.codingPassYmd, 5, 7)}월 ${fn:substring(employment.codingPassYmd, 8, 10)}일</span><br></span>
							<br> 본사위치&nbsp; : &nbsp;<span class="redf">${employment.powkNm }</span>
							
							<br>
							<br>
							<div id="map" style="width: 100%; height: 300px; display: none;"></div>
						</div>
					</div>
					<br>
					<br>
					<div class="d-grid gap-2 d-md-flex justify-content-md-center">
						<div class="row justify-content-center">
							<div class="input-group mb-3 text-center">
								<button type="button" class="btn me-md-2" id="applyBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">
									<i class="fas btn btn-success">지원하기</i>
								</button>
						
								<button type="button" class="btn me-md-2" id="empBackBtn" empBackBtn>
									<i class="fas btn btn-secondary">뒤로가기</i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
