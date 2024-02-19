<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: cornflowerblue;
	/* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

#registerBtn{
	float: right;
	margin-top: 20px;
	width: 150px;
}

</style>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example"></div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<img src="${ctxp}/resources/img/main/menu_banner/멘토링.jpg" width="1200px" height="300px">
						</div>
							<button type="button" class="btn btn-outline-primary" id="registerBtn">등록</button>
					</div>
				</div>
				<hr>
				<!-- 여기부터 -->
				<div>

					<form class="input-group input-group-sm" method="post"
						id="searchForm" style="width: 440px;">
						<input type="hidden" name="page" id="page" /> <select
							class="form-control" name="searchType">
							<option value="nickname"
								<c:if test="${searchType eq 'nickname' }">selected</c:if>>닉네임
								검색</option>
							<option value="job"
								<c:if test="${searchType eq 'job' }">selected</c:if>>직무별
								검색</option>
							<option value="enterprise"
								<c:if test="${searchType eq 'enterprise' }">selected</c:if>>기업명</option>
							<option value="career"
								<c:if test="${searchType eq 'career' }">selected</c:if>>경력</option>
						</select> <input type="text" name="searchWord" value="${searchWord }"
							class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="submit" class="btn btn-primary" style="margin-left: 10px;">
								검색
							</button>

						</div>
					</form>
					<br>
					<c:set value="${pagingVO.dataList }" var="mentoList" />
					<c:set value="${dutyList }" var="duty" />
					<c:set value="${careerList }" var="career" />
					<c:choose>
						<c:when test="${empty mentoList }">
							<tr>
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${mentoList }" var="mentoVo" varStatus="vs">
								<div class="card mb-3">
									<div class="card-body" id="eachCard">
										<div class="d-flex flex-column flex-lg-row">
											<div class="row flex-fill">
												<div class="col-sm-4 py-2">
													<h4 class="h5" style="font-weight: bold;">
														<a href="/mento/find?menNcnm=${mentoVo.menNcnm }">${mentoVo.menNcnm }</a>
														<c:if test="${mentoVo.procCd eq '대기중'}">
															<span class="badge mr-3" style="color: darkgray; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
														</c:if>
														<c:if test="${mentoVo.procCd eq '승인'}">
															<span class="badge mr-3" style="color: blue; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
														</c:if>
														<c:if test="${mentoVo.procCd eq '반려'}">
															<span class="badge mr-3" style="color: red; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
														</c:if>
													</h4>
													<span class="h6">${mentoVo.menPstCn }</span> <br>
													<span class="badge bg-warning mr-3">${mentoVo.applyTaskCd }</span>
													<span class="badge bg-warning mr-3">${mentoVo.applyCareerCd }</span><br>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 페이징 -->    
				<!--Bottom Table UI-->
				<div class="d-flex justify-content-center" style="margin-top:15px;">
				  	<!--Pagination -->
					<div class="card-footer clearfix" id="pagingArea">
						<a>${pagingVO.pagingHTML }</a>
					</div>
				    <!--/Pagination -->
				</div>
				<hr>

					


				<!-- 여기까지 -->
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

var registerBtn = $("#registerBtn");
var procCd2 = "${mentoVo.procCd}";
var menNcnm = "${mentoInfo.menNcnm}";
var procCd = "${mentoInfo.procCd}";
var prMbrId = "${SessionInfo.prMbrId}";
var prMbrNcnm = "${SessionInfo.prMbrNcnm}";
console.log("menNcnm : " + menNcnm);
console.log("procCd : " + procCd);
console.log("procCd2 : " + procCd2);
console.log("prMbrId : " + prMbrId);
console.log("prMbrNcnm : " + prMbrNcnm);





$(function(){
	if (menNcnm == prMbrNcnm && procCd == "승인") {
		registerBtn.hide();
	}
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
	
	registerBtn.on("click", function(){
		location.href = "/mento/form";
	});
	
});
</script>
