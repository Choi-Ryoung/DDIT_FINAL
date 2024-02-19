<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${ctxp}/notice/list.do'">공지사항</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/freeboard/list.do'">자유게시판</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/faq/list'">FAQ</button>
								<button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/answer/list.do'">1:1 문의</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="mt-4">
					<img src="${ctxp}/resources/img/main/menu_banner/자유게시판.jpg" width="1200px" height="300px">
				</div>
				<hr>
				<nav class="navbar navbar-light">
				  <div class="container-fluid">
				    <a class="navbar-brand">1:1문의 검색</a>
				    <form class="d-flex">
				      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				      <button class="btn btn-outline-primary" type="submit">Search</button>
				    </form>
				  </div>
				</nav>			
				<hr>

					
					<div class="card-body">
						<table class="table table-bordered">
							<thead class="table">
								<tr>
									<th style="width: 6%">번호</th>
									<th style="width: px">제목</th>
									<th style="width: 12%">작성자</th>
									<th style="width: 12%">작성일</th>
									<th style="width: 10%">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="${pagingVO.dataList }" var="answerList" />
								<c:choose>
									<c:when test="${empty answerList }">
										<tr>
											<td colspan="2">
												조회하실 글이 없습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${answerList }" var="answer">
											<tr>
												<td>${answer.ansNo }</td>
												<td>
													<a href="/answer/detail.do?ansNo=${answer.ansNo }">
														${answer.ansTtl }
													</a>
												
												</td>
												<td>${answer.ansWrtr }</td>
												<td>${answer.ansWrtDt }</td>
												<td>${answer.ansInqCnt }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="card-footer bg-white" align="right">
						<button type="button" class="btn btn-success" id="newBtn">등록</button>
					</div>
					<div class="card-footer bg-white clearfix" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
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
	
	// 등록 버튼 클릭 시, 게시판 등록 페이지로 이동
	newBtn.on("click", function(){
		location.href = "/answer/form.do";
	});
});
</script>
