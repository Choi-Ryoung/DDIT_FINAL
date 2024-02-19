<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>
img {
	border-radius: 4px; /* 이미지 모서리를 둥글게 만듭니다. */
	padding: 5px; /* 테두리와 이미지 사이의 간격 조절 */
	
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
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/employment/list'">채용공고</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/employment/briefingList'">채용설명회</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onClick="location.href='${cxtp}/member/jobAssist'">취업도우미</button>
							</div>
						</nav>
				     </div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/채용공고.jpg" width="1100px" height="300px">
							</div>
						</div>
					</div>
				</div>
				<hr>
				<nav class="navbar navbar-light">
				  <div class="container-fluid">
				    <a class="navbar-brand">채용공고 검색</a>
				    <form class="d-flex">
				      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				      <button class="btn btn-outline-primary" type="submit">Search</button>
				    </form>
				  </div>
				</nav>			
				<hr>

				<c:set value="${pagingVO.dataList }" var="employmentList" />
				<div class="container-fluid">
					<div class="px-lg-5">
						<div class="row">
							<c:choose>
								<c:when test="${empty employmentList }">
									<h1> 채용공고 없음!</h1>
								</c:when>
								<c:otherwise>
									<c:forEach items="${employmentList }" var="employment">
										<!-- Gallery item -->
										<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
											<div class="bg-white rounded shadow-sm">
												<img src="${employment.logoImg }" alt="" class="img-fluid card-img-top" width="230" height="230">
												<div class="p-4">
													<h5 class="text-truncate">
												        <a href="/employment/detail?empmnPbancNo=${employment.empmnPbancNo }" class="text-dark" title="${employment.empmnPbancTtl }">${employment.empmnPbancTtl }</a>
												    </h5>
												    <p class="small text-muted mb-0">작성자 : ${employment.empmnPbancWrtrNm }</p>
												    <p class="small text-muted mb-0">성별 : ${employment.genderCd}</p>
													<p class="small text-muted mb-0">경력 : ${employment.careerCd }</p>
													<p class="small text-muted mb-0">연봉 : ${employment.salary }</p>
													<p class="small text-muted mb-0 nullYMD">마감날짜 : ${fn:substring(employment.empmnPbancDdlnYmd, 0, 4)}년 ${fn:substring(employment.empmnPbancDdlnYmd, 5, 7)}월 ${fn:substring(employment.empmnPbancDdlnYmd, 8, 10)}일</p>
													<div class="d-flex align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4">
														<p class="small mb-0">
															<a href="/employment/detail?empmnPbancNo=${employment.empmnPbancNo }"><span class="font-weight-bold"><button type="button" class="btn btn-outline-success">상세보기</button></span></a>
														</p>
														<div class="badge-danger px-2 rounded-pill font-weight-normal">지역 : ${employment.rgn }</div>
													</div>
												</div>
											</div>
										</div>
										<!-- End -->
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
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

	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	var nullYMD = $(".nullYMD");
	
    // 공고 마감일이 null이면 '상시채용'으로 표시
	nullYMD.each(function() {
		var deadline = $(this).text().trim();
		console.log(deadline);
		if (deadline === "마감날짜 : 년 월 일") {
			$(this).text("마감날짜 : 상시채용");
		}
	});

});
</script>