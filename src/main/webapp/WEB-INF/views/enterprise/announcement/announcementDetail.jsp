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
	console.log(deadLine);
	console.log(deadLine2);
	console.log(deadLine3);
	console.log(deadLine4);
	
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
	var updateBtn = $("#updateBtn");	// 수정 버튼 Element
	var deleteBtn = $("#deleteBtn");	// 삭제 버튼 Element
	var anoBackBtn = $("#anoBackBtn");	// 뒤로가기 버튼 Element
	var delForm = $("#delForm");		// 수정 및 삭제를 처리할 Form Element
	
	
	anoBackBtn.on("click", function(){
		history.back();
	});
	
	
	
	// 삭제 버튼 클릭 시, confirm 메세지 출력 후 삭제 
	deleteBtn.on("click", function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			delForm.submit();
		}
	});
	
	// 수정 버튼 클릭 시, 수정 페이지 이동
	updateBtn.on("click", function(){
		delForm.attr("action", "/announcement/update");
		delForm.attr("method", "get");
		delForm.submit();
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

.redf {
	color : blue;
	
}

#empcn {
	overflow: auto;
	width: 50%;
	height: 850px;
}

#eTitle{
	font-weight: bold;
}

.lead {
	font-weight: bold;
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
							<div class="nav nav-tabs " id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/announcement/list'">채용공고</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/briefing/list'">채용설명회</button>
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







				<form action="/announcement/delete.do" method="post" id="delForm">
					<input type="hidden" name="empmnPbancNo"
						value="${employment.empmnPbancNo }" />
				</form>

				<div class="container mt-2 mb-3 text-black">
					<br>
					<h1 class="display-6 text-truncate" id="eTitle" title="${employment.empmnPbancTtl }">${employment.empmnPbancTtl}</h1>
					<br>

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
								<button type="submit" class="btn me-md-2" id="updateBtn">
									<i class="fas btn btn-warning">수정하기</i>
								</button>
								<button type="button" class="btn me-md-2" id="deleteBtn">
									<i class="fas btn btn-danger">삭제하기</i>
								</button>
								<button type="button" class="btn me-md-2" id="anoBackBtn">
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
