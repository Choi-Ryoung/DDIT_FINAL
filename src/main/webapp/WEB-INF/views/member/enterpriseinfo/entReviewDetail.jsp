<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">						
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<style>
body{
margin-top:20px;
 --bs-font-sans-serif:margin:0; padding:0;font-size:17px;line-height:1.6;font-family:'Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400;
}

</style>

<style>
	/* 메뉴 배경 색상 */
    .bg-custom {
        background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
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
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
									data-bs-target="#nav-home" type="button" role="tab"
									aria-controls="nav-home" aria-selected="true" onclick="location.href='${ctxp}/member/enterpriseinfo/entReviewList';">기업리뷰</button>
								<button class="nav-link " id="nav-profile-tab"
									data-bs-toggle="tab" data-bs-target="#nav-profile"
									type="button" role="tab" aria-controls="nav-profile"
									aria-selected="false" onclick="location.href='${ctxp}/member/enterpriseinfo/intReviewList';">면접후기</button>						            
						          </div>
						        </nav>
						     </div>
						</div>
				<hr>
				<div class="row px-3 entData">
					<div class="col-md-12">
						<div class="col mt-2 mb-2">
							<a class="text-primary fs-5 fw-bold" target= "_blank" href="${emVo.hmpgAddr}">${emVo.entNm}</a>
							<c:if test="${emVo.entSe eq 'major company'}">
								<span class="text-success">&emsp; 대기업</span>
							</c:if>
							<c:if test="${emVo.entSe eq 'mid company'}">
								<span class="text-success">&emsp; 중소기업</span>
							</c:if>
							<c:if test="${emVo.entSe eq 'small company'}">
								<span class="text-success">&emsp; 소기업</span>
							</c:if>
						</div>
						<div class="col-sm-12 mt-2 mb-2 text-black">
							대표 연락처 : ${emVo.entRprsTelno}&emsp; 본사 주소 : ${emVo.entBscAddr} ${emVo.entDaddr}
						</div>
						<div class="col-sm-4 mt-2 mb-2 text-black">
							대표 명 : ${emVo.rprsvNm}
						</div>
					</div>
				</div>
				<hr>
				<h4 class= "text-black fs-5 px-3">기업 리뷰</h4><hr>
						<div class="container mt-5 mb-3">
						    <div class="row">
						    <c:set var="percentList" value="${percentList}"/> 
						    <c:set var="cntList" value="${cntList}"/> 
						    	<c:forEach items="${quesCnList}" var="quesCnVo">
									<div class="col-md-4 mb-4">
									   <div class="card p-3 mb-2 h-100">
									       <div class="d-flex justify-content-between">
									           <div class="d-flex flex-row align-items-center">
									               <div class="icon"> <i class="bx bxl-mailchimp"></i> </div>
									               <div class="ms-2 c-details">
									                   <h6 class="mb-1 text-black">${quesCnVo.quesCn}</h6>
									               </div>
									           </div>
									       </div>
									       <div class="mt-3">
										        <c:forEach items="${quesList}" var="quesVo" varStatus="vs">
										        	<c:if test="${quesCnVo.quesCn eq quesVo.quesCn}">
										               <div class="progress">
										                   <div class="progress-bar" role="progressbar" style="width: ${percentList[vs.index]}%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
										               </div>
										               <div class="mt-1 text-black fs-6"> <span class="text1 text-black fs-6">${percentList[vs.index]}%(${cntList[vs.index]}) <span class="text2 text-black fs-6">${quesVo.optionCn}</span></span> </div>
										            </c:if>
										      	</c:forEach>
									       </div>
									    </div>
									</div>
								</c:forEach>
						    </div>
						</div><hr>
						
					<h4 class= "text-black fs-5 px-3">직접 쓴 리뷰</h4><hr>
<div class="owl-carousel owl-theme">
    <c:forEach items="${erDetailList}" var="erdVo" varStatus="vs">
        <div class="item">
            <div class="card p-3 mb-2">
                <fmt:parseDate var="parsedDate" value="${erdVo.entrvWrtDt}" pattern="yyyy-MM-dd HH:mm:ss" />
	               <c:if test="${erdVo.serveYn eq 'Y'}"> <span class="text-primary">재직자</span></c:if>
	               <c:if test="${erdVo.serveYn eq 'N'}"> <span class="text-danger">퇴사자</span></c:if>
                <span class="">작성일 : <fmt:formatDate value="${parsedDate}" pattern="MM/dd" /></span>
                <hr>
                <span class="text-black">${erdVo.entrvPstCn}</span>
            </div>
        </div>
    </c:forEach>
</div>

           	</div>
         </div>
      </div>
   </div>




<script type="text/javascript">
$(".owl-carousel").owlCarousel({
    nav:true,
	loop: true,
	dots: true,
    autoplay:true,
	rewind: true,
	autoplayTimeout: 3000,
    margin:10,
    responsiveClass:true,
    responsive:{
        0:{
            items:2,
            nav:true
        },
        600:{
            items:3,
            nav:false
        },
        1000:{
            items:6,
            nav:true,
            loop:false
        }
    }
	});
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $("#pagingArea");
	var erSearchForm = $("#erSearchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		erSearchForm.find("#erPage").val(pageNo);
		erSearchForm.submit();
	});

</script>



