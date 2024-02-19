<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: green; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

table {
	text-align : center;
	width : 100%;
}

.table th:nth-child(1) {
	width: 5%;
}
.table th:nth-child(2) {
	/* width: 10%; */
}

.table th:nth-child(4) {
	width: 15%;
}
.table th:nth-child(5) {
	width: 10%;
}

/* 모달 크기 */
.modal-dialog{
    margin: 6rem auto !important;
	min-width: 1000px !important;
}
.modal-content{
	/* min-height: 700px !important; */
}

#entLogo{
	float: left;
}

.modal-body-header{
	width: auto;
	height: 210px;
}

.modal-body-header p{
	font-size: 2.0em;
	margin-left: 235px;
}

#detailTable *{
	width: 200px;
	height : 40px;
	font-size: 1.0rem;
}

.modal-body p, .modal-body label{
	font-size: 1.2rem;
}

.modal-body label, #proceedCodingTest, #proceedIntTest{
	margin-left: 40%;
}

#agreeYn, #agreeIntYn{
	margin-right: 10px;
}
</style>

<!-- 모달 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<input type="hidden" id="empmnPbancNo" value="">
				<input type="hidden" id="entMbrId" value="">
				<h5 class="modal-title text-black fs-5" id="staticBackdropLabel">나의 지원내역</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="img-modal">
					<img alt="기업로고.jpg" src="" width="200px" height="200px" id="entLogo">
				</div>
				<div class="modal-body-header">
					<p style="margin-top: 20px;">공고 제목 : <span id="ancTitle"></span></p>
					<p>기업명 : <span id="entNm"></span></p>
					<p>본사 : <span id="mainCom"></span></p>
					<p>지원일자 : <span id="cnt"></span></p>
				</div>
				<hr/>
				<div class="modal-body-content">
					<table border="1" id="detailTable">
						<tr>
							<th>전형</th>
							<th>서류 전형</th>
							<th>코딩테스트</th>
							<th>면접</th>
						</tr>
						<tr>
							<td>합격 여부</td>
							<td><span id="docPassYn"></span></td>
							<td><span id="codingPassYn"></span></td>
							<td><span id="interviewPassYn"></span></td>
						</tr>
						<tr>
							<td>합격자 발표일</td>
							<td><span id="docPassYmd"></span></td>
							<td><span id="codingPassYmd"></span></td>
							<td><span id="interviewPassYmd"></span></td>							
						</tr>
						<tr>
							<td>응시하기</td>
							<td><input type="button" class="btn btn-success" id="resumeSubmitBtn" value="제출한 이력서"/></td>
							<td><input type="button" class="btn btn-success" id="codingTestBtn" value="응시하기"/></td>
							<td><input type="button" class="btn btn-success" id="interviewBtn" value="응시하기"/></td>
						</tr>
					</table>
				</div>
			</div>
			<div id="resumeFile">
				
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-success" id="ancDetail" value="공고보기"/>
				<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
			</div>       
		</div>
	</div>
</div>
<!-- 모달 -->

<c:set value="${applyList }" var="myApply" />

<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/나의지원내역.jpg" width="1100px" height="300px">
								</div>
						</div>
						<br>
					</div>
						<nav>
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/myInfo'">회원 정보</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mentoUpdate'">멘토링 정보</button>
								<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onclick="location.href='${ctxp}/member/mypage/applyList'">지원 내역</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업 제안</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/chart'">나의 통계</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서 관리</button>
							</div>
						</nav>
					</div>
				</div>
				
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">기업이름</th>
							<th scope="col">공고이름</th>
							<th scope="col">지원날짜</th>
							<th scope="col">최종 합격여부</th>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:choose>
							<c:when test="${empty myApply }">
								<td colspan="5"> 지원한 공고 없음!</td>
							</c:when>
							<c:otherwise>
								<c:forEach items="${myApply }" var="apply">
									<tr data-id="${apply.empmnPbancNo }">
										<th scope="row">${apply.rowNum }</th>
										<td>${apply.empmnPbancWrtrNm }</td>
										<td>${apply.empmnPbancTtl }</td>
										<td>
											${fn:substring(apply.applyYmd, 0, 4)}년 
											${fn:substring(apply.applyYmd, 5, 7)}월 
											${fn:substring(apply.applyYmd, 8, 10)}일
										</td>
										<c:choose>
											<c:when test="${apply.interviewPassYn == null }"><td class="text text-black">대기중</td></c:when>
											<c:when test="${apply.interviewPassYn == 'Y' }"><td class="text text-primary">합격</td></c:when>
											<c:when test="${apply.interviewPassYn == 'N' }"><td class="text text-danger">불합격</td></c:when>
									 	</c:choose>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<video id="video" autoplay></video>
