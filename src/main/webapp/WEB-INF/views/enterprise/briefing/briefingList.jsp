<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<style>
.table th {
    text-align: center;
}

/* 기존 CSS에 다음 스타일을 추가하세요 */
.table th,td {
  white-space: nowrap; /* 헤더가 두 줄로 내려가지 않도록 함 */
}

.table th:nth-child(2) {
  width: 30%; /* 두 번째 열의 너비 조절 */
}
.table th:nth-child(7) {
  width: 14%; /* 두 번째 열의 너비 조절 */
}

/* 다른 열에 대한 유사한 규칙을 필요에 따라 추가하세요 */
/* 바로가기 버튼이 있는 열과 시간이 있는 열에 대해서 추가 스타일 적용 */
.table td:nth-child(1),
.table td:nth-child(3),
.table td:nth-child(4), /* 바로가기 버튼이 있는 열의 열 번호에 따라 조절 */
.table td:nth-child(6), /* 시간이 있는 열의 열 번호에 따라 조절 */
.table td:nth-child(7) {
  text-align: center;
}

</style>



<!-- Modal -->
<form action="${ctxp}/briefing/insert.do" method="post" id="briefingForm">
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">채용설명회 등록창</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
	      <div class="modal-body">
			<input type="hidden" name="empmnBrfNo" value=""/>
			<input type="text" id ="empmnBrfTtl" name = "empmnBrfTtl" class="form-control" placeholder="채용설명회  제목"> <br>
			<input type="date" id ="empmnBrfBgngYmd" name = "empmnBrfBgngYmd" class="form-control" placeholder="채용설명회  날짜"> <br>
			<select id ="empmnBrfType" name = "empmnBrfType" class="form-control">
				<option value="설명회">설명회</option>
				<option value="박람회">박람회</option>
				<option value="상담회">상담회</option>
			</select><br>
			<input type="text" id ="empmnBrfHr" name = "empmnBrfHr" class="form-control" placeholder="채용설명회  시간"> <br>
			<input type="text" id ="empmnBrfPlcNm" name = "empmnBrfPlcNm" class="form-control" placeholder="채용설명회  장소"> <br>
			<input type="text" id ="empmnBrfUrl" name = "empmnBrfUrl" class="form-control" placeholder="채용설명회  홈페이지">
	       
	      </div>
		<div class="modal-footer">
			<input type="submit" class="btn btn-success" value="등록하기" id="intBrieBtn"/>
			<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
			<input type="button" class="btn btn-primary" value="자동완성" id="autoset2"/>
		</div>       
    </div>
  </div>
</div>
</form>


<!-- Modal -->
<form action="${ctxp}/briefing/update.do" method="post" id="updBriefingForm">
<div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">채용설명회  수정창</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
	      <div class="modal-body">
			<input type="hidden" name="empmnBrfNo" value=""/>
			<input type="text" name = "empmnBrfTtl" class="form-control" value=""> <br>
			<input type="date" name = "empmnBrfBgngYmd" class="form-control" value=""> <br>
			<select id ="empmnBrfType" id="brfType" name = "empmnBrfType" class="form-control">
				<option value="설명회">설명회</option>
				<option value="박람회">박람회</option>
				<option value="상담회">상담회</option>
			</select><br>
			<input type="text" name = "empmnBrfHr" class="form-control" value=""> <br>
			<input type="text" name = "empmnBrfPlcNm" class="form-control" value=""> <br>
			<input type="text" name = "empmnBrfUrl" class="form-control" value="">
	      </div>
		<div class="modal-footer">
			<input type="submit" class="btn btn-success" value="수정하기" id="updateBriefingBtn"/>
			<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
		</div>       
    </div>
  </div>
</div>
</form>



<c:set value="${pagingVO.dataList }" var="briefingList"/>

