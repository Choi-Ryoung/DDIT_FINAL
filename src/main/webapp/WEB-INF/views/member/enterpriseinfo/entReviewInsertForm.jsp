<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<link href="${ctxp}/resources/css/entreview/company_review.css" rel="stylesheet"> 

<style>
	/* 메뉴 배경 색상 */
    .bg-custom {
        background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
    }
    
        .spr_bg_company 
    {
    height: 300px;
    vertical-align: top;
    background: url(//www.saraminimage.co.kr/sri/company_review/spr_company_review.png) no-repeat;
	}
	
	   .ui-autocomplete {
        max-height: 200px;
        overflow-y: auto;
        /* prevent horizontal scrollbar */
        overflow-x: hidden;
        /* add padding to account for vertical scrollbar */
        padding-right: 20px;
          height: auto;
    } 
}

.ui-menu-item div.ui-state-hover,
.ui-menu-item div.ui-state-active {
  color: #ffffff;
  text-decoration: none;
  background-color: #f6B664;
  border-radius: 0px;
  -webkit-border-radius: 0px;
  -moz-border-radius: 0px;
  background-image: none;
  border:none;
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
						</div><hr>
							<div class="row">
								<div class="col-md-12 mt-3 mb-3">
										<div class="main_top inner_content">
											<h2 class="title spr_bg_company">
											</h2>
											<p class="desc_top text-black">
											</p>
										</div>
								</div>
							</div><hr> 
						<div class="card-body">
						<form action="${ctxp}/member/enterpriseinfo/entReviewInsert.do" method="post" id="entReviewForm">
							<div class="row">
									<div class="col-md-6 mb-1">
									   	 <input type="text" id ="entNm" name = "entNm" class="form-control" placeholder="기업명을 입력하세요">
									</div>
									<div class="col-md-6 mb-1 text-end">
										 <span class="text-black">재직 여부 &emsp;</span>
										 <input type="radio" class="btn-check" name="serveYn" id="serveY" value="Y">
										 <label class="btn btn-outline-primary" for="serveY">재직</label>
										 <input type="radio" class="btn-check" name="serveYn" id="serveN" value="N">
										 <label class="btn btn-outline-primary" for="serveN">퇴사</label>
									</div>
							</div><hr>
							<c:set var = "cnt" value= "1" />
							<c:forEach items="${quesCnList}" var="quesCnVo">
								<div class="row align-items-center">
											<div class="col-md-7 mb-1 text-black fs-6">
												${quesCnVo.quesCn}
										    </div>
										    <div class="col-md-5 mb-1 text-end">
													<c:forEach items="${quesList}" var="quesVo" varStatus="vs">
														<c:if test="${quesCnVo.quesCn eq quesVo.quesCn}">
															<input type="radio" class="btn-check" name="${quesVo.quesCd}" id="q${cnt}" value="${quesVo.optionCn}">
															<label class="btn btn-outline-primary" for="q${cnt}">${quesVo.optionCn}</label>
															<c:set var="cnt" value="${cnt + 1}" />
														</c:if>
													</c:forEach>
											</div>
								</div><hr>
							</c:forEach>
					    <div class="row">
					        <div class="col-8 mb-1">
					            <p>직접 쓰는 리뷰</p>
					            <textarea id="entrvPstCn" name="entrvPstCn" class="form-control" rows="3" placeholder="기업에 대한 내용을 적어주세요"></textarea>
					        </div>
					    </div> <hr>
					   
					    <div class="row">
					        <div class="col-6">
					            <div class="input-group mb-3">
					                <div class="form-group clearfix">
					                    <div class="icheck-primary d-inline">
					                        <button type="submit" class="btn btn-primary btn-inline">등록하기</button>
					                    </div>
					                    <div class="icheck-primary d-inline">
					                        <button type="button" class="btn btn-primary btn-inline" onclick="javascript:history.back()">뒤로가기</button>
					                    </div>
					                    <div class="icheck-primary d-inline">
					                        <button type="button" id="btnAuto" class="btn btn-primary btn-inline">자동완성</button>
					                    </div>
					                </div>
					            </div>
					        </div>
					    </div>
					    
					</form>	
				</div>
           	</div>
         </div>
      </div>
   </div>
</div>




<script>
$('#entNm').autocomplete({
	
	source : function(request, response) { //source: 입력시 보일 목록
	     $.ajax({
	           url : "${ctxp}/member/enterpriseinfo/entNmAutoComplete.do"   
	         , type : "POST"
	         , dataType: "JSON"
	         , maxResults: 10
	         , data : {value: request.term}	// 검색 키워드
	         , success : function(data){ 	// 성공
	             response(
	            		 $.map(data.resultList, function(item) { // 최초 10개만 선택
	                     return {
	                    	     label : item.ENT_NM    	// 목록에 표시되는 값
	                           , value : item.ENT_NM 		// 선택 시 input창에 표시되는 값
	                           , idx : item.ROWNUM // index
	                     };
	                 })
	             );    //response
	         }
	         ,error : function(){ //실패
	             alert("오류가 발생했습니다.");
	         }
	     });
	}
	,focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
			return false;
	}
	,minLength: 0// 최소 글자수
	,autoFocus : true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
	,delay: 300	//autocomplete 딜레이 시간(ms)
	,select : function(evt, ui) { 
      	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
			console.log(ui.item.label);
			console.log(ui.item.idx);
	 }
}).focus(function() {
    $(this).autocomplete("search", $(this).val());
});


$(function(){
	$("#btnAuto").on("click",function(){
		$("#entNm").val("레드캡");
		$("#serveY").prop("checked",true);
		$("#q1").prop("checked", true);
		$("#q4").prop("checked", true);
		$("#q8").prop("checked", true);
		$("#q12").prop("checked", true);
		$("#q15").prop("checked", true);
		$("#q19").prop("checked", true);
		$("#q22").prop("checked", true);
		$("#q25").prop("checked", true);
		$("#entrvPstCn").val("복지가 정말 좋아요 굿");
	})
})
</script>

   