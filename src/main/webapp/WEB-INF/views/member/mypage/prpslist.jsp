<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>

<style>
/* 메뉴 배경 색상 */
.bg-custom {
    background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}
#resultDiv{
	width: 94%;
	height: 50px;
	background-color: beige;
}
#listId{
	color: black;
}

table {
	width : 100%;
}

th:nth-child(1) {
	width: 3%;
}

th:nth-child(2) {
	width: 15%;
}

th:nth-child(3) {
	width: 30%;
}


.modal-background {
  position: relative;
}

.modal-background::before {
  content: "";
  background-image: url("${ctxp}/resources/img/loginform/배경2.jpg");
  background-size: cover;
  background-position: center;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: -1; /* 배경 이미지를 모달의 뒤로 보냅니다. */
}

.modal-body {
  padding: 2rem;
}

.modal-dialog {
  max-height: calc(100vh - 50px); 
  /* 높이를 브라우저 높이에서 헤더 높이를 뺀 값으로 설정합니다. */
}
</style>
	
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
    <div class="modal-body" style="background-image: url('${ctxp}/resources/img/loginform/배경2.jpg'); background-size: cover; background-position: center; padding: 2rem;">
        <div id="modalBodyContent" style="white-space: pre-line;">
          <!-- 여기에 모달 바디 내용을 채웁니다. -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
						<div class="row">
						    <div class="col-md-12">
						        <div class="card card-outline card-danger mt-4">
									<img src="${ctxp}/resources/img/main/menu_banner/이직_취업제안.jpg" width="1100px" height="300px">
								</div>
						    </div>
						</div><hr>
						</div>
					        <nav>
					          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
					            <button class="nav-link " data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onclick="location.href='${ctxp}/member/mypage/myInfo'">회원 정보</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mentoUpdate'">멘토링 정보</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/applyList'">지원 내역</button>
					            <button class="nav-link active"  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업 제안</button>
					            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/chart'">나의 통계</button>
								<button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서 관리</button>
					          </div>
					        </nav>
							<hr>
							<c:set value="${pagingVO.dataList }" var="prpsList"/>
							<c:choose>
									<c:when test="${empty prpsList}">
											<p>받으신 제안이 아직 없습니다.</p>
									</c:when>
								
									<c:otherwise>
										<c:forEach items="${prpsList}" var="prps" varStatus="vs">
												<div class="row px-3 resumeData ">
												  <input type="hidden" name ="prpslNo" id="prpslNo" value="${prps.prpslNo}">
												  <div class="col-md-8">
												  	<span class="text-primary fs-6 ">
													  	 <button id="listId" type="button" class="btn btn-link listId" data-id = "${prps.prpslNo}" data-bs-toggle="modal" data-bs-target="#staticBackdrop">${prps.prpslTtl }</button> 
													  		<span class="text-primary fs-6" id="open">
													  			미열람
													  		</span>
												  	</span>
												  </div>
												</div>
											<hr>											
										</c:forEach>
									</c:otherwise>	
							</c:choose>		
							
				<!-- 페이징 -->
				<!--Bottom Table UI-->
				<div class="d-flex justify-content-center" style="margin-top: 15px;">
					<!--Pagination -->
					<div class="card-footer clearfix" id="pagingArea">
						<a>${pagingVO.pagingHTML }</a>
					</div>
					<!--/Pagination -->
				</div>

				<!-- greeting 끝 -->
           	</div>
         <!-- sh_content 끝 -->
         </div>
      <!-- sh_container_wrapper 끝 -->
      </div>
   <!-- sh_container 끝 -->
   </div>

<script>
$(function(){
	$("#staticBackdropLabel").val(""); // 모달 제목 채우기
    $("#modalBodyContent").val("") // 모달 내용 채우기
	
    // listId 버튼을 클릭했을 때
    $(".listId").on("click", function(){
    	var prpslNo = $(this).data("id");
    	/* 
        // 클릭한 버튼에 해당하는 정보 가져오기
        var prpslNo = $(this).siblings("input[name='prpslNo']").val(); // prpslNo 가져오기
		console.log("prpslNo", prpslNo);
         */
        // AJAX를 통해 서버에서 데이터 가져오기
        $.ajax({
            url: "/member/mypage/selectPrpsList", // 서버에서 데이터를 가져오는 엔드포인트 URL
            type: 'POST',
            data: { prpslNo: prpslNo }, // prpslNo를 서버로 전송하여 해당하는 내용을 가져옴
            dataType: 'json', // 반환되는 데이터 타입이 JSON임을 명시
            success: function(response) {
                // 서버로,table부터 가져온 데이터를 모달에 채워 넣기
                /* 
                str = `<table class='table table-hover'>
                str += 
                 */	
                 console.log("response", response);
                $("#staticBackdropLabel").text(response.prpslTtl); // 모달 제목 채우기
                $("#modalBodyContent").text(response.prpslCn); // 모달 내용 채우기

                // 모달 열기
                $("#staticBackdrop").modal("show");
                
                $(this).closest("div").find("#open").hide();
            },
            error: function(xhr, status, error) {
                // 오류 처리
                console.error(error);
            }
        });
    });
});





function fdel(pThis){
	var shSpan = pThis.parentElement;
	console.log("aaa",shSpan);
	var resultDiv = document.querySelector("#resultDiv");
	console.log(resultDiv);
	resultDiv.removeChild(shSpan);

}


$(function(){
	var searchDiv = $(".searchDiv");
	var dutyDiv = $("#dutyDiv");
	var careerDiv = $("#careerDiv");
	var searchCareer = $(".searchCareer");
	var divFlag = false;
	var careerFlag = false;
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	
	
	$("#dutyDiv").hide();
	$("#careerDiv").hide();
	
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	allData = [];



	dutyDiv.on("click", "button", function(){
		var duty = $("<span>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
	    
		console.log(duty);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}

		$("#resultDiv").append(duty);
		
		$("#searchForm").append("<input type='hidden' name='dutyCd' value='"+$(this).data("cd")+"'/>");
	});
	
	careerDiv.on("click", "button", function(){
	    var career = $("<span>" + $(this).text()+"<i class='fa fa-trash-o' onclick='fdel(this)'></i></span>");
		console.log(career);

		var spans = document.querySelector("#resultDiv").querySelectorAll("span");
		for(var i=0; i<spans.length; i++){
			if(spans[i].innerText.includes($(this).text())){
				return;
			}
		}
		
		$("#resultDiv").append(career);
	
	});
	  $(".listId").on("click", function(){
	        // 클릭한 버튼의 부모 요소인 span을 찾아서 그 안에 있는 id="open"인 요소를 숨깁니다.
	        $(this).closest("div").find("#open").hide();
	        
	        // 나머지 AJAX 및 모달 열기 코드는 여기에 넣으세요
	    });

	
});
</script>