<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs " id="nav-tab" role="tablist">
								<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="false" onClick="location.href='${cxtp}/announcement/list'">채용공고</button>
								<button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true"  onClick="location.href='${cxtp}/briefing/list'">채용설명회</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4 mb-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/채용설명회.jpg" width="1198px" height="300px">
							</div>
						</div>
					</div>
				</div>
		
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="button" class="btn me-md-2" id="newBtn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
						<i class="fas btn btn-success">채용설명회 등록</i>
					</button>
				</div>
				
				<br>

				<table class="table table-hover">
					<thead>
						<tr>
							<!-- <th scope="col">기업명</th> -->
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">시간</th>
							<th scope="col">장소</th>
							<th scope="col">바로가기</th>
							<th scope="col">수정 / 삭제</th>
						</tr>
					</thead>
		
					<tbody>
						<c:choose>
							<c:when test="${empty briefingList }">
								<tr>
									<td colspan="6">글없음</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${briefingList }" var="briefing">
									<tr>
										<%-- <th scope="row">${briefing.entNm }</th> --%>
										<td>${briefing.empmnBrfType }</td>
										<td data-toggle="tooltip" data-placement="top" data-original-title="${briefing.empmnBrfTtl }">${briefing.empmnBrfTtl }</td>
										<td>${fn:substring(briefing.empmnBrfBgngYmd, 0, 4)}년 ${fn:substring(briefing.empmnBrfBgngYmd, 5, 7)}월 ${fn:substring(briefing.empmnBrfBgngYmd, 8, 10)}일</td>
										<td>${briefing.empmnBrfHr }</td>
										<td>${briefing.empmnBrfPlcNm }</td>
										<td><a href="${briefing.empmnBrfUrl }" target="_blank"><button class="btn btn-primary btn-sm" >바로가기</button></a></td>
										<td>
											<button type="button" class="btn btm-sm" id="updBrieBtn" data-jmkNo="${briefing.empmnBrfNo }" data-bs-toggle="modal" data-bs-target="#staticBackdrop2" updBtn>
												<i class="fas btn btn-warning btn-sm">수정</i>
											</button>
											<button type="button" class="btn btm-sm" id="delBrieBtn" data-jmgNo="${briefing.empmnBrfNo }" delBtn>
												<i class="fas btn btn-danger btn-sm">삭제</i>
											</button>
										</td>
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
<form action="/briefing/delete.do" method="post" id="briefingDelForm">
	<input type="hidden" name="empmnBrfNo" value=""/>
</form>


<script>
//동적  DOM이 아니라면 , 전역변수로 선언하는 것이 여러곳에서 반복적으로 사용할 때 유리 
const intBrieBtn = $("#intBrieBtn");	// 등록 버튼 
const delBrieBtn = $("[delBtn]");	// 삭제 버튼
const updBrieBtn = $("[updBtn]");	// 수정 버튼

//const delBrieBtn = $("#delBrieBtn");	// 삭제 버튼 Element , jQuery는 요따구로 # 붙이면 1개만 가져옴
//const delBrieBtn = document.querySelectorAll("#delBrieBtn");	// 삭제 버튼 Element
const briefingDelForm = $("#briefingDelForm");		// 수정 및 삭제를 처리할 Form Element
const briefingForm = $("#briefingForm");		// 등록 Form Element
const updBriefingForm = $("#updBriefingForm");		// 수정 Form Element
const empmnBrfNo = $("[name=empmnBrfNo]");


// 삭제 버튼 클릭 시, confirm 메세지 출력 후 삭제 
delBrieBtn.on("click", function(){

	if(confirm("정말로 삭제하시겠습니까?")){
        empmnBrfNo.val(this.dataset.jmgno);
		briefingDelForm[0].submit();
	}
});


// 등록 버튼 클릭 시, 진행
intBrieBtn.on("click", function(){
	briefingForm.submit();
});



// 수정 버튼 클릭 시, 진행
updBrieBtn.on("click", function(){
	const no = $(this).data('jmkno');
	
	$.ajax({
        type: "POST",
        url: "/briefing/update",
        data: { empmnBrfNo: no },
        success: function (result) {
        	if(result != null) {
        		$('#staticBackdrop2 input[name=empmnBrfNo]').val(no);
				$('#staticBackdrop2 input[name=empmnBrfBgngYmd]').val(result.empmnBrfBgngYmd);
				$('#staticBackdrop2 select[name=empmnBrfType]').val(result.empmnBrfType).prop("selected", true);
				$('#staticBackdrop2 input[name=empmnBrfHr]').val(result.empmnBrfHr);
        		$('#staticBackdrop2 input[name=empmnBrfTtl]').val(result.empmnBrfTtl);
        		$('#staticBackdrop2 input[name=empmnBrfPlcNm]').val(result.empmnBrfPlcNm);
        		$('#staticBackdrop2 input[name=empmnBrfUrl]').val(result.empmnBrfUrl);
        	}
        },
        error: function () {
            alert("서버 오류 발생. 다시 시도해주세요.");
        }
    });
});




$(function(){
	$('[data-toggle="tooltip"]').tooltip();
	
	

	$('#autoset2').on('click', function(){
		$('input[name = "empmnBrfTtl"]').val('2023년 겨울방학 자기주도 진로디자인');
		$('input[name = "empmnBrfBgngYmd"]').val('2024-01-12');
		$('input[name = "empmnBrfType"]').val('상담회');
		$('input[name = "empmnBrfHr"]').val('10:00 ~ 17:00');
		$('input[name = "empmnBrfPlcNm"]').val('이화여자대학교 ECC B144호');
		$('input[name = "empmnBrfUrl"]').val('https://cmsfox.ewha.ac.kr/job/intro/Information-notice.do?mode=view&articleNo=702751');
	});



});

</script>


