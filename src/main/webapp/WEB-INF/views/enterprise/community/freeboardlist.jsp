<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div id="sh_container"> 
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <div id="greeting" class="pagecommon">
	               	<!-- 아래로 콘텐츠 추가  -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-dark card-outline">
					<div class="card-header">
						<div class="card-tools">
							<form class="input-group input-group-sm" id="searchForm" style="width: 440px;">
								<input type="hidden" name="page" id="page"/>
								
								<select class="form-control" name="searchType">
									<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
									<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
								</select> 
								<input type="text" name="searchWord" value="${searchWord }" 
									class="form-control float-right" placeholder="Search">
								<div class="input-group-append">
									<button type="submit" class="btn btn-default">
										<i class="fas fa-search"></i>검색
									</button>
								</div>
								<sec:csrfInput/>
							</form>
						</div>
						<h3 class="card-title">자유게시판</h3>
					</div>
					<div class="card-body">
						<table class="table table-bordered">
							<thead class="table-dark">
								<tr>
									<th style="width: 6%">번호</th>
									<th style="width: px">제목</th>
									<th style="width: 12%">작성자</th>
									<th style="width: 12%">작성일</th>
									<th style="width: 10%">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="${pagingVO.dataList }" var="freeBoardList" />
								<c:choose>
									<c:when test="${empty freeBoardList }">
										<tr>
											<td colspan="2">
												조회하실 글이 없습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${freeBoardList }" var="free">
											<tr>
												<td>${free.comntPstNo }</td>
												<td>
													<a href="/ent/freeboardDetail?comntPstNo=${free.comntPstNo }">
														${free.comntPstTtl }
													</a>
												</td>
												<td>${free.comntWrtrNm }</td>
												<td>${free.comntWrtDt }</td>
												<td>${free.comntInqCnt }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="card-footer clearfix" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
				</div>
			</div>
		</div>
	</div>

           	</div>
         </div>
      </div>
   </div>
<script>
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