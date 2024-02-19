<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="${ctxp}/resources/css/project/list.css">
<c:set value="${pagingVO.dataList }" var="collaboList"/>



<script>
// 만약 페이지 로딩 후에 동적으로 메뉴가 생성되는 경우가 있고 그 메뉴도 똑같이 기능을 해야한다면 아래 코드를 사용하면 됩니다.
$(document).on('click', '.accordion-list .accordion-item > .accordion-link', function(e){
	e.preventDefault();
	var $this = $(this);
	var target = $this.parent();
	var description = $this.siblings('.accordion-desc');
	var other = target.siblings('.accordion-item');
	var otherDescription = other.find('.accordion-desc');
	accordionToggle(target, description, other, otherDescription);
});

// 파라미터 정리
// target = 아이템 활성화 버튼
// description = 활성화 콘텐츠
// other = 활성화 시킬때 다른 형제 아이템 활성화 버튼
// otherDescription = 활성화 시킬때 다른 형제 아이템 활성화 콘텐츠
function accordionToggle(target, description, other, otherDescription){
	if (target.hasClass('active')) {
		target.removeClass('active');
		description.stop().slideUp(300);
	} else {
		target.addClass('active');
		description.stop().slideDown(300);
	}

// other, otherDescription 파라미터는 아코디언을 활성화 시킬때 다른 활성화된 아이템을 접기 위한 파라미터 입니다. 만약 다른 아이템들은 접히지 않아도 된다면 해당 파라미터를 비워두면 됩니다.
	if (other && otherDescription) {
		other.removeClass('active');
		otherDescription.stop().slideUp(300);
	}
};
</script>


<style>

/* 메뉴 배경 색상 */
.bg-custom {
	background-color: green; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

img {

	border-radius: 4px; /* 이미지 모서리를 둥글게 만듭니다. */
	padding: 5px; /* 테두리와 이미지 사이의 간격 조절 */
}
</style>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">${collabo.coPstWrtr }&nbsp;담당자연락처</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
   
   		
       
      </div>
      <div class="modal-footer">
        <input type="button" class="btn btn-danger" value="닫기" data-bs-dismiss="modal"/>
      </div>
    </div>
  </div>
</div>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs " id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${cxtp}/collabo/list'">협업기업</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/briefing/list'">내가한걸로</button>
							</div>
						</nav>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="p-2 p-md-5 text-white rounded bg-custom">
								<div class="col-md-12 px-0">
									<h1 class="display-5 fst-bold mb-2">협업기업</h1>
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
					<button type="button" class="btn me-md-2" id="newBtn">
						<i class="fas btn btn-success">협업기업 등록</i>
					</button>
				</div>
				<hr>
				
				<!-- 날짜를 출력하는 부분 -->
				<c:set var="formattedDate" value="${fn:substring(collabo.coWrtDt, 0, 10)}" />
					<c:choose>
						<c:when test="${empty collaboList }">
							<h1>글없음</h1>
						</c:when>
						<c:otherwise>
							<div class="wrap">
							 	 <!-- 아코디언 메뉴 -->
								<ul class="accordion-list">
									<c:forEach items="${collaboList }" var="collabo">
										<li class="accordion-item">
											<a href="#" class="accordion-link">
												<div class="accordion-name">
													<span class="icon">${collabo.coPstNo }</span>&emsp;&emsp;
													[ <c:set var="formattedDate" value="${fn:substring(collabo.coWrtDt, 0, 10)}" /> ${formattedDate} ]&emsp;${collabo.coPstTtl }
												</div>
											</a>
											<div class="accordion-desc">
											 	${collabo.coPstCn }<br>
						 	
											 	<span class="sub">							 	
												 	<button type="button" class="btn me-md-2" id="applyBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">
												 		<i class="fas btn btn-success">담당자 연락처</i>
												 	</button>
											 	</span><br>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
						</c:otherwise>
					</c:choose>
	
				<hr>
				
			</div>
		</div>
	</div>
</div>






							 	
