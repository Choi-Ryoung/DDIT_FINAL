<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

<style>
table {
	width : 100%;
	text-align : center;
}

th:nth-child(1) {
	width: 4%;
}

th:nth-child(2) {
	width: 10%;
}

th:nth-child(4) {
	width: 15%;
}
th:nth-child(5) {
	width: 8%;
}
th:nth-child(6) {
	width: 8%;
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
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/apply/list'">지원자 조회</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/apply/list'">총 지원자</button>
							</div>
						</nav>
					</div>
				</div>
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
				
				<hr>
				
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<form class="input-group input-group-sm" method="post" id="searchForm" style="width: 440px;">
						<input type="hidden" name="page" id="page" /> 
						<select class="form-control" name="searchType">
							<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
							<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성기업</option>
						</select> 
						<input type="text" name="searchWord" value="${searchWord }" class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="submit" class="btn btn-default">
									<i class="fas btn btn-success">검색</i>
							</button>
						</div>
					</form>
				</div>
				
				<hr>
				<c:set value="${pagingVO.dataList }" var="applyList" />
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">이름</th>
							<th scope="col">공고이름</th>
							<th scope="col">지원날짜</th>
							<th scope="col">이력서확인</th>
							<th scope="col">합격여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty applyList}">
								<h1>지원자 없음!</h1>
							</c:when>
							<c:otherwise>
								<c:forEach items="${applyList }" var="apply">
									<tr>
										<th scope="row">${apply.rowNum }</th>
										<td>${apply.prMbrNm }</td>
										<td>${apply.empmnPbancTtl }</td>
										<td>${apply.applyYmd }</td>
										<td>${apply.docChkYn }</td>
										<c:choose>
											<c:when test="${apply.docPassYn == null }"><td class="text text-black">대기중</td></c:when>
											<c:when test="${apply.docPassYn == 'Y' }"><td class="text text-primary">합격</td></c:when>
											<c:when test="${apply.docPassYn == 'N' }"><td class="text text-danger">불합격</td></c:when>
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


<script type="text/javascript">
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
});
</script>
