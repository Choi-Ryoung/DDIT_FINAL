<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>

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
						        <nav>
						          <div class="nav nav-tabs" id="nav-tab" role="tablist">
						            <button class="nav-link " data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">회원 정보</button>
						            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">멘토링 정보</button>
						            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">지원 내역</button>
						            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업 제안</button>
						            <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">나의 통계</button>
						            <button class="nav-link active"  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true">이력서 관리</button>
						          </div>
						        </nav>
						     </div>
						</div> 
						<div class="row">
						    <div class="col-md-12">
						        <div class="card card-outline card-danger mt-4">
						            <div class="p-2 p-md-5 text-white rounded bg-custom">
						                <div class="col-md-12 px-0">
						                    <h1 class="display-5 fst-bold">이력 관리</h1><br>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
						<div class="card-body">
							<div class="row align-items-center" id ="acbgDiv">
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">학력</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" id="addAcbgBtn" onclick="addAcbgForm()">추가</a></span>
								</div>				
							</div><hr>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<script>
							function addAcbgForm() {
							    // 새로운 입력 폼 생성
							    var inputForm = document.createElement("div");
							   
							    inputForm.innerHTML = 
								  `
									<hr>
							    	<div class="container">
							    	  <div class="row">
							    	    <div class="col-4"><input class="form-control" type="text" name="acbgDtl"		placeholder ="학교명"></div>
							    	    <div class="col-2"><input class="form-control" type="date" name="mtcltnYmd"	placeholder ="입학일자"></div>
							    	    <div class="col-2"><input class="form-control" type="date" name="grdtnYmd"	placeholder ="졸업일자"></div>
							    	    <div class="col-2"><input class="form-control" type="text" name="grdtnYn"		placeholder ="졸업구분"></div>
							    	    <div class="col-2 text-end">
									      	<button type="submit" id="acbgCancleBtn" class="btn btn-secondary btn-inline">취소</button>
									      	<button type="submit" id="acbgSaveBtn" class="btn btn-secondary btn-inline">저장</button>
							    	    </div>
									  </div>
							    	</div>
								  `;
							    // 프로젝트 경력 부분에 새로운 입력 폼 추가
							    document.getElementById("acbgDiv").appendChild(inputForm);
							    document.querySelector("#addAcbgBtn").style.visibility = "hidden";
							}
							</script>	
							<!-- 저장 / 취소 이벤트 -->
							<script>
							$(function(){
								
								$(document).on('click','#acbgSaveBtn',function()	{
									
									if(confirm("저장하시겠습니까?"))
										{
											var formData = 
											{
										        
											};
									
										        // JavaScript 객체를 JSON 문자열로 변환
										        var jsonData = JSON.stringify(formData);
									
										        $.ajax({
										            type: "POST",
										            url: "/member/mypage/saveAcbg",
										            contentType: "application/json; charset=utf-8",
										            dataType: "json",
										            data: jsonData,  // JSON 문자열을 전송
										            success: function (response) {
										               if(response == "OK")
										            	   {
										            	   		alert("성공적으로 저장되었습니다");
										            	   		document.querySelector("#addAcbgBtn").style.visibility = "visible";
										            	   }
										            },
										            error: function (error) {
										              
										            }
										        });
										        
										     
										        
										}
								})
							
								
							})
							</script>
							
							
							
													
							<div class="row align-items-center">
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">경력</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" href="#">추가</a></span>
								</div>				
							</div><hr>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<div class="row align-items-center" id="pcDiv">
							    <div class="col-md-11">
							        <span class="lead col-md-9 mx-2 text-black">프로젝트 경력</span>
							    </div>
							    <div class="col-md-1">
							        <span><a class="btn btn-primary" href="#" onclick="addPcForm()">추가</a></span>
							    </div>
							</div>
							<hr>
							<script>
							function addPcForm() {
							    // 새로운 입력 폼 생성
							    var pcForm = document.createElement("div");
							   
							    pcForm.innerHTML = 
								    `
								    	<hr>
										<div class="container text-center mt-3 mb-3">
										<div class="row row-cols-2 m-3">
											<div class="col mt-2 mb-2"><input class="form-control" type="text" name="pjNm"			placeholder ="프로젝트 명"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="ordererNm" 	placeholder ="발주처 명"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="orderBgngYmd"	placeholder ="프로젝트 시작 일자"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="orderEndYmd"	placeholder ="프로젝트 종료 일자"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="mainTask"		placeholder ="주요 업무"></div>
										    <div class="col mt-2 mb-2">
											    <div class="text-end">
											      	<button type="submit" id="pcCancle" class="btn btn-secondary btn-inline">취소</button>
											      	<button type="submit" id="pcSave" class="btn btn-secondary btn-inline">저장</button>
											  	</div>
										  	</div>
										  </div>
										</div>	   
								  `;
							    // 프로젝트 경력 부분에 새로운 입력 폼 추가
							    document.getElementById("pcDiv").appendChild(pcForm);
							}
							</script>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<div class="row align-items-center" id="siDiv">
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">자기소개서</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" href="#" onclick="addSiForm()">추가</a></span>
								</div>				
							</div><hr>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<script>
							function addSiForm() {
							    // 새로운 입력 폼 생성
							    var siForm = document.createElement("div");
							   
							    siForm.innerHTML = 
								    `
								    	<hr>
										<div class="container text-center mt-3 mb-3">
										<div class="row m-3">
											<div class="col mt-2 mb-2"><input class="form-control" type="text" placeholder ="자기소개서 제목"></div>
										</div>
										<div class="row m-3">
											<div class="col mt-2 mb-2"><textarea class="form-control" rows="10">자기소개서 내용</textarea>
										</div>
										<div>
											
										</div>
										    <div class="col mt-2 mb-2">
											    <div class="text-end">
											      	<button type="submit" class="btn btn-secondary btn-inline">취소</button>
											      	<button type="submit" class="btn btn-secondary btn-inline">저장</button>
											      	<button type="submit" class="btn btn-secondary btn-inline">자동완성</button>
											  	</div>
										  	</div>
										  </div>
										</div>	   
								  `;
							
							    // 프로젝트 경력 부분에 새로운 입력 폼 추가
							    document.getElementById("siDiv").appendChild(siForm);
							}
							</script>							
							<div class="row align-items-center" id = "pDiv" >
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">취업 우대사항</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" href="#" onclick="addpForm()">추가</a></span>
								</div>				
							</div><hr>
							<script>
							function addpForm() {
							    // 새로운 입력 폼 생성
							    let InputForm = document.createElement("div");
							   
							    InputForm.innerHTML = 
								    `
								    <hr>
										<div class="container text-center ">
											  <div class="row align-items-center mb-2">
												    <div class="col">
												   		 병역 여부
												    </div>
												    <div class="col">
												    </div>
												    <div class="col">
												    	<button type="submit" class="btn btn-outline-success mr-3">Y</button>
								      					<button type="submit" class="btn btn-outline-success mr-3">N</button>
												    </div>
											  </div>
										</div>
										<div class="container text-center ">
											  <div class="row align-items-center mb-2">
												    <div class="col">
												   		 결혼 여부
												    </div>
												    <div class="col">
												    </div>
												    <div class="col">
												    	<button type="submit" class="btn btn-outline-success mr-2">Y</button>
								      					<button type="submit" class="btn btn-outline-success mr-2">N</button>
												    </div>
											  </div>
										</div>
										<div class="container text-center">
										  <div class="row align-items-center mb-2">
											    <div class="col">
											   		장애 여부
											    </div>
											    <div class="col">
											    </div>
											    <div class="col">
											    	<button type="submit" class="btn btn-outline-success mr-2">Y</button>
							      					<button type="submit" class="btn btn-outline-success mr-2">N</button>
											    </div>
										  </div>
										</div>
										<div class="container text-center">
										  <div class="row align-items-center">
											    <div class="col">
											   		보훈대상
											    </div>
											    <div class="col">
											    </div>
											    <div class="col">
											    	<button type="submit" class="btn btn-outline-success mr-2">Y</button>
							      					<button type="submit" class="btn btn-outline-success mr-2">N</button>
											    </div>
										  </div>
										</div>
										
										
								  `;
							
							    // 프로젝트 경력 부분에 새로운 입력 폼 추가
							    document.getElementById("pDiv").appendChild(InputForm);
							}
							</script>	
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<div class="row align-items-center">
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">연수</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" href="#">추가</a></span>
								</div>				
							</div><hr>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							<div class="row align-items-center">
								<div class="col-md-11">
								 <span class="lead col-md-9 mx-2 text-black">자격증</span>
								</div>
								<div class="col-md-1">
								 <span><a class="btn btn-primary" href="#">추가</a></span>
								</div>				
							</div><hr>
							<div class="row">
							  <div class="col-md-12">
							    <p>등록된 내용이 없습니다.</p>
							  </div>
							</div><hr>
							
						    <div class="row">
								<div class="fixed-bottom col-md-12">
									<button type="submit" class="btn btn-outline-success mr-2">이력서 등록하기</button>
								</div>
						    </div>	
						</div>

	      </div>
	    </div>
	 </div>  
<script>
$(function(){
	
	$(document).on('click','#pcSave',function()	{
		
		if(confirm("저장하시겠습니까?"))
			{
				var formData = {
			            pjNm: $("input[name='pjNm']").val(),
			            ordererNm: $("input[name='ordererNm']").val(),
			            orderBgngYmd: $("input[name='orderBgngYmd']").val(),
			            orderEndYmd: $("input[name='orderEndYmd']").val(),
			            mainTask: $("input[name='mainTask']").val(),
			        };
		
			        // JavaScript 객체를 JSON 문자열로 변환
			        var jsonData = JSON.stringify(formData);
		
			        $.ajax({
			            type: "POST",
			            url: "/member/mypage/savePc",
			            contentType: "application/json; charset=utf-8",
			            dataType: "json",
			            data: jsonData,  // JSON 문자열을 전송
			            success: function (response) {
			               if(response == "OK")
			            	   {
			            	   		alert("성공적으로 저장되었습니다");
			            	   }
			            },
			            error: function (error) {
			              
			            }
			        });
			        
			        
			}
	})

	
})
</script>

  