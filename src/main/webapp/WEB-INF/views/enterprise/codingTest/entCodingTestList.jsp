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
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/코딩테스트.jpg" width="1100px" height="300px">
							</div>
						</div>
						<br>
					</div>
				</div>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
								<form class="input-group input-group-sm" id="searchForm" method="get" style="width: 440px;">
									<input type="hidden" name="page" id="page"> 
									<select class="form-control" name="searchType">
										<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
									</select> 
									<input type="text" class="form-control float-right" name="searchWord" value="${searchWord }" placeholder="Search">
									<button type="submit" class="btn btn-primary">검색</button>
								</form>
								<button type="submit" class="btn btn-primary" id="registerCodingTestBtn">등록</button>
							</div>
							</div>
							<table class="info" width="100%">
								<thead>
									<tr>
										<th width="8%">번호</th>
										<th width="">제목</th>
									</tr>
								</thead>
								<tbody>
									<c:set value="${pagingVO.dataList }" var="codeList" />
									<c:choose>
										<c:when test="${empty codeList }">
											<tr>
												<td colspan="2">등록된 문제가 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${codeList }" var="codeList">
												<tr>
													<td>${codeList.rnum }</td>
													<td><a href="/ent/selectEntCodingTestDetail?entPqNo=${codeList.entPqNo }">${codeList.entPqTtl }</a></td>
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
	
	var registerCodingTestBtn = $('#registerCodingTestBtn');
	
	registerCodingTestBtn.on('click', function(){
		location.href = "/ent/registerEntCodingTest";
	})
});
</script>