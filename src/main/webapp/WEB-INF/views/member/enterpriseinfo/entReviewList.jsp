<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<link href="${ctxp}/resources/css/entreview/company_review.css" rel="stylesheet"> 
<link href="${ctxp}/resources/css/intreview/company_info.css" rel="stylesheet">
<link href="${ctxp}/resources/css/intreview/pattern.css" rel="stylesheet">

<style>
	/* 메뉴 배경 색상 */
    .bg-custom {
        background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
    }
    
    .spr_bg_company {
    height: 300px;
    vertical-align: top;
    background: url(//www.saraminimage.co.kr/sri/company_review/spr_company_review.png) no-repeat;
}
.btn_review_write {
    display: block;
    position: absolute;
    top: 350px;
    left: 950px;
    width: 246px;
    height: 44px;
    border-radius: 4px;
    box-sizing: border-box;
    color: var(--white);
    font-size: 16px;
    letter-spacing: -1px;
    line-height: 42px;
    text-align: center;
    background-color: var(--blue80);
}

.btn_review_write:hover {
    color:white;
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
						</div><hr>
							<div class="row">
								<div class="col-md-12 mt-3 mb-3">
										<div class="main_top inner_content px-3">
											<h2 class="title spr_bg_company">
											</h2>
											<p class="desc_top text-black">
											</p>
										<a href="${ctxp}/member/enterpriseinfo/entReviewInsert" class="btn_review_write">
						            		기업 리뷰 등록하기
						        		</a>
									</div>
								</div>
							</div>
<hr>
<nav class="navbar navbar-light">
  <div class="container-fluid">
    <a class="navbar-brand">기업리뷰 검색</a>
    <form class="d-flex">
      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-primary" type="submit">Search</button>
    </form>
  </div>
</nav>							
				<c:choose>
							<c:when test="${empty emList }">
								<tr>
									<td colspan="5">등록된 글이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${emList}" var="emVo" varStatus="vs">
									<input type="hidden" name="entMbrId" value="${emVo.entMbrId}">
									<hr>
										<div class="row">
										  <div class="col-md-2 text-center">
										    	<img src="${ctxp}${emVo.logoImg}" alt="" class="img-fluid card-img-top border rounded" style="width: 120px; height: 120px;">
										  </div>
										  <div class="col-md-2 text-start">
										    	<a class = "text-black fs-5 fw-bold" href="${ctxp}/member/enterpriseinfo/entReviewDetail?entMbrId=${emVo.entMbrId}">${emVo.entNm}</a>
										    	<div class="col mt-2 mb-2 text-primary ">
										    		<c:set var="toggle" value="0"></c:set>
										   			<c:forEach items="${amcList}" var="amcVo" varStatus="vs">
											  			<c:if test="${emVo.entMbrId eq amcVo.ENT_MBR_ID}">
											  				<c:if test="${not empty amcVo.CNT}">#현재 채용중 : ${amcVo.CNT}건</c:if>
											  				<c:set var="toggle" value="1"></c:set>
											  			</c:if>
										  			</c:forEach>
										  			<c:if test="${toggle eq '0'}">#현재 채용중 : 0건</c:if>
										 	 	</div>
										  </div>
										  <div class="col-sm-7 text-center">
										  		<div class="col mt-3 ">
										  			<c:if test="${not empty rankList}">
											  			<c:forEach items="${rankList}" var="rankVo" varStatus="vs">
												  			<c:if test="${emVo.entMbrId eq rankVo.ENT_MBR_ID}">
												  				#${rankVo.CLOTHES_TYPE}&emsp;
												  				#${rankVo.ATTENDANCE_TYPE}&emsp;
												  				#연차 ${rankVo.ANNUAL_TYPE}&emsp;
												  			</c:if>
											  			</c:forEach>
										  			</c:if>
										  		</div>
										  		<div class="col mt-2 ">
										  			<c:forEach items="${rankList}" var="rankVo" varStatus="vs">
											  			<c:if test="${emVo.entMbrId eq rankVo.ENT_MBR_ID}">
											  				#성비 : ${rankVo.SEX_RATIO}&emsp;
											  				#야근 횟수  : ${rankVo.OVERTIME_CNT}&emsp;
											  				#연봉 인상률 : ${rankVo.SAL_INC_PER}&emsp;
											  				#연차 사용일 :${rankVo.ANNUAL_USE_D}&emsp;
											  			</c:if>
										  			</c:forEach>
										  		</div>
										  </div>
										</div>
									<hr>		
																			
								</c:forEach>
							</c:otherwise>
						</c:choose>
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
				<br><br>
				<div class="row p-3 rounded bg-light">
					<div class="col-md-12">
						<div class="col mt-2 mb-2">
							<span class="text-black fs-5 fw-bold">안내 및 유의사항</span>
						</div>
						<div class="col-sm-12 mt-2 mb-2 text-black">
							- 기업리뷰는 이력서 내 경력사항이 작성된 경우 등록이 가능합니다.
						</div>
						<div class="col-sm-12 mt-2 mb-2 text-black">
				          ▶ 현직자 퇴사자가 직접 입력한 데이터로 실제 기업의 내용과 차이가 발생할 수 있으므로 참고하는 자료로 활용하시기를 권장해드립니다.
				        </div>
					</div>
				</div> 						 
           	</div>
         </div>
      </div>
   </div>
 
<style>
 /* 오늘 하루 보지 않기 팝업 */
button {
  border: 0;
  background: none;
  cursor:pointer;
}


.main_popup {
    position: fixed;
    z-index: 1005;
    top: 10%;
    left: 30%;
    display: none;

  &.on {
    display: block;
    background-color: #fff;
  }

.img_wrap {
    width: 600px;
    height: 600px;
    display: flex;
    justify-content: center;
    align-items: center;
    border : 1px solid;
}
  .btn_close {
    width: 32px;
    height: 32px;
    position: absolute;
    top: 17px;
    right: 17px;
    font-size: 0;
    border: 0;
    background: none;

    &::before {
      content: "";
      width: 2px;
      height: 32px;
      background-color: #333;
      position: absolute;
      top: 0;
      left: 15px;
      transform: rotate(45deg);
    }
    &::after {
      content: "";
      width: 32px;
      height: 2px;
      background-color: #333;
      position: absolute;
      top: 15px;
      left: 0;
      transform: rotate(45deg);
    }
  }

  .btn_today_close {
    width: 100%;
    height: 45px;
    background-color: #333;
    text-align: center;
    color: #fff;
    font-size: 14px;
    display: block;
    span {
      display: block;
      line-height: 40px;
      vertical-align: bottom;
      opacity: 0.8;
    }
  }
}
 
</style>

<div class="main_popup">
  <div class="layer_cont">
  	<span>테스트 내용</span>
    <div class="img_wrap">
    	<img class="img-fluid profile-image-pic img-thumbnail my-3" src="${ctxp}/resources/img/main/main_banner_01.jpg" alt="profile" style="width: auto; height: auto;">
    </div>
    <div class="btn_wrap">
      <!-- 오늘 하루 보지 않기 --->
      <button class="btn_today_close"><span>오늘 하루 보지 않기</span></button>
      <!-- 그냥 닫기 --->
      <button class="btn_close">close</button>
    </div>
  </div>
</div> 

<script>
//팝업 제어
var toggleMainPopup = function() {

  /* 스토리지 제어 함수 정의 */
  var handleStorage = {
    // 스토리지에 데이터 쓰기(이름, 만료일)
    setStorage: function (name, exp) {
      // 만료 시간 구하기(exp를 ms단위로 변경)
      var date = new Date();
      date = date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000);

      // 로컬 스토리지에 저장하기
      // (값을 따로 저장하지 않고 만료 시간을 저장)
      localStorage.setItem(name, date);
    },
    // 스토리지 읽어오기
    getStorage: function (name) {
      var now = new Date();
      now = now.setTime(now.getTime());
      // 현재 시각과 스토리지에 저장된 시각을 각각 비교하여
      // 시간이 남아 있으면 true, 아니면 false 리턴
      return parseInt(localStorage.getItem(name)) > now;
    }
  };

  // 로컬스토리지 읽고 화면 보이게
  if (handleStorage.getStorage("today")) {
    $(".main_popup").removeClass("on");
  } else {
    $(".main_popup").addClass("on");
  }

  // 오늘하루 보지 않기 버튼
  $(".main_popup").on("click", ".btn_today_close", function () {
    // 로컬 스토리지에 today라는 이름으로 1일(24시간 뒤) 동안 보이지 않게
    handleStorage.setStorage("today", 1);
    $(this).parents(".main_popup.on").removeClass("on");
  });

  // 일반 닫기 버튼
  $(".main_popup").on("click", ".btn_close", function () {
    $(this).parents(".main_popup.on").removeClass("on");
  });
};



</script>
 

<script type="text/javascript">


$(function(){
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
	
	 //toggleMainPopup();
	
});
</script>



