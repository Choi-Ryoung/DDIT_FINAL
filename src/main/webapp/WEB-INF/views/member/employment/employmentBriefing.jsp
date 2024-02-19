<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
/* 기존 CSS에 다음 스타일을 추가하세요 */
.table th,td {
	white-space: nowrap; /* 헤더가 두 줄로 내려가지 않도록 함 */
	text-align: center;
}

.table th:nth-child(2) {
  width: 35%; /* 두 번째 열의 너비 조절 */
}

</style>


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
								<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab"	aria-controls="nav-home" aria-selected="false" onClick="location.href='${cxtp}/employment/list'">채용공고</button>
								<button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"	type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onClick="location.href='${cxtp}/employment/briefingList'">채용설명회</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onClick="location.href='${cxtp}/member/jobAssist'">취업도우미</button>
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
				
				<hr>
				<nav class="navbar navbar-light">
				  <div class="container-fluid">
				    <a class="navbar-brand">채용설명회 검색</a>
				    <form class="d-flex">
				      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				      <button class="btn btn-outline-primary" type="submit">Search</button>
				    </form>
				  </div>
				</nav>			
				<hr>
				
				<table class="table">
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">시간</th>
							<th scope="col">장소</th>
							<th scope="col">바로가기</th>
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
											<td>${briefing.empmnBrfType }</td>
											<td>${briefing.empmnBrfTtl }</td>
											<td>${fn:substring(briefing.empmnBrfBgngYmd, 0, 4)}년 ${fn:substring(briefing.empmnBrfBgngYmd, 5, 7)}월 ${fn:substring(briefing.empmnBrfBgngYmd, 8, 10)}일<br></td>
											<td>${briefing.empmnBrfHr }</td>
											<td>${briefing.empmnBrfPlcNm }</td>
											<td><a href="${briefing.empmnBrfUrl }" target="_blank"><button class="btn btn-success btn-sm">바로가기</button></a></td>
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
