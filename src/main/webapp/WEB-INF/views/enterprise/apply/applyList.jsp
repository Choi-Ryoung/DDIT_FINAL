<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<style>
.table {
	border : 1px;
}

.table th,td {
  white-space: nowrap; /* 헤더가 두 줄로 내려가지 않도록 함 */
  text-align: center;
}

th:nth-child(1) {
	width: 8%;
}

.sidebar {
	height: 80%;
	width: 0px;
	position: fixed;
	top: 0;
	left: 0;
	background-color: #2E8B57;
	overflow-x: hidden;
	transition: 0.3s;/*펼침속도*/
	padding-top: 60px;
	z-index: 99;
}
	
.sidebar a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 20px;
	color: #ffffff;
	display: block;
	transition: 0.3s;
}

.redText {
  color: red;
}


#resumeCn {
	text-align : center;
}

</style>


<c:set value="${pagingVO.dataList }" var="applyList"/>
<c:set value="${pagingVO2.dataList2 }" var="empList"/>


<!--사이드 메뉴 영역-->
<div class="sidebar">
	<a href="#">지우지마(한줄내리기용)</a>
	<a href="#">🔻 지원자목록 🔻</a>
	<div class="sidebarCn">
		<!-- 사이드바에 지원자 뜨는 공간 -->
	</div>
</div>



<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4 mb-4">
							<div class="p-2 p-md-5 text-white rounded bg-custom">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/지원자관리.png" width="1100px" height="300px">
								</div>
							</div>
						</div>
					</div>
				</div>
		
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">올린 채용공고</th>
						</tr>
					</thead>
		
					<tbody>
						<c:choose>
							<c:when test="${empty empList }">
								<tr>
									<td>글없음</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${empList }" var="emp">
									<tr>
										<th scope="col">${emp.rnum }</th>
										<td><a href="#" onclick="openMenu('${emp.empmnPbancNo}')" id="cygg">${emp.empmnPbancTtl }</a></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<br>
				<hr>
				<br>
				
				<div id="resume">
					<div id="resumeCn">
					<!-- 이력서 내용 뜨는 곳 -->
					
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>


<script>

function resumeOKCheck(prMbrId, empmnPbancNo){
	
	// console.log("t" + empmnPbancNo);
	
	// alert("check");
	$.ajax({
		type : "GET",
		url : "/apply/resumeOKCheck",
		data : { 'prMbrId' : prMbrId, 'empmnPbancNo' : empmnPbancNo },
		success : function(result){
			// console.log(abc);
			if(result == 'OK') {
				alert("합격통보를 하였습니다.");
	    		location.reload(true);
		    }
		},
		error : function(){
			alert("서버 오류 발생. 다시 시도해주세요.");
		},
	});
};


function resumeNOCheck(prMbrId, empmnPbancNo){
	
	// console.log("t" + empmnPbancNo);
	
	// alert("check");
	$.ajax({
		type : "GET",
		url : "/apply/resumeNOCheck",
		data : { 'prMbrId' : prMbrId, 'empmnPbancNo' : empmnPbancNo },
		success : function(result){
			// console.log(abc);
			if(result == 'OK') {
				alert("불합격통보를 하였습니다.");
	    		location.reload(true);
		    }
		},
		error : function(){
			alert("서버 오류 발생. 다시 시도해주세요.");
		},
	});
};




function openMenu(empmnPbancNo) {
	document.querySelector('.sidebar').style.width = "250px";

  	$.ajax({
	    type: "GET",
	    url: "/apply/select",
	    data: { empmnPbancNo : empmnPbancNo },
	    success: function (result) { 
		    //console.log("체킁:",result);	// 네크워크 프로그램은 항상 주고 받은 값을 눈으로 확인하면서..
			$('div .sidebarCn').empty();	// 일단 지워	
			for(let i=0; i<result.length; i++){
				console.log("읽음여부 체크 : ", result[i].docPassYn);
				
				var leftCheck = '';
				if(result[i].docChkYn == 'N') { 
					leftCheck = 'N'; 
				}
				
				$('div .sidebarCn').append("<a href='#' id='resumeList"+ result[i].prMbrId +"' onclick='openResume(\""+ result[i].prMbrId +"\","+ result[i].empmnPbancNo +",\""+ result[i].resumeFile +"\",\""+ result[i].docChkYn +"\")'><span class='redText' id='chkYn"+result[i].prMbrId+"'>" + leftCheck + "</span>&emsp;&emsp;<span id='appNm"+ result[i].prMbrNm +"'>" + result[i].prMbrNm + "</span>&emsp;&emsp;<input type='hidden' name='entMbrId' value='" + result[i].entMbrId + "'><input type='hidden' name='entMbrId' value='" + result[i].empmnPbancNo + "'></a><br>");
				console.log(result[i].prMbrId);
				console.log(result[i].empmnPbancNo);
		    }
	    },
		error: function () {
			alert("서버 오류 발생. 다시 시도해주세요.");
	    }
  	}); 	
};

function openResume(prMbrId, empmnPbancNo, resumeFile, docChkYn){
	console.log("이력서오픈 : ", prMbrId);
	console.log("이력서오픈 : ", empmnPbancNo);
	console.log("이력서오픈 : ", resumeFile);
	
	var prMbrId2 = `'${'${prMbrId}'}'`;
	
	$('#resumeCn').empty();	
	//$('#resumeCn').append(`<img src="${'${resumeFile}'}"><br><hr><br>`);
	$('#resumeCn').append(`<iframe src="${'${resumeFile}'}" style="width:1000px; height:900px;"></iframe><br><hr><br>`);
	$('#resumeCn').append(`<button onclick="resumeOKCheck(${'${prMbrId2}'}, ${'${empmnPbancNo}'})" name="resumeOKCheck" value="${'${prMbrId}'}, ${empmnPbancNo}" class="btn me-md-2 fas btn btn-success">서류 합격</button>&emsp;`);
	$('#resumeCn').append(`<button onclick="resumeNOCheck(${'${prMbrId2}'}, ${'${empmnPbancNo}'})" name="resumeNOCheck" value="${'${prMbrId}'}, ${empmnPbancNo}" class="btn me-md-2 fas btn btn-danger">서류 불합격</button>`);
	
	if(docChkYn == 'N') { 
		$.ajax({
		    type: "POST",
		    url: "/apply/resumeOpen",
		    data: { 'prMbrId' : prMbrId, 'empmnPbancNo' : empmnPbancNo},
		    success: function (res) {
		    	if(res > 0) {
		    		// 여기다가 N 없애는거 추가
		    		$("#chkYn" + prMbrId).empty();
		    	}
		    },
			error: function () {
				alert("서버 오류 발생. 다시 시도해주세요.");
		    }
	  	});
	}	
};
	
$(function(){
});
</script>
