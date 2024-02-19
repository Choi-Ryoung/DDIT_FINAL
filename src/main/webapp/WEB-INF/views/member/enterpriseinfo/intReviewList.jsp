<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link href="${ctxp}/resources/css/intreview/company_info.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/common_ui_keeping.css" rel="stylesheet">
<%-- <link href="${ctxp}/resources/css/intreview/components.css" rel="stylesheet"> --%>
<link href="${ctxp}/resources/css/intreview/gnb_default_override.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/header_default.css" rel="stylesheet">
<%-- <link href="${ctxp}/resources/css/intreview/layout.css" rel="stylesheet"> --%>
<link href="${ctxp}/resources/css/intreview/pattern.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/sticky_assist.css" rel="stylesheet">

<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: cornflowerblue;
	/* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

.list_review .box_review .view_title {
    padding: 30px 73px 30px 0;
    height: 118px;
    box-sizing: border-box;
}

.list_review .open {
    border : none;
}

.list_review .box_review {
    /* position: relative; */
    z-index: 1;
    margin-top: 10px;
    padding: 0 38px;
    border: 1px solid #eaeaea;
    box-sizing: border-box;
}

.pagination {
    margin-top: 30px;
    /* font-size: 0; */
    /* letter-spacing: -1px; */
    /* text-align: center; */
}


.list_review .view_title .btn_view {
    position: absolute;
    top: 0;
    right: 0;
    left: 0;
    z-index: 1;
    padding: 0 38px 4px 0;
    width: 100%;
    height: 119px;
    box-sizing: border-box;
    background: url(//www.saraminimage.co.kr/sri/common/bg_transparent.png) repeat;
    border: 1px solid grey;
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
								<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab"
									data-bs-target="#nav-home" type="button" role="tab"
									aria-controls="nav-home" aria-selected="true" onclick="location.href='${ctxp}/member/enterpriseinfo/entReviewList';">기업리뷰</button>
								<button class="nav-link active" id="nav-profile-tab"
									data-bs-toggle="tab" data-bs-target="#nav-profile"
									type="button" role="tab" aria-controls="nav-profile"
									aria-selected="false" onclick="location.href='${ctxp}/member/enterpriseinfo/intReviewList';">면접후기</button>
							</div>
						</nav>
					</div>
				</div><hr>
				<div class="row">
					<div class="col-md-12">
						<div class="header_interview_review">
						    <div class="inner">
						    <h2 class="blind">면접 경험, 공유해줘서 고마워요!</h2>
						        <p class="txt_noti">
						            면접의 A~Z까지 HIT 면접후기에서 확인해보세요!<br>
						            #전형 #진행방식 #면접질문 #면접후기
						        </p>
						        <a href="${ctxp}/member/enterpriseinfo/intReviewInsert" class="btn_review_write" onmousedown="try {dataLayer.push({'event': 'ga_lead', 'category': 'review_event', 'event-flow': 'click', 'event-label': 'top_add'});} catch (e) {}">
						            면접 후기 등록하기
						        </a>
						    </div>
						</div>
					</div>
				</div>
				<div class="row">			
					<nav class="navbar navbar-light">
					  <div class="container-fluid">
					    <a class="navbar-brand">면접후기 검색</a>
					    <form class="d-flex">
					      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
					      <button class="btn btn-outline-primary" type="submit">Search</button>
					    </form>
					  </div>
					</nav>
				</div>
				<div class="row">
					<c:choose>
						<c:when test="${empty irList }">
							<tr>
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
						</c:when>
							<c:otherwise>
											<div class="list_review">
												<c:forEach items="${irList }" var="irVo" varStatus="vs">
													<div class="box_review" data-ga-label="${vs.count }">
														<div class="view_title">
															<strong class="txt_company"> ${irVo.entNm } 
															<c:if test="${irVo.passYn eq '01'}">
																<span class="result pass">합격</span>
															</c:if>
															<c:if test="${irVo.passYn eq '02'}">
																<span class="result fail">불합격</span>
															</c:if>
															
															</strong> <span class="txt_date">${irVo.ivWrtDt}</span>
															<ul class="info_interview">
																<li>${irVo.applyTaskCd}</li>
																<li>${irVo.sexdstnCd}</li>
																<li>${irVo.ivCareerCd}</li>
															</ul>
															<button type="button" class="spr_review btn_view rounded">
																<span class="blind"></span>
															</button>
														</div>
														<div class="view_cont">
															<div class="info_emoticon">
																<dl class="review">
																	<dt>전반적 평가</dt>
																	<dd class="spr_review smile">긍정적</dd>
																</dl>
																<dl class="review difficulty">
																	<dt>난이도</dt>
																	<dd class="spr_review">${irVo.ivDfflyCd}</dd>
																</dl>
																<dl class="review result">
																	<dt>결과</dt>
																		<c:if test="${irVo.passYn eq '01'}">
																			<dd class="spr_review smile">합격</dd>
																		</c:if>
																		<c:if test="${irVo.passYn eq '02'}">
																			<dd class="spr_review sad">불합격</dd>
																		</c:if>
																</dl>
															</div>
															<div class="info_view">
																<strong class="tit_view">면접 유형</strong>
																<ul class="list_item">
																	<li>${irVo.ivTypeCd}</li>
																</ul>
															</div>
															<div class="info_view">
																<strong class="tit_view">면접 인원</strong>
																<ul class="list_item">
																	<li>${irVo.ivPcntCd}</li>
																</ul>
															</div>
															<div class="info_view">
																<strong class="tit_view">전형 및 면접 진행 방식</strong>
																<p class="txt_desc text-start"  style="white-space:pre-wrap;">${irVo.ivTypeCn}</p>
															</div>
															<div class="info_view">
																<strong class="tit_view">면접 질문</strong>
																<ul class="list_question">
																	<li style="white-space:pre-wrap">${irVo.ivQues}</li>
																</ul>
															</div>
															<div class="info_view">
																<strong class="tit_view">TIP 및 특이사항</strong>
																<p class="txt_desc" style="white-space:pre-wrap;">${irVo.ivPstSft}</p>
															</div>
														</div>
													</div>	
												</c:forEach>
											</div>
							</c:otherwise>
					</c:choose>
				</div>
				<div class="row">
					<nav aria-label="Page navigation example">
					  <ul class="pagination justify-content-center">
					    <li class="page-item disabled">
					      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
					    </li>
					    <li class="page-item active"><a class="page-link" href="#">1</a></li>
					    <li class="page-item disabled">
					      <a class="page-link" href="#">다음</a>
					    </li>
					  </ul>
					</nav> 				
				</div>
				<br><br>
<div class="row p-3 rounded bg-light">
	<div class="col-md-12">
		<div class="col mt-2 mb-2">
			<span class="text-black fs-5 fw-bold">안내 및 유의사항</span>
		</div>
		<div class="col-sm-12 mt-2 mb-2 text-black">
			- 후기 등록 안내
		</div>
		<div class="col-sm-12 mt-2 mb-2 text-black">
          ▶ 부합하지 않는 글은(욕설/비방/광고성/반복적인 글/허위 사실/기타 취지에 어긋나는 글) 관리자에 의해 통보 없이 삭제될 수 있습니다.
        </div>
	</div>
</div>
				
				
			</div>
		</div>
	</div>
</div>


<script>

$(document).on('click', '.btn_view', function(){
    $('.box_review').not($(this).closest('.box_review')).removeClass('open');
    $(this).closest('.box_review').toggleClass('open');
    if ($(this).closest('.box_review').hasClass('open')) {
        
    }
});

</script>




