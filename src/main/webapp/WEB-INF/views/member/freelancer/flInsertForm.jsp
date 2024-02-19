<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  
<style>
body{
margin-top:20px;
 --bs-font-sans-serif:margin:0; padding:0;font-size:17px;line-height:1.6;font-family:'Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400;
}

</style>

    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <!-- sh_sub_banner [s] -->
            <div id="sh_sub_banner">
                <div id="sh_content_tit">
                    <h3>프로젝트 등록</h3>
                    <p><a href="/"><i class="fa fa-home"></i><span class="sound_only">홈으로</span></a> 
                    <i class="fa fa-angle-right"></i> 회사소개 <i class="fa fa-angle-right"></i> 회사소개</p>
                </div>
            </div>
			<div>
				<div class="bd-example">
			        <nav>
			          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
			            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">프로젝트 등록</button>
			            <button class="nav-link " id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">프리랜서 찾기</button>
			          </div>
			        </nav>
			     </div>
			</div>              
			<div class="card card-outline card-secondary mt-4 mb-4">
					<div class="p-4 p-md-5 mb-4 text-white rounded btn-success">
				    	<div class="col-md-6 px-0">
				      	<h1 class="display-4 fst-bold">프로젝트 등록</h1>
				      	<p class="lead my-3">Multiple lines of text that form the lede, informing new readers quickly and efficiently about what’s most interesting in this post’s contents.</p>
				    </div>
			</div>
			<div class="card-body">
				<form action="${ctxp }/enterprise/freelancer/pjInsert.do" method="post" id="pjForm">
								<div class="row">
								        <label for="pjtNm" class="form-label">프로젝트명</label>
										<div class="col-auto">
										    <input type="text" id ="pjtNm" name = "pjtNm" class="form-control" >
										</div>
								</div><hr>
								<div class="row">
								        <label for="estPrd" class="form-label">예상기간</label>
										<div class="col-auto">
										    <input type="text" id ="estPrd" name = "estPrd" class="form-control" >
										</div>
								</div><hr>
								<div class="row">
								        <label for="estSalary" class="form-label">예상금액</label>
										<div class="col-auto">
										    <input type="text" id ="estSalary" name = "estSalary" class="form-control" >
										</div>
								</div><hr>
								<div class="row">
								        <label for="workWay" class="form-label">업무방식</label>
										<div class="col-auto">
										    <input type="text" id ="workWay" name = "workWay" class="form-control" >
										</div>
								</div><hr>
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="careerCd" class="form-label">경력</label>
								        <select id="careerCd" name ="careerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="careerList" varStatus="vs">
								        		<c:if test="${careerList.cmcd ne '01'}">
								        			<option value="${careerList.cmcdNm}">${careerList.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
								<div class="row">
								        <label for="pjtBgngEstYmd" class="form-label">프로젝트 시작 예상 일자</label>
										<div class="col-auto">
										    <input type="date" id ="pjtBgngEstYmd" name = "pjtBgngEstYmd" class="form-control" >
										</div>
								</div><hr>
								<div class="row">
									<div class="col-8 mb-3">
								        <label for="dutyCd" class="form-label">직무</label>
								        <select id="dutyCd" name = "dutyCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="dutyList" varStatus="vs">
								        		<option value="${dutyList.cmcdNm}">${dutyList.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
								<div class="row">
								        <label for="picTelno" class="form-label">담당자 전화번호</label>
										<div class="col-auto">
										    <input type="tel" id ="picTelno" name = "picTelno" class="form-control" >
										</div>
								</div><hr>																
							    <div class="row">
							        <div class="col-8 mb-1">
							            <p>프로젝트 내용</p>
							            <textarea id="pstCn" name="pstCn" class="form-control" rows="6" placeholder="현재 진행 상황, 주요 담당 업무 , 팀 구성, 기타 전달사항 등"></textarea>
							        </div>
							    </div> <hr>
   
				    <div class="row">
				        <div class="col-6">
				            <div class="input-group mb-3">
				                <div class="form-group clearfix">
				                    <div class="icheck-primary d-inline">
				                        <button type="submit" class="btn btn-success btn-inline">등록하기</button>
				                    </div>
				                    <div class="icheck-primary d-inline">
				                        <button type="submit" class="btn btn-success btn-inline" onclick="javascript:history.back()">뒤로가기</button>
				                    </div>
				                    <div class="icheck-primary d-inline">
				                        <button type="button" id="btnAuto" class="btn btn-success btn-inline">자동완성</button>
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
<script>
$(function(){
	$("#btnAuto").on("click",function(){
		/* $("#q1").prop("checked", true);
		$("#q4").prop("checked", true);
		$("#q8").prop("checked", true);
		$("#q12").prop("checked", true);
		$("#q15").prop("checked", true);
		$("#q19").prop("checked", true);
		$("#q22").prop("checked", true);
		$("#q25").prop("checked", true);
		$("#entrvPstCn").val("복지가 정말 좋아요 굿"); */
		
		$("#pjtNm").val("테스트 프로젝트");
		$("#estPrd").val("예상기간");
		$("#estSalary").val("건당 300");
		$("#workWay").val("원격");
		$("#pjtBgngEstYmd").val("2024-01-15");
		$("#picTelno").val("01012345678");
		$("#pstCn").val("테스트 내용");
		
		
	})
})
</script>
