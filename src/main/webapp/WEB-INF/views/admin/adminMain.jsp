<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<%
    // 세션에서 사용자 정보 가져오기 (세션에 사용자 정보가 없으면 로그인 페이지로 리다이렉트)
    Object userInfo = session.getAttribute("SessionInfo");
    if (userInfo == null) {
        response.sendRedirect(request.getContextPath() + "/adminlogin"); // 로그인 페이지로 리다이렉트
    }
%>
<script>
<!-- 
	// 1) 자바스크립트 로직으로 1월부터 12월달을 선택했을때 해당 달의 일을 가져온다.
	// 예) 1월달이 30일까지면 30일이라는 데이터를 가져오고, 2월달이 29일까지면 29일이라는 데이터를 가져온다.
	// **** 이 부분은 getGraph 메소드 안에서 처리할게 아니라 다른 셀렉트 박스가 변경됬을때와 같은 이벤트
	// 안에서 처리되어야 하는거 알죠? 
	     
	// 2) 선택한 달에 해당하는 일수에 맞춰 해당 일수가 저장될 공간을 하나 마련하고
	// 마련된 공간에 내가 선택한 해당 달에 일수와 서버를 통해서 전달받은 데이터 목록을 비교한다.
	// 1월 1일 = 넘겨받은 데이터 첫번재~ 넘겨받은 데이터 11번째 중에 일치하는 데이터가 있는지 체크
	//         데이터가 있다면 서버로부터 넘겨받은 데이터를 집어넣는다.
	// 		      없으면 0이 들어간다
	
	// 3) 비교를 통해서 셋팅된 데이터를 아래 차트 속성 자리에 변수로 셋팅한다.
-->
$(function(){
	
	getGraph("all");
	
	// 가입일자
	var bothJoinYmdArr = new Array();
	var memJoinYmdArr = new Array();
	var entJoinYmdArr = new Array();
	
	// 가입수
	var bothJoinCntArr = new Array();
	var memJoinCntArr = new Array();
	var entJoinCntArr = new Array();
 	
	// 라디오 버튼 값
	var radioVal = $('input[name=flexRadioDefault]:checked').val();
	var ctx;
	var myChart;
	// Graphs
	// const ctx = document.getElementById('myChart');
	function getGraph(type){
// 		<div id="chartCanvas">
// 		<canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
// 	</div>
		$('#chartCanvas').html("<canvas class='my-4 w-100' id='myChart' width='900' height='380'></canvas>");
		
		var data = [];
		$.ajax({
			url:"/admin/getCountMembersList",
			type:"get",
			success:function(res){
				// 일반
				for(var i=0; i < res[0].length; i++){
					memJoinYmdArr.push(res[0][i].prMbrJoinYmd);
					bothJoinYmdArr.push(res[0][i].prMbrJoinYmd);
					memJoinCntArr.push(res[0][i].count);
					bothJoinCntArr.push(res[0][i].count);
				}
				
				// 기업
				for(var j=0; j < res[1].length; j++){
					entJoinYmdArr.push(res[1][j].entJoinYmd);
					bothJoinYmdArr.push(res[1][j].entJoinYmd);
					entJoinCntArr.push(res[1][j].count);
					bothJoinCntArr.push(res[1][j].count);
				}
				
				// 두 배열을 합치기
				var combinedJoinYmdArr = entJoinYmdArr.concat(memJoinYmdArr);

				// 만약 중복을 제거하려면 Set을 사용할 수 있습니다.
				var uniqueCombinedJoinYmdArr = Array.from(new Set(combinedJoinYmdArr));

				// 결과 확인
				console.log(uniqueCombinedJoinYmdArr);

				
				/* 
				console.log(uniqueArr);
				
				console.log(entJoinYmdArr);
				console.log(memJoinYmdArr);
				console.log(entJoinCntArr);
				console.log(memJoinCntArr);
				console.log(bothJoinCntArr);
				*/
				
				if(type == "all"){
					data.push({
						label: '일반 회원',
						data: memJoinCntArr,
						lineTension: 0,
						backgroundColor: '#ff6384',
						borderColor: '#ff6384',
						borderWidth: 1,
						pointBackgroundColor: '#ff6384'
					});
					data.push({
						label: '기업 회원',
						data: entJoinCntArr,
						lineTension: 0,
						backgroundColor: '#36a2eb',
						borderColor: '#36a2eb',
						borderWidth: 1,
						pointBackgroundColor: '#36a2eb'
					});
				}else if(type == "mem"){
					data.push({
						label: '일반 회원',
						data: memJoinCntArr,
						lineTension: 0,
						backgroundColor: '#ff6384',
						borderColor: '#ff6384',
						borderWidth: 1,
						pointBackgroundColor: '#ff6384'
					});
				}else{
					data.push({
						label: '기업 회원',
						data: entJoinCntArr,
						lineTension: 0,
						backgroundColor: '#36a2eb',
						borderColor: '#36a2eb',
						borderWidth: 1,
						pointBackgroundColor: '#36a2eb'
					});
				}
				
				// 그래프
				ctx = $("#chartCanvas").find('#myChart');
				myChart = new Chart(ctx, {
					type: 'bar',
					data: {
						labels: uniqueCombinedJoinYmdArr,
						datasets: data
					},
					options: {
						plugins: {
							legend: {
								display: true
							},
							tooltip: {
								boxPadding: 3
							}
						}
					}
				})
				
				ctx = null;
				myChart = null;
			},
			error:function(){
				alert("실패");
			}  
			   
		}); // ajax	  
	}
	
	$(".graph").on("change", function(){
		var type = $(this).val();
		if(type == "prMember"){
			getGraph("mem");
		}else if(type == "entMember"){
			getGraph("ent");
		}else{
			getGraph("all");
		}
	});
	
});
</script>