<fieldset id="options" style="display:none">
	<legend>Advanced options</legend>
	<select id="displaySurface">
		<option value="default" selected>Show default sharing options</option>
		<option value="browser">Prefer to share a browser tab</option>
		<option value="window">Prefer to share a window</option>
		<option value="monitor">Prefer to share an entire screen</option>
	</select>
</fieldset>
<div id="errorMsg"></div>

<style>
#options{
	visibility: hidden;
}
</style>

<script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<script type="text/javascript">

$(function(){
	/* 이력서 보기 */
	var resumeSubmitBtn = $('#resumeSubmitBtn');
	var resumeFile = $('#resumeFile');
	/* 공지로 가기 */
	var ancDetail = $('#ancDetail');
	/* 화상 버튼 */
	var interviewBtn = $('#interviewBtn');
	/* 코딩테스트 */
	var codingTestBtn = $('#codingTestBtn');
	/* 날짜  */
	var today = new Date();
	
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '-' + month  + '-' + day;
	/* 컬럼 클릭 이벤트 */
	var tbody = $('#tbody');
	
	tbody.on("click", "tr", function() {
		$('#resumeFile *').remove();
		$('#resumeSubmitBtn').val("제출한 이력서");
		
		var empmnPbancNo = $(this).data("id");
		console.log(empmnPbancNo);
		
		var data = {
				empmnPbancNo : empmnPbancNo
			}
		
		$.ajax({
			type : "post",
			url : "/member/mypage/myApplyDetail.do",
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				console.log("res : ", res);
				
				$('#ancTitle').text(res[0].empmnPbancTtl);
				$('#mainCom').text(res[0].powkNm);
				$('#entNm').text(res[0].empmnPbancWrtrNm);
				$('#entLogo').attr("src", res[0].logoImg);
				
				var test = res[0].applyYmd;
				 
				var year = test.substring(0,4);
				var month = test.substring(5,7);
				var day = test.substring(8,10);
				
				$('#cnt').text(year + "년 " + month + "월 " + day + "일");
				
				if(res[0].docPassYn == "N"){
					$('#docPassYn').text("불합격");
					$('#codingPassYn').text("불합격");
					$('#interviewPassYn').text("불합격");
				}else if(res[0].codingPassYn == "N"){
					$('#codingPassYn').text("불합격");
					$('#interviewPassYn').text("불합격");
				}else if(res[0].interviewPassYn == "N"){
					$('#interviewPassYn').text("불합격");
				}
				
				if(res[0].docPassYn == "Y"){
					$('#docPassYn').text("합격");
				}
				if(res[0].codingPassYn == "Y"){
					$('#codingPassYn').text("합격");
				}
				if(res[0].interviewPassYn == "Y"){
					$('#interviewPassYn').text("합격");
				}
				
				if(res[0].docPassYn == null && dateString <= res[0].docPassYmd){
					$('#docPassYn').text("해당 전형 결과 발표 전입니다.");
					$('#codingPassYn').text("해당 전형 결과 응시 전입니다.");
					$('#interviewPassYn').text("해당 전형 결과 응시 전입니다.");
				}else if(res[0].codingPassYn == null && dateString <= res[0].codingPassYmd){
					$('#codingPassYn').text("해당 전형 결과 응시 전입니다.");
					$('#interviewPassYn').text("해당 전형 결과 응시 전입니다.");
				}else if(res[0].interviewPassYn == null && dateString <= res[0].interviewPassYmd){
					$('#interviewPassYn').text("해당 전형 결과 응시 전입니다.");
				}
				
				console.log(dateString + "" + res[0].codingPassYmd, dateString >= res[0].codingPassYmd);
				console.log(dateString + "" +  res[0].interviewPassYmd, dateString < res[0].interviewPassYmd);
				
				// 코딩테스트 버튼 활성화
				if(res[0].docPassYn == "Y" && dateString >= res[0].codingPassYmd && dateString < res[0].interviewPassYmd){
					$('#codingTestBtn').removeAttr("disabled");
					$('#interviewBtn').prop('disabled', true);
				}
				
				// 면접 버튼 활성화
				if(res[0].docPassYn == "Y" && res[0].codingPassYn == "Y" && dateString >= res[0].interviewPassYmd){
					$('#codingTestBtn').removeAttr("disabled");
					$('#interviewBtn').prop('disabled', true);
				}
				
				if(res[0].docPassYn == "Y"){
					$('#docPassYn').text("합격");
				}
				if(res[0].codingPassYn == "Y"){
					$('#codingPassYn').text("합격");
				}
				if(res[0].interviewPassYn == "Y"){
					$('#interviewPassYn').text("합격");
				}
				
				$("#resumeFile").attr("src", "");
				$('#empmnPbancNo').val(empmnPbancNo);
				$('#entMbrId').val(res[0].entMbrId);
				
				var docPassYmd = res[0].docPassYmd;
				var codingPassYmd = res[0].codingPassYmd;
				var interviewPassYmd = res[0].interviewPassYmd;
				
				var docPassYear = docPassYmd.substring(0,4); 
				var docPassMonth = docPassYmd.substring(5,7);
				var docPassDay = docPassYmd.substring(8,10);
				
				var codingPassYear = codingPassYmd.substring(0,4); 
				var codingPassMonth = codingPassYmd.substring(5,7);
				var codingPassDay = codingPassYmd.substring(8,10);
				
				var interviewPassYear = interviewPassYmd.substring(0,4); 
				var interviewPassMonth = interviewPassYmd.substring(5,7);
				var interviewPassDay = interviewPassYmd.substring(8,10);
				
				$('#docPassYmd').text(docPassYear + "년 " + docPassMonth + "월 " + docPassDay + "일");
				$('#codingPassYmd').text(codingPassYear + "년 " + codingPassMonth + "월 " + codingPassDay + "일");
				$('#interviewPassYmd').text(interviewPassYear + "년 " + interviewPassMonth + "월 " + interviewPassDay + "일");
				
				$("#staticBackdrop").modal("show");
			}
		});	// ajax 끝
		
	});	// tbody onclick 끝
	
	resumeSubmitBtn.on('click', function(){
		if(resumeSubmitBtn.val() != "닫기"){
			var empmnPbancNo = $('#empmnPbancNo').val();
			empmnPbancNo = parseInt(empmnPbancNo);
			
			var data = {
				empmnPbancNo : empmnPbancNo
			}
			
			$.ajax({
				type : "post",
				url : "/member/mypage/myApplyDetail.do",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success : function(res){
					console.log("div ; ", $('#resumeFile').length);
					console.log("div ; ", $('#resumeFile'));
					resumeFile.append(`<iframe src="${'${res[0].resumeFile}'}" style="width:100%; height:900px;"></iframe>`);
					resumeSubmitBtn.val("닫기");
				}
			});	// ajax 끝
		}else{
			$('#resumeFile *').remove();
			resumeSubmitBtn.val("제출한 이력서");
		}
	});	// 이력서 보기 끝
	
	// 공고보러가기
	ancDetail.on('click', function(){
		var empmnPbancNo = $('#empmnPbancNo').val();
		location.href = "/employment/detail?empmnPbancNo=" + empmnPbancNo;
	});	// 끝
	
	interviewBtn.on('click', function(){
		$('.modal-body *').empty();
		var interviewStr = "";
		
		interviewStr += `<p>본 화상면접은 카메라와 마이크가 준비되어있어야합니다.</p>`;
		interviewStr += `<p>화상면접 주의사항은 아래와 같습니다.</p><br/>`;
		interviewStr += `<p>1. 접속 후 3분 동안 지원자의 카메라 화면 또는 마이크가 켜지지 않는 경우 실격 처리 됩니다.</p>`;
		interviewStr += `<p>2. 본 면접은 화상으로 이루어지며 응시자는 초상권 이용에 동의합니다.</p>`;
		interviewStr += `<p>3. 해당 정보는 기업 지원 용도 이외에 사용되지 않음을 알려드립니다.</p>`;
		interviewStr += `<p>4. 하단 약관 동의 시 면접 페이지로 이동 할 수 있습니다.</p><br/>`;
		interviewStr += `<label id="intAgreeYnLabel"><input type="checkbox" class="form-check-input" id="agreeIntYn" value="Y">위 약관에 동의합니다.</label><br/><br/>`;
		interviewStr += `<input type="button" class="btn btn-primary" id="proceedIntTest" value="면접 응시하기"/>`;
		
		$('.modal-body').html(interviewStr);
		
		var intAgreeYnLabel = $('#intAgreeYnLabel');
		var proceedIntTest = $('#proceedIntTest');
		
		if($('input:checkbox[id="agreeIntYn"]').is(":checked") == false){
			proceedIntTest.prop('disabled', true);
		}
		
		intAgreeYnLabel.on('click', function(){
			if($('input:checkbox[id="agreeIntYn"]').is(":checked") == false){
				proceedIntTest.prop('disabled', true);
			}else{
				proceedIntTest.removeAttr('disabled');
			}
		});	// 뭐 아무튼
		
		proceedIntTest.on('click', function(){
			var empmnPbancNo = $('#empmnPbancNo').val();
			console.log("empmnPbancNo : " , empmnPbancNo);
			window.open('about:blank').location.href = "/member/mypage/memVideoChat?empmnPbancNo=" + empmnPbancNo;
		});
		
		
	});	// 인터뷰 버튼
	
	codingTestBtn.on('click', function(){
		$('.modal-body *').empty();
		var codingTestStr = "";
		
		codingTestStr += `<p>본 코딩테스트는 해당 회사에서 출제하는 문제입니다.</p>`;
		codingTestStr += `<p>코딩테스트는 화면 공유를 이용해 부정 행위를 방지하며 부정 행위는 하단 내용과 같습니다.</p><br/>`;
		codingTestStr += `<p>1. 본 코딩테스트는 인터넷 검색을 금지하고 있습니다. 해당 행위 적발시 탈락 처리됩니다.</p>`;
		codingTestStr += `<p>2. 본 코딩테스트는 화면공유를 실행하고 있습니다. 화면공유 시작시 타이머가 작동됩니다.</p>`;
		codingTestStr += `<p>3. 본 코딩테스트는 총 5문제이고 제한 시간은 1시간입니다. 제한 시간 내에 제출하지 못하면 자동 실격처리됩니다.</p>`;
		codingTestStr += `<p>4. 하단 약관 동의 시 코딩테스트 페이지로 이동 할 수 있습니다.</p><br/>`;
		codingTestStr += `<label id="agreeYnLabel"><input type="checkbox" class="form-check-input" id="agreeYn" value="Y">위 약관에 동의합니다.</label><br/><br/>`;
		codingTestStr += `<input type="button" class="btn btn-primary" id="proceedCodingTest" value="코딩테스트 응시하기"/>`;
		
		$('.modal-body').html(codingTestStr);
		
		var agreeYnLabel = $('#agreeYnLabel');
		var proceedCodingTest = $('#proceedCodingTest');
		
		if($('input:checkbox[id="agreeYn"]').is(":checked") == false){
			proceedCodingTest.prop('disabled', true);
		}
		
		agreeYnLabel.on('click', function(){
			if($('input:checkbox[id="agreeYn"]').is(":checked") == false){
				proceedCodingTest.prop('disabled', true);
			}else{
				proceedCodingTest.removeAttr('disabled');
			}
		});
		
		const preferredDisplaySurface = document.getElementById('displaySurface');
		const startButton = document.getElementById('proceedCodingTest');
		const video = document.getElementById('video');
		
		proceedCodingTest.on('click', function(){
			var entMbrId = $('#entMbrId').val();
			var empmnPbancNo = $('#empmnPbancNo').val();
			empmnPbancNo = parseInt(empmnPbancNo);
			
				var peer = new Peer('client2', {
 					host: '192.168.36.103',
					port: 8001,
					path: '/'
			    });
				
				peer.on('connection', conn => {
				    console.log('다른 클라이언트가 접속했습니다.');
				});
				
				if (adapter.browserDetails.browser === 'chrome' && adapter.browserDetails.version >= 107) {
					// See https://developer.chrome.com/docs/web-platform/screen-sharing-controls/
					document.getElementById('options').style.display = 'block';
				} else if (adapter.browserDetails.browser === 'firefox') {
					// Polyfill in Firefox.
					// See https://blog.mozilla.org/webrtc/getdisplaymedia-now-available-in-adapter-js/
					adapter.browserShim.shimGetDisplayMedia(window, 'screen');
				}
				
				function handleError(error) {
					errorMsg(`getDisplayMedia error: ${error.name}`, error);
				}
				
				function errorMsg(msg, error) {
					const errorElement = document.querySelector('#errorMsg');
					errorElement.innerHTML += `<p>${msg}</p>`;
					if (typeof error !== 'undefined') {
						console.error(error);
					}
				}
				
				function handleSuccess(stream) {
					startButton.disabled = true;
					preferredDisplaySurface.disabled = true;
					
					let call = peer.call('client3', stream);
					console.log("call ", call);
					
					window.open('about:blank').location.href = "/apply/realCodingTest?entMbrId=" + entMbrId + "&empmnPbancNo=" + empmnPbancNo;
					
					// demonstrates how to detect that the user has stopped
					// sharing the screen via the browser UI.
					stream.getVideoTracks()[0].addEventListener('ended', () => {
						alert("화면공유가 종료되었습니다.");
						errorMsg('The user has ended sharing the screen');
						startButton.disabled = false;
						preferredDisplaySurface.disabled = false;
					});
				}
				
				startButton.addEventListener('click', () => {
					/* const options = {audio: true, video: true}; */
					const displaySurface = preferredDisplaySurface.options[preferredDisplaySurface.selectedIndex].value;
					/* 
					if (displaySurface !== 'default') {
						options.video = {displaySurface};
					}
					 */
					navigator.mediaDevices.getDisplayMedia({
					    video: {
					        width: { ideal: 500 },
					        height: { ideal: 500 },
					    },
					    audio: true,
					}).then(handleSuccess, handleError);
			
					
					/* navigator.mediaDevices.getDisplayMedia(options).then(handleSuccess, handleError); */
				});
				
				if ((navigator.mediaDevices && 'getDisplayMedia' in navigator.mediaDevices)) {
					startButton.disabled = false;
				} else {
					errorMsg('getDisplayMedia is not supported');
				}
				
				// ga.js
				(function(i, s, o, g, r, a, m) {
					i['GoogleAnalyticsObject']=r; i[r]=i[r]||function() {
						(i[r].q=i[r].q||[]).push(arguments);
					}, i[r].l=1*new Date(); a=s.createElement(o),
					m=s.getElementsByTagName(o)[0]; a.async=1; a.src=g; m.parentNode.insertBefore(a, m);
				})(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
				
				ga('create', 'UA-48530561-1', 'auto');
				ga('send', 'pageview');
			
		});
		
	});
	
});
</script>