<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
table tr{
	height: 30px;
}
.card-tools{
	display: flex;
	justify-content: space-between;
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
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${ctxp}/member/codingTestList'">연습문제 조회</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/member/myCodingTest'">내 풀이 조회</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/코딩테스트.jpg" width="1100px" height="300px">
							</div>
						</div>
					</div>
				</div>
				<hr>
	<nav class="navbar navbar-light">
	  <div class="container-fluid">
	    <a class="navbar-brand">연습문제 검색</a>
	    <form class="d-flex">
	      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-primary" type="submit">Search</button>
	    </form>
	  </div>
	</nav>		
					


		<hr>
		
		
		<table class="info" width="100%">
			<thead>
				<tr>
					<th width="8%">번호</th>
					<th width="">제목</th>
					<th width="8%">난이도</th>
					<th width="8%">정답 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="${pagingVO.dataList }" var="codeList" />
				<c:choose>
					<c:when test="${empty codeList }">
						<tr>
							<td colspan="4">등록된 문제가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${codeList }" var="codeList">
							<tr>
								<td>${codeList.prctQuesNo }</td>
								<td><a href="/member/codingTestDetail?prctQuesNo=${codeList.prctQuesNo }">${codeList.prctQuesTtl }</a></td>
							 	<td>
							 		Lv${codeList.prctQuesDfflyCd }
							 	</td>
								<td>
									<c:if test="${codeList.solutYn eq 'y'}">응시</c:if>
									<c:if test="${codeList.solutYn ne 'y'}">미응시</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div class="card-footer clearfix" id="pagingArea">
			<a>${pagingVO.pagingHTML }</a>
		</div>
	</div>
</div>
</div>
</div>



<script>
$(function() {
	// 페이징을 처리할 때 사용 할 Element
	// pagingArea div 안에 ul과 li로 구성된 페이징 정보가 존재
	// 그 안에는 a태그로 구성된 페이지 정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $('#pagingArea');
	var searchForm = $('#searchForm');

	pagingArea.on('click', "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find('#page').val(pageNo);
		searchForm.submit();
	});
});
</script>
<style>
	.page-item{
		margin-left: 48%;
	}
</style>