<style>
	label{
		margin-right: 10px;
	}
</style>

		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="h2">최근 가입자 수</h1>
				<div class="btn-toolbar mb-2 mb-md-0">
					<label><input class="form-check-input graph" type="radio" name="flexRadioDefault" value="entire" checked>전체</label>
					<label><input class="form-check-input graph" type="radio" name="flexRadioDefault" value="prMember">일반회원</label>
					<label><input class="form-check-input graph" type="radio" name="flexRadioDefault" value="entMember">기업회원</label>
				</div>
			</div>

			<div id="chartCanvas">
				<canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
			</div>

			<div class="memberList">
				<h2>최근 가입한 일반회원</h2>
				<div class="table-responsive small">
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">닉네임</th>
								<th scope="col">가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
					            <c:when test="${empty prMbrTopTenList }">
						            <tr>
						               <td colspan="5">조회하실 일반회원이 존재하지 않습니다.</td>
						            </tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${prMbrTopTenList }" var="prMbrList" varStatus="prMbrStatus">
										<tr>
											<td>${prMbrStatus.count }</td>
											<td>${prMbrList.prMbrId }</td>
											<td>${prMbrList.prMbrNm }</td>
											<td>${prMbrList.prMbrNcnm }</td>
											<td>${prMbrList.prMbrJoinYmd }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			<div class="entList">
				<h2>최근 가입한 기업회원</h2>
				<div class="table-responsive small">
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">아이디</th>
								<th scope="col">기업명</th>
								<th scope="col">대표 번호</th>
								<th scope="col">가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
					            <c:when test="${empty prMbrTopTenList }">
						            <tr>
						               <td colspan="5">조회하실 일반회원이 존재하지 않습니다.</td>
						            </tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${entMbrTopTenList }" var="entMbrList" varStatus="entMbrStatus">
										<tr>
											<td>${entMbrStatus.count }</td>
											<td>${entMbrList.entMbrId }</td>
											<td>${entMbrList.entNm }</td>
											<td>${entMbrList.entRprsTelno }</td>
											<td>${entMbrList.entJoinYmd }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</main>
	</div>
</div>