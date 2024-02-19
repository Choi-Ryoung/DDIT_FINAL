<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
<script src="https://rawgit.com/eKoopmans/html2pdf/master/dist/html2pdf.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>

<style>
		/* 메뉴 배경 색상 */
		.bg-custom {
		    background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
		    border : 0;
		}  
    /* 체크박스 크기를 조절하는 사용자 정의 스타일 */
    .custom-checkbox .form-check-input {
      width: 1.5em;
      height: 1.5em;
    }

.custom-hr
{
    margin: 0.4rem 0;
    color: black;
    background-color: currentColor;
    
    opacity: 0.5;
    heigth :2px;
}

.title-hr
{
	border: 2px solid;
	color: cornflowerblue;
}

.modal-dialog
{
	max-width : 1200px;
}

</style>
 
    <div id="sh_container"> 
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <div id="greeting" class="pagecommon">
	                	<!-- 아래로 콘텐츠 추가  -->
		                	<div class="row">
							    <div class="col-md-12">
							        <div class="card card-outline card-danger mt-4">
							                <div class="col-md-12 px-0">
							                    <img src="${ctxp}/resources/img/main/menu_banner/나의이력서.jpg" width="1100px" height="300px">
							                </div>
							                <input class="form-control" type="hidden" name="resNo" value = "${resNo}" placeholder ="이력서 번호">
							        </div>
							    </div>
							</div><br>
						    <nav>
						      <div class="nav nav-tabs" id="nav-tab" role="tablist">
						        <button class="nav-link " data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">회원 정보</button>
						        <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">멘토링 정보</button>
						        <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">프리랜서 정보</button>
						        <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">지원 내역</button>
						        <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업 제안</button>
						        <button class="nav-link "  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">나의 통계</button>
						        <button class="nav-link active"  data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서 관리</button>
						      </div>
						    </nav>
						

					
					<div class="copyDiv">
							<div class="row align-items-center formDiv mt-2 mb-3 px-2" id="iDiv">
							    <span class="col-md-2 text-black fs-4">이력서</span>
							    <div class="col-md-2 text-end">
							        <button type="button" class="btn btn-primary bg-custom btn-inline btnAuto">자동완성</button>
							        <button type="button" class="btn btn-primary bg-custom btn-inline btnSaveAuto">자동저장</button>
							    </div>
							    <div class="col-md-4 text-end">
							        <button type="button" id="saveImg" class="btn btn-outline-primary mr-2">이미지 저장</button>
							        <button type="button" id="savePdf" class="btn btn-outline-primary">PDF 저장</button>
							    </div>
							</div>
							<hr class="custom-hr title-hr">
				
							<div class="row align-items-center">
								    <div class="col-sm-3 text-center">
								        <img class="img-fluid profile-image-pic img-thumbnail my-3" id="provImg" src="${ctxp}/resources/img/resume/profile.png" alt="profile" style="width: 210px; height: 280px;">
								        <input type="file" class="form-control provImgFile" name=provImgFile id="provImgFile"> 
								    </div>
								    <div class="col-sm-9">
								                <div class="col mt-2 mb-2 text-black fs-6">이름 : ${mVo.prMbrNm}</div><hr class="custom-hr">
								                <div class="col mt-2 mb-2 text-black fs-6">연락처 :  ${fn:substring(mVo.prMbrTelno, 0, 3)}-${fn:substring(mVo.prMbrTelno, 3, 7)}-${fn:substring(mVo.prMbrTelno, 7, 11)}</div><hr class="custom-hr">
								                <div class="col mt-2 mb-2 text-black fs-6">이메일 : ${mVo.prMbrEmail}</div><hr class="custom-hr">
								                <div class="col mt-2 mb-2 text-black fs-6">생년월일 : ${mVo.prMbrBirthdy}</div><hr class="custom-hr">
								                <div class="col mt-2 mb-2 text-black fs-6">성별 : 
								                <c:if test="${mVo.sexdstnCd eq 'M'}">남성</c:if>
								                <c:if test="${mVo.sexdstnCd eq 'F'}">여성</c:if>
								                </div><hr class="custom-hr">
								                <div class="col mt-2 mb-2 text-black fs-6">주소 : ${mVo.prMbrBscAddr}  ${mVo.prMbrDaddr} </div><hr class="custom-hr">
								    </div>
							</div><br>
							
							<div class="row align-items-center formDiv " id ="acbgDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 text-black fs-5">학력</span>
								</div>
								<div class="col-md-1 align-items-center">
								        <a class="addBtn" href="javascript:void(0);" onclick="addForm('#acbgDiv',acbgInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가									 
								        </a>
								</div>
							</div><br>
							
							<div class="row align-items-center formDiv" id="cDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 mb-2 text-black fs-5">경력</span>
								</div>
								<div class="col-md-1">
									 <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#cDiv',cInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가									 
									 </a></span>
								</div>				
							</div><br>
							
							<div class="row align-items-center formDiv" id="pcDiv">
							    <div class="col-md-11">
							        <span class="col-md-9 mx-2 text-black fs-5">프로젝트 경력</span>
							    </div>
							    <div class="col-md-1">
							        <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#pcDiv',pcInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가		
									</a></span>
							    </div>
							</div><br>
							
							<div class="row align-items-center formDiv" id = "pDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 text-black fs-5">취업 우대사항</span>
								</div>
								<div class="col-md-1">
								 <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#pDiv',pInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가		
								</a></span>
								</div>				
							</div><br>

							<div class="row align-items-center formDiv" id = "satDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 text-black fs-5">연수</span>
								</div>
								<div class="col-md-1">
									 <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#satDiv',satInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가										 
									 </a></span>
								</div>				
							</div><br>
							
							<div class="row align-items-center formDiv" id = "crtDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 text-black fs-5">자격증</span>
								</div>
								<div class="col-md-1">
								 <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#crtDiv',crtInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가									 
								 </a></span>
								</div>
							</div><br>

							<div class="row align-items-center formDiv" id = "siDiv">
								<div class="col-md-11">
								 <span class="col-md-9 mx-2 text-black fs-5">자기소개서</span>
								</div>
								<div class="col-md-1">
								 <span><a class="addBtn" href="javascript:void(0);"  onclick="addForm('#siDiv',siInputForm)">
								            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus-lg" viewBox="0 1 16 16">
								                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
								            </svg> 추가									 
								 </a></span>
								</div>
							</div><br>				
							
					</div>
						    <div class="row align-items-center">
								<div class="col-md-9 text-end">
								 <input class="form-control" id = "resTtl" type="text" name="resTtl" placeholder ="이력서 제목(미입력 시 기본 제목으로 자동 저장 됩니다.)">
								</div>
								<div class="col-md-3 text-end">
								 	<button type="button" id="modResBtn"class="btn btn-outline-primary mr-2">이력서 수정하기</button>
									<button type="button" id="previewRes" class="btn btn-outline-primary mr-2" >이력서 미리보기</button>
								</div>				
							</div>
					</div>	
				</div>			
		      </div>
		    </div>
 			


<div class="modal fade" id="resumeModal" tabindex="-1" aria-labelledby="resumeModal" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body resume-cont">
		
      </div>
    </div>
  </div>
</div>



  
<script>



$(function() {
	
	fn_getDetailData();
	
    $("#resumeModal").each(function(){
        // 요소의 배경색을 흰색으로 설정
        $(this).css({
            "background-color": "white",
        });
    });
    $("#savePdf").hide();
    $("#saveImg").hide();
	

});


//------------------- 이미지로 저장 버튼 클릭 -------------------

$(document).on('click','#saveImg',function()	
		  {
		    // 모달의 내용이 표시된 후에 실행되도록 setTimeout 사용
		    setTimeout(function () {
		    	
		    	$("#resumeModal #savePdf").hide();
				$("#resumeModal #saveImg").hide();
		    	
		        // 캔버스 생성 시 배경색을 투명하게 설정하고 이미지로 변환
		        html2canvas(document.querySelector("#resumeModal .modal-content"), { 
		            scale: 1, 
		        }).then(function (canvas) {
		            // 캔버스 데이터를 이미지로 변환하고 다운로드 링크 생성
		            var link = document.createElement('a');
		            link.href = canvas.toDataURL("image/jpeg", 1.0);

		            // 텍스트 색상이 변경되지 않도록 스타일을 명시적으로 지정
		            link.style.color = "black";
		            link.download = '이력서.jpg';
		            
		            // 다운로드 링크 클릭하여 이미지 저장
		            link.click();
		            
		        });
		    	$("#resumeModal #savePdf").show();
				$("#resumeModal #saveImg").show();
		        
		        // 모달의 내용 초기화
		        //$('#optionalConsentModal .modal-body').html('');
		    }, 300); // 500ms 후에 실행 (숫자는 필요에 따라 조절 가능)
		    
		});	


//------------------- pdf로 저장 버튼 -------------------
$(document).on('click','#savePdf',function()
	    { // pdf저장 button id
	        setTimeout(function() {
	        	
				$("#resumeModal #savePdf").hide();
				$("#resumeModal #saveImg").hide();
		    	
	        	html2canvas($('#resumeModal .modal-content')[0]).then(function(canvas) { //저장 영역 div id
	        		
	        	    // 캔버스를 이미지로 변환
	        	    var imgData = canvas.toDataURL('image/png', 1.0);
	        		     
	        	    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
	        	    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	        	    var imgHeight = canvas.height * imgWidth / canvas.width;
	        	    var heightLeft = imgHeight;
	        	    var margin = 10; // 출력 페이지 여백설정
	        	    var doc = new jsPDF('p', 'mm');
	        	    var position = 10;
	        	       
	        	    // 첫 페이지 출력
	        	    doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	        	    heightLeft -= pageHeight;
	        	         
	        	    // 한 페이지 이상일 경우 루프 돌면서 출력
	        	    while (heightLeft >= 20) {
	        	        position = heightLeft - imgHeight;
	        	        doc.addPage();
	        	        doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	        	        heightLeft -= pageHeight;
	        	    }
	        	 
	        	    // 파일 저장
	        	    doc.save('이력서.pdf');
	        	    
	        	});
		    	$("#resumeModal #savePdf").show();
				$("#resumeModal #saveImg").show();
	          
	        }, 300);
	    });


//------------------- 이력서 미리보기가 감춰질 때 -------------------
$("#resumeModal").on("hidden.bs.modal", function () {
	
	   //요소 다시 표시
	 $('.btnAuto').show();
	 $('.btnSaveAuto').show();
	 
	 $('.addBtn').each(function(){
	 	$(this).show();
	 })
	 $('.removeDataListBtn').each(function(){
	 	$(this).show();
	 })
	 
	$("#savePdf").hide();
	$("#saveImg").hide();
	 
});



//------------------- 이력서 미리보기 -------------------	
$("#previewRes").on("click",function(){
	// 저장 버튼 표시
	$("#savePdf").show();
  $("#saveImg").show();
  
  var copyContent = document.querySelector('.copyDiv').innerHTML;

  // 모달에 copyDiv의 HTML을 추가
  $('.resume-cont').html(copyContent);
  
  //이력서 저장위해 요소 숨김
  $('.btnAuto').hide();
  $('.btnSaveAuto').hide();
  
  $('.addBtn').each(function(){
  	$(this).hide();
  })
  
  $('.removeDataListBtn').each(function(){
  	$(this).hide();
  })

  // 모달을 보여줌
  $("#resumeModal").modal("show");
  $('#resumeModal .provImgFile').hide();
})
		

//------------------- 프로필 이미지 관련  -------------------
	var file;
	var provImgFile = $("#provImgFile");	
	provImgFile.on("change", function(event){
		file = event.target.files[0];
		console.log("이미지 변환 후 파일 : " + file);
		if(isImageFile(file)){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#provImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
			console.log("file : " + file);
			//file 전역
			
		}else{	// 이미지 파일이 아닐때
			alert("이미지 파일을 선택해주세요!");
		}
	});
		
	// 이미지 파일인지 체크
	function isImageFile(file){
		var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 가져옵니다.
		return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
	}	

	
	//------------------- 자동완성  -------------------
	$(".btnAuto").on("click",function(){
			$("#siDiv .addBtn").click();
			
			$("select[name='siTtl']").val("03");
			$("textarea[name='siCn']").val(`
항상 대내외적으로 자기 관리를 꼼꼼히 하라는 아버지의 말을 들으며, 
서투르거나 실수를 저지를 수 있는 학창 시절에도 엄격한 이성을 유지하기 위해 애썼던 시절이었습니다. 
친구들은 지나치게 단호한 기준에 매인 제가 가엾어 보인다며 동정하기도 했지만, 
저는 이미 지각이나 사소한 실수 등을 배제하는 확고한 자기 관리에 익숙해진 타입이었기 때문에, 
빈틈없는 성실함으로 어른들의 호의를 살 수 있었습니다.
가끔 친구들에게 ‘사이보그 인간 같다’는 말을 들을 때는 조금 고민이 되기도 했지만, 
그런 사이보그 같은 철혈의 삶을 평생에 걸쳐 유지하신 아버지의 존재는 제가 존경할 만한 엄청난 존재감을 가지고 계셨기에, 
저 또한 그 등을 닮고 싶다는 마음으로 차분히 노력할 수 있었던 것입니다. 
그러나 친구들은 안 그래도 사회에 나가면 제약이 많을 텐데 벌써부터 이런 굴레에 묶여 있는 것은 좋지 않다면서, 
저를 여러모로 자유롭게 하기 위한 일탈의 시도를 도와주기도 했습니다. 
그 당시에는 아버지처럼 되지 못할까봐 난처한 기억뿐이었지만, 
저를 위해 어떤 손해도 감수해주는 귀중한 친구들의 도움과 우정을 느낄 수 있어 즐거운 시간이기도 했습니다. 
또한 저는 단단히 고삐를 죄는 생활이 당연한 아이었지만, 
저와 분위기가 다른 다양한 집안 풍토를 가진 친구들과 어울리며 저의 제한된 시야를 훨씬 확장시키는 계기를 얻기도 했습니다.
					`);
			
	})	
	
	
	//------------------- 자동 저장  -------------------
	$(".btnSaveAuto").on("click",function(){
		$(".saveBtn").click();
	})
	
	
	

//---------------------------기존 이력(카드) 제거 버튼-------------------------
	
	var cList = [];
	var acbgList = [];
	var pcList = [];
	var pList = [];
	var crtList = [];
	var satList = [];
	var siList = [];
	var resTtl = "";
	var resumeRprsYn =""; 
	var resNo = ${resNo};
	
	function fn_getDetailData()
	{
		
		$.ajax({
            type: "GET",
            url: "${ctxp}/member/mypage/resumeDetailData?resNo=" + resNo,
            //contentType: 'application/json',
            data: null,
            success: function(response) 
            {
            	   cList = response.careerList;
            	   acbgList = response.acdbgList;
            	   pcList = response.pjCareerList;
            	   pList = response.prefList;
            	   crtList = response.certifList;
            	   satList = response.stdatList;
            	   siList = response.selfintList;
            	   resTtl = response.resTtl;
            	   resumeRprsYn = response.rprsvResYn;
            	   provPhoto = response.provPhoto;
            	   
	            	showDataList(cList,"cDiv");
	       		    showDataList(acbgList,"acbgDiv");
	       		    showDataList(pcList,"pcDiv");
	       		    showDataList(pList,"pDiv");
	       		    showDataList(crtList,"crtDiv");
	       		    showDataList(satList,"satDiv");
	       		 	showDataList(siList,"siDiv");
	       		 	
		       		 if (resumeRprsYn == 'Y') 
		       		{
		       		    // $("input[name='rprsvResYn']")로 해당 요소를 선택하고, .val('Y')로 값을 'Y'로 설정한다.
		       		    $("input[name='rprsvResYn']").val('Y');
		       		}
		       		 else if (resumeRprsYn == 'N') 
		       		{
		       			$("input[name='rprsvResYn']").val('N');
		       		}
		       		 
		       		if(provPhoto != "")
		       		{
		       			$("#provImg").attr("src",provPhoto);
		       		}
		       		
		       		$("#resTtl").val(resTtl);
            	   
            }
        });
		
	}
	
	$("#modResBtn").on('click',function()
	{
		if(confirm("수정하시겠습니까?"))
		{
/* 			if(cList.length == 0 || acbgList.length == 0 || pcList.length == 0 || 
					pList.length == 0 || crtList.length == 0 || satList.length == 0 || siList.length == 0)
			{
				alert("내용을 추가해주세요");
				return;
			}
			 */
			if (file == null || typeof file === "undefined" || file.length <= 0) {
			    alert("사진을 추가해주세요");
			    return;
			}

			
			// 제목 없을 경우
			var resumeTtl = $("#resTtl").val();
			if(resumeTtl === undefined || resumeTtl == "")
			{
				resumeTtl = "제목없음";
			}
			
			var resumeNo = ${resNo};
			
			var resumeRprsYn = $("input[name='rprsvResYn']:checked").val();
			
			//경력 리스트에 값이 없으면 신입 아니면 경력
			let careerChk ="";
	        if (cList == null) {
	        	careerChk = "01";
	        } else {
	            // 배열이 존재하면 길이 체크
	            if (cList.length > 0) 
	            {
	            	careerChk = "02"
	            }
	            else {
	            	careerChk = "01";
	            }
	        }
			
	        var listData = {
	        		careerList: cList,
	        		acdbgList: acbgList,
	        		pjCareerList: pcList,
	        		prefList: pList,
	        		certifList: crtList,
	        		stdatList: satList,
	        		selfintList : siList,
	        		resNo : resumeNo,
	        		resTtl : resumeTtl,
	        		rprsvResYn : resumeRprsYn,
	        		careerCd : careerChk
	        		
	            };
	        
			var formData = new FormData();
	        formData.append('file', file);
	        formData.append("listData",new Blob([JSON.stringify(listData)],{type:"application/json;charset=utf-8"}));
	        
	        $.ajax({
	            type: "POST",
	            url: "${ctxp}/member/mypage/resumeUpdate.do",
	            contentType: false,
	            processData: false,
	            data: formData,
	            success: function(response) 
	            {
	            	
	            	   if (response === "OK") 
	            	   {
	                      	alert("수정 되었습니다");
	                      	location.href='${ctxp}/member/mypage/resumeList';
	                    	return;
	                   } 
	            }
	        });

		}
	})	

	

//------------------- 이력 데이터 조회  -------------------
$(document).on('click','.selDataList',function()	
{
	// 요소 선택 : cDiv 
	let formDiv = $(this).closest('.formDiv');
	
	// 아이디 : cDiv 
	formDivId = formDiv.attr('id');
	
	let inputForm;
	let list;
	
	if(formDivId == 'cDiv'){	inputForm = cInputForm;	list = cList; }
	else if(formDivId == 'acbgDiv'){	inputForm = acbgInputForm;	list = acbgList; }
	else if(formDivId == 'pcDiv'){	inputForm = pcInputForm;	list = pcList; }
	else if(formDivId == 'pDiv'){	inputForm = pInputForm;	list = pList; }
	else if(formDivId == 'satDiv'){	inputForm = satInputForm;	list = satList; }
	else if(formDivId == 'crtDiv'){	inputForm = crtInputForm;	list = crtList; }
	else if(formDivId == 'siDiv'){	inputForm = siInputForm;	list = siList; }
	
	// 선택 한 버튼에서 가장 가까운 카드 클래스 선택
			var dataList = $(this).closest('.data-list');
			dataIndex = dataList.attr('data-index'); // .attr() 메서드 사용

			// form 구분 id ex) #cDivForm
			let formId = "#" + formDivId + "Form";
			console.log("formId" + formId);
			
			//데이터 가져오기
			showDataList(list,formDivId);
			
			// 버튼 수정으로 변경
	
			//입력 폼 없으면 추가
			if($(formId).length == 0)
			{
				addForm("#" + formDivId,inputForm);
			}
			
			//있으면 삭제 후 추가 .입력창 제일 아래에 출력되게 하기위함
			else
			{
				$(formId).remove();
				addForm("#" + formDivId,inputForm);
			}
			let saveBtn = formDiv.find('.saveBtn');
			saveBtn.addClass('modifyBtn');
			saveBtn.removeClass('saveBtn');
			saveBtn.text("수정");
			modifyDataInput(formDivId,dataIndex,list);
			
})	

	
//------------------- 이력 데이터 삭제 버튼  -------------------	
$(document).on('click','.removeDataListBtn',function()	
{
	let formDiv = $(this).closest('.formDiv');
	// cDiv
	formDivId = formDiv.attr('id');
	
	let addFormDiv = $(this).closest('.addForm').parent();
	
	// form 구분 id ex) #cDivForm
	let formId = addFormDiv.attr('id');
	
	if(confirm("삭제하시겠습니까?"))
		{
			// 선택 한 버튼에서 가장 가까운 카드 클래스 선택
			var dataList = $(this).closest('.data-list');
			dataIndex = dataList.attr('data-index'); // .attr() 메서드 사용

			
			let list;
			// 선택한 리스트의 인덱스를 이용하여 list에서 해당 항목 제거
			if(formDivId == 'cDiv'){	list = cList;	}
			else if(formDivId == 'acbgDiv'){	list = acbgList;	}
			else if(formDivId == 'pcDiv'){	list = pcList;	}
			else if(formDivId == 'pDiv'){	list = pList;	}
			else if(formDivId == 'crtDiv'){	list = crtList;	}
			else if(formDivId == 'satDiv'){	list = satList;	}
			else if(formDivId == 'siDiv'){	list = siList;	}

			console.log("카드 삭제 할 div 위치 : " + formDivId);
			
			list.splice(dataIndex, 1);
			
			list.sort();
			// 카드 제거
			dataList.remove();
			showDataList(list,formDivId);
			
			if(list === undefined)
			{
					console.log("list length:" + 0 + " or undefined");
			}
			else
			{
					console.log("list length:" + list.length);	
			}
			
		}
	
})
	
	//---------------------------폼 등록 취소 -------------------------
	$(document).on('click','.cancleBtn',function()	{
		
		let formDiv = $(this).parents('.formDiv');
		
		let formDivId = formDiv.attr('id');
		
		//데이터 리스트 숨김
		$("#" + formDivId).find(".showDataDiv").show();
		
		console.log(".cancleBtn() formDivId : " + formDivId);
		
		//버튼 복구
		formDiv.find('.addBtn').css('visibility', 'visible');
		
		//입력폼 지우기
		$(this).closest('.addForm').parent().remove();
	})	
	
//---------------------------폼 데이터 저장-------------------------
$(document).on('click','.saveBtn',function()	
{
	console.log(".saveBtn()");
	
	//추가 버튼있는 바깥쪽 form
	let formDiv = $(this).parents('.formDiv');
	// ex) cDiv
	let formDivId = formDiv.attr('id');
	
	//추가된 입력 폼
	let addFormId = formDivId + "Form";
	
	//cDivForm
	let addFormDiv = $(this).parents("#" + addFormId);
	
	// form 구분 id ex) #cDivForm
	let addFormDivId = addFormDiv.attr('id');
	
	console.log("formDivId : " + formDivId);
	console.log("addFormDivId : " + addFormDivId);
		
		//폼 데이터 로드
		if(addFormDivId == "acbgDivForm")
		{
			let acbgVo = 
			{
				acbgNo: $("input[name='acbgNo']").val(),
				resNo: $("input[name='resNo']").val(),
				acbgDtl: $("input[name='acbgDtl']").val(),
				mtcltnYmd: $("input[name='mtcltnYmd']").val(),
				grdtnYmd: $("input[name='grdtnYmd']").val(),
				grdtnYn: $("select[name='grdtnYn']").find(":selected").val()
			};
			if(acbgVo.grdtnYn =='졸업구분')
			{
				alert("졸업구분을 선택하세요");
				return;
			}

			acbgList.push(acbgVo);
			console.log("acbgList length:" +acbgList.length);
		}		
		
		else if(addFormDivId == "cDivForm")
			{
				let careerVo = 
				{
					resNo: $("input[name='resNo']").val(),
					coNm: $("input[name='coNm']").val(),
					jobPosNm: $("input[name='jobPosNm']").val(),
					serveYn: $("select[name='serveYn']").find(":selected").val(),
					workBgngYmd: $("input[name='workBgngYmd']").val(),
					workEndYmd: $("input[name='workEndYmd']").val(),
					assignTaskCn: $("textarea[name='assignTaskCn']").val(),
					salary: $("input[name='salary']").val(),
					workDeptNm: $("input[name='workDeptNm']").val(),
				};
				if(careerVo.serveYn =='재직여부*')
				{
					alert("재직여부를 선택하세요");
					return;
				}

				cList.push(careerVo);
				console.log("cList length:" +cList.length);

			}
		
		else if(addFormDivId == "pcDivForm")
		{
			let pcVo = 
			{
				ordererNm: $("input[name='ordererNm']").val(),
				pjNm: $("input[name='pjNm']").val(),
				orderBgngYmd: $("input[name='orderBgngYmd']").val(),
				orderEndYmd: $("input[name='orderEndYmd']").val(),
				mainTask: $("textarea[name='mainTask']").val(),
			};

			pcList.push(pcVo);
			console.log("pcList length:" +pcList.length);
		}
		
		// 취업 특이 사항
		else if(addFormDivId == "pDivForm")
		{
			let pVo = 
			{
				milYn: $("input[name='milYn']:checked").val(),
				marYn: $("input[name='marYn']:checked").val(),
				disYn: $("input[name='disYn']:checked").val(),
				ntnMrtYn: $("input[name='ntnMrtYn']:checked").val(),
				ntnSprtYn: $("input[name='ntnSprtYn']:checked").val(),
			};

			pList.push(pVo);
			
			console.log("pList length:" +pList.length);
		}
		
		else if(addFormDivId == "satDivForm")
		{
			let satVo = 
			{
				sdytrnNm: $("input[name='sdytrnNm']").val(),
				sdytrnBgngYmd: $("input[name='sdytrnBgngYmd']").val(),
				sdytrnEndYmd: $("input[name='sdytrnEndYmd']").val(),
				instNm: $("input[name='instNm']").val(),
			};

			satList.push(satVo);
			console.log("satList length:" + satList.length);
		}
		
		else if(addFormDivId == "crtDivForm")
		{
			let crtVo = 
			{
				qlfcNo: $("input[name='qlfcNo']").val(),
				crtfctNm: $("input[name='crtfctNm']").val(),
				crtfctAcqsYmd: $("input[name='crtfctAcqsYmd']").val(),
				issueInstNm: $("input[name='issueInstNm']").val(),
			};

			crtList.push(crtVo);
			console.log("crtList length:" +crtList.length);
		}
		
		else if(addFormDivId == "siDivForm")
		{
			let sIVo = 
			{
			    siTtl: $("select[name='siTtl']").find(":selected").val(),
				siCn: $("textarea[name='siCn']").val(),
			};
			
			siList.push(sIVo);
			console.log("siList length:" +siList.length);
		}
	
			let list;
			if(addFormDivId == "cDivForm") { list = cList;}
			else if(addFormDivId == "acbgDivForm") { list = acbgList;}
			else if(addFormDivId == "pcDivForm") { list = pcList;}
			else if(addFormDivId == "pDivForm") { list = pList;}
			else if(addFormDivId == "satDivForm") { list = satList;}
			else if(addFormDivId == "crtDivForm") { list = crtList;}
			else if(addFormDivId == "siDivForm") { list = siList;}
			
			console.log("저장 할 FormId : "+addFormDivId);
			
			 // 성공적인 경우
			 formDiv.find('.addBtn').css('visibility', 'visible');
			 showDataList(list,formDivId);
			//입력폼 지우기
			 addFormDiv.remove();
		
	})	
		
//---------------------------폼 데이터 수정-------------------------
$(document).on('click','.modifyBtn',function()	
{

	
	console.log(".modifyBtn()");
	
	//추가 버튼있는 바깥쪽 form
	let formDiv = $(this).parents('.formDiv');
	// ex) cDiv
	let formDivId = formDiv.attr('id');

	
	//추가된 입력 폼
	let addFormId = formDivId + "Form";
	
	//cDivForm
	let addFormDiv = $(this).parents("#" + addFormId);
	
	// form 구분 id ex) #cDivForm
	let addFormDivId = addFormDiv.attr('id');
	
	/* 	let showDataDiv = addFormDiv.siblings("#showDataDiv");
	let dataList = showDataDiv.find('.data-list');
	let dataIndex = dataList.attr('data-index'); // .attr() 메서드 사용 */
	
	console.log(dataIndex);
	console.log("formDivId : " + formDivId);
	console.log("addFormDivId : " + addFormDivId);
	
	//폼 데이터 로드
	
	if(addFormDivId == "acbgDivForm")
	{
		let acbgVo = 
		{
			acbgNo: $("input[name='acbgNo']").val(),
			resNo: $("input[name='resNo']").val(),
			acbgDtl: $("input[name='acbgDtl']").val(),
			mtcltnYmd: $("input[name='mtcltnYmd']").val(),
			grdtnYmd: $("input[name='grdtnYmd']").val(),
			grdtnYn: $("select[name='grdtnYn']").find(":selected").val()
		};
		if(acbgVo.grdtnYn =='졸업구분')
		{
			alert("졸업구분을 선택하세요");
			return;
		}

		acbgList[dataIndex] = acbgVo;
		console.log("acbgList length:" +acbgList.length);
	}		
	
	else if(addFormDivId == "cDivForm")
		{
			let careerVo = 
			{
				resNo: $("input[name='resNo']").val(),
				coNm: $("input[name='coNm']").val(),
				jobPosNm: $("input[name='jobPosNm']").val(),
				serveYn: $("select[name='serveYn']").find(":selected").val(),
				workBgngYmd: $("input[name='workBgngYmd']").val(),
				workEndYmd: $("input[name='workEndYmd']").val(),
				assignTaskCn: $("textarea[name='assignTaskCn']").val(),
				salary: $("input[name='salary']").val(),
				workDeptNm: $("input[name='workDeptNm']").val(),
			};

			cList[dataIndex] = careerVo;
			
			console.log("cList length:" +cList.length);

		}
	
	else if(addFormDivId == "pcDivForm")
	{
		let pcVo = 
		{
			ordererNm: $("input[name='ordererNm']").val(),
			pjNm: $("input[name='pjNm']").val(),
			orderBgngYmd: $("input[name='orderBgngYmd']").val(),
			orderEndYmd: $("input[name='orderEndYmd']").val(),
			mainTask: $("textarea[name='mainTask']").val(),
		};

		pcList[dataIndex] = pcVo;
		
		console.log("pcList length:" +pcList.length);
	}
	
	// 취업 특이 사항
	else if(addFormDivId == "pDivForm")
	{
		let pVo = 
		{
			milYn: $("input[name='milYn']:checked").val(),
			marYn: $("input[name='marYn']:checked").val(),
			disYn: $("input[name='disYn']:checked").val(),
			ntnMrtYn: $("input[name='ntnMrtYn']:checked").val(),
			ntnSprtYn: $("input[name='ntnSprtYn']:checked").val(),
		};

		pList[dataIndex] = pVo;
		
		console.log("pList length:" +pList.length);
	}
	
	else if(addFormDivId == "satDivForm")
	{
		let satVo = 
		{
			sdytrnNm: $("input[name='sdytrnNm']").val(),
			sdytrnBgngYmd: $("input[name='sdytrnBgngYmd']").val(),
			sdytrnEndYmd: $("input[name='sdytrnEndYmd']").val(),
			instNm: $("input[name='instNm']").val(),
		};

		satList[dataIndex] = satVo;
		console.log("satList length:" + satList.length);
	}
	
	else if(addFormDivId == "crtDivForm")
	{
		let crtVo = 
		{
			qlfcNo: $("input[name='qlfcNo']").val(),
			crtfctNm: $("input[name='crtfctNm']").val(),
			crtfctAcqsYmd: $("input[name='crtfctAcqsYmd']").val(),
			issueInstNm: $("input[name='issueInstNm']").val(),
		};

		crtList[dataIndex] = crtVo;
		console.log("crtList length:" +crtList.length);
	}
	
	else if(addFormDivId == "siDivForm")
	{
		let sIVo = 
		{
			siTtl: $("select[name='siTtl']").find(":selected").val(),
			siCn: $("textarea[name='siCn']").val(),
		};

		siList[dataIndex] = sIVo;
		console.log("siList length:" +siList.length);
	}

		let list;
		if(addFormDivId == "cDivForm") { list = cList;}
		else if(addFormDivId == "acbgDivForm") { list = acbgList;}
		else if(addFormDivId == "pcDivForm") { list = pcList;}
		else if(addFormDivId == "pDivForm") { list = pList;}
		else if(addFormDivId == "satDivForm") { list = satList;}
		else if(addFormDivId == "crtDivForm") { list = crtList;}
		else if(addFormDivId == "siDivForm") { list = siList;}
		
		console.log("저장 할 FormId : "+addFormDivId);
		
		 // 성공적인 경우
		 formDiv.find('.addBtn').css('visibility', 'visible');
		 showDataList(list,formDivId);
		//입력폼 지우기
		 addFormDiv.remove();
	
})				
		
		//---------------------------카드 리스트 출력 함수-------------------------
		
		
 function showDataList(list,formDivId) 
{
	 //#cDiv
	var formDivId = "#" + formDivId;
	console.log("showDataList" + formDivId);
	
	var formDiv = $(formDivId);
	var showDataDiv = formDiv.find('.showDataDiv')
	var dataInfo = showDataDiv.find(".dataInfo");
	
	if (showDataDiv.length !== 0) 
	{
		showDataDiv.remove();
	}
		showDataDiv = document.createElement("div");
		showDataDiv.classList.add('showDataDiv');
		console.log("length" + list.length);
	
	if(list.length == 0)
	{
		showDataDiv.innerHTML += 
		`
			<div class="row">
			  <div class="col-md-12 px-4 mt-2">
			    <p>등록된 내용이 없습니다.</p>
			  </div>
			</div>				
		`;
	}
	else
	{
		var dataInfo;
		 if(formDivId == "#acbgDiv") 		{ 	dataInfo = acbgDataInfo; 	}
		 else if(formDivId == "#cDiv")		{ 	dataInfo = cDataInfo; 	}
		 else if(formDivId == "#pcDiv")		{ 	dataInfo = pcDataInfo; 	}
		 else if(formDivId == "#crtDiv")	{ 	dataInfo = crtDataInfo; 	}
		 else if(formDivId == "#satDiv")	{ 	dataInfo = satDataInfo; 	}
		 else if(formDivId == "#pDiv")		{ 	dataInfo = pDataInfo; 	}
		 else if(formDivId == "#siDiv")		{ 	dataInfo = siDataInfo; 	}
		//DataList에 추가할 데이터 HTML 반환
		var dataResult = retDataResult(formDivId,list,dataInfo);
		//console.log(dataResult);
		showDataDiv.innerHTML += dataResult;
	}
	// 저장 경력 출력
	formDiv.append(showDataDiv);
} 
				

// 수정할 데이터 불러오기
function modifyDataInput(formDivId,dataIndex,list)
{
	console.log("modifyDataInput()");
	console.log("formDivId : " + formDivId);
	console.log("dataIndex : " + dataIndex);
	
	if(formDivId == 'cDiv')
	{	
		cVo = list[dataIndex];
		$("input[name='resNo']").val(cVo.resNo);
		$("input[name='coNm']").val(cVo.coNm);
		$("input[name='jobPosNm']").val(cVo.jobPosNm);
		$("select[name='serveYn']").val(cVo.serveYn);
		$("input[name='workBgngYmd']").val(cVo.workBgngYmd);
		$("input[name='workEndYmd']").val(cVo.workEndYmd);
		$("textarea[name='assignTaskCn']").val(cVo.assignTaskCn);
		$("input[name='salary']").val(cVo.salary);
		$("input[name='workDeptNm']").val(cVo.workDeptNm);
		
	}
	else if(formDivId == 'acbgDiv')
	{	
		acbgVo = list[dataIndex];
		$('input[name="acbgDtl"]').val(acbgVo.acbgDtl);
		$('input[name="mtcltnYmd"]').val(acbgVo.mtcltnYmd);
		$('input[name="grdtnYmd"]').val(acbgVo.grdtnYmd);
		$('select[name="grdtnYn"]').val(acbgVo.grdtnYn);
		
	}
	else if(formDivId == 'pcDiv')
	{	
		pcVo = list[dataIndex];
		$('input[name="ordererNm"]').val(pcVo.ordererNm);
		$('input[name="pjNm"]').val(pcVo.pjNm);
		$('input[name="orderBgngYmd"]').val(pcVo.orderBgngYmd);
		$('input[name="orderEndYmd"]').val(pcVo.orderEndYmd);
		$('textarea[name="mainTask"]').val(pcVo.mainTask);
		
	}
	else if(formDivId == 'pDiv')
	{	
		pVo = list[dataIndex];
		console.log("pVo" + pVo.milYn);
		console.log("pVo" + pVo.marYn);
		if (pVo.milYn == 'Y') {	$("input[name='milYn'][value='Y']").prop('checked', true);	} 
		else if (pVo.milYn == 'N') { $("input[name='milYn'][value='N']").prop('checked', true);	}
		
		if (pVo.marYn == 'Y') {	$("input[name='marYn'][value='Y']").prop('checked', true);	} 
		else if (pVo.marYn == 'N'){ $("input[name='marYn'][value='N']").prop('checked', true);	}
		
		if (pVo.disYn == 'Y') {	$("input[name='disYn'][value='Y']").prop('checked', true);	} 
		else if (pVo.disYn == 'N'){ $("input[name='disYn'][value='N']").prop('checked', true);	}
		
		if (pVo.ntnMrtYn == 'Y') {	$("input[name='ntnMrtYn'][value='Y']").prop('checked', true);	} 
		else if (pVo.ntnMrtYn == 'N'){ $("input[name='ntnMrtYn'][value='N']").prop('checked', true);	}
		
		if (pVo.ntnSprtYn == 'Y') {	$("input[name='ntnSprtYn'][value='Y']").prop('checked', true);	} 
		else if (pVo.ntnSprtYn == 'N'){ $("input[name='ntnSprtYn'][value='N']").prop('checked', true);	}

		
	}
	else if(formDivId == 'satDiv')
	{	 
		satVo = list[dataIndex];
		$("input[name='sdytrnNm']").val(satVo.sdytrnNm);
		$("input[name='sdytrnBgngYmd']").val(satVo.sdytrnBgngYmd);
		$("input[name='sdytrnEndYmd']").val(satVo.sdytrnEndYmd);
		$("input[name='instNm']").val(satVo.instNm);
		
	}
	else if(formDivId == 'crtDiv')
	{
		crtVo = list[dataIndex];
		$("input[name='qlfcNo']").val(crtVo.qlfcNo);
		$("input[name='crtfctNm']").val(crtVo.crtfctNm);
		$("input[name='crtfctAcqsYmd']").val(crtVo.crtfctAcqsYmd);
		$("input[name='issueInstNm']").val(crtVo.issueInstNm);
	}
	
	else if(formDivId == 'siDiv')
	{
		sIVo = list[dataIndex];
		$("select[name='siTtl']").val(sIVo.siTtl);
		$("textarea[name='siCn']").val(sIVo.siCn);
	}
	
}
						
				
	//--------------------------- dataResult HTML리턴 ------------------------------			
		
	function retDataResult(formDivId,list,dataInfo)
	{
		
		var dataResult = "";		
		//console.log("test : " + dataInfo);
		//컬럼 정보 추가
		let selFormDiv = $(formDivId);
		
		let dataInfoChk = selFormDiv.find(".dataInfo");
		
		if(dataInfoChk.length <= 0)
		{
			dataResult += dataInfo;
		}
		
		// 데이터 내용 추가
			list.forEach(function(vo,index) 
			{
					
					// Object.keys를 사용하여 속성의 순서를 유지하면서 배열 생성
					//let keyList = Object.keys(vo).map(key => vo[key]);
					let keyList = [];
					let keyCnt = 0;
				    for (let key in vo) 
				    {
				    	
				        if (vo.hasOwnProperty(key)) 
				        	{
				        		console.log("key: " +key + "value : " +  vo[key]);
				        		
				        		 if(formDivId == "#acbgDiv")
				        		 {	
				        			 if(key == 'acbgDtl' || key == 'mtcltnYmd' || key == 'grdtnYmd' || key == 'grdtnYn')
					        		 	{	
					        			 	keyList.push(vo[key]);	keyCnt++;
					        		 	}
				        		}
				        		 
				        		 else if(formDivId == "#cDiv")
			        			 {	if(key == 'coNm' || key == 'jobPosNm'  || key == 'workBgngYmd' || key == 'workEndYmd' || key == 'workDeptNm'){	keyList.push(vo[key]); keyCnt++;	}	}
				        		 
				        		 else if(formDivId == "#pcDiv")
			        			 {	if(key == 'ordererNm' || key == 'pjNm' || key == 'orderBgngYmd' || key == 'orderEndYmd'){	keyList.push(vo[key]);	 keyCnt++;}	}
				        		 
				        		 else if(formDivId == "#pDiv")
			        			 {	if(key == 'milYn' || key == 'marYn' || key == 'disYn' || key == 'ntnMrtYn' || key == 'ntnSprtYn'){	keyList.push(vo[key]);	keyCnt++;}	}
				        		 
				        		 else if(formDivId == "#crtDiv")
			        			 {	
				        			 
				        			 if(key == 'crtfctNm')
				        			 {
				        				 keyList.splice(0,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'qlfcNo')
				        			 {
				        				 keyList.splice(1,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'crtfctAcqsYmd')
				        			 {
				        				 keyList.splice(2,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'issueInstNm')
				        			 {
				        				 keyList.splice(3,0,vo[key]); keyCnt++;
				        			 }
			        			 
			        			 }
				        		 
				        		 
				        		 else if(formDivId == "#satDiv")
			        			 {	
				        			 if(key == 'sdytrnNm')
				        			 {
				        				 keyList.splice(0,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'instNm')
				        			 {
				        				 keyList.splice(1,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'sdytrnEndYmd')
				        			 {
				        				 keyList.splice(2,0,vo[key]); keyCnt++;
				        			 }
				        			 else if(key == 'sdytrnBgngYmd')
				        			 {
				        				 keyList.splice(3,0,vo[key]); keyCnt++;
				        			 }
				        			 
				        		}
				        		 
				        		 else if(formDivId == "#siDiv")
				        		 {	if(key == 'siTtl' || key == 'siCn'){	keyList.push(vo[key]);	keyCnt++;}	} 
				        		 
				        	}
				    }
				    
				    if(formDivId == "#acbgDiv")
			    	{
				    	dataResult += `<div><div class="row row-cols-${'${keyCnt + 1}'} align-items-center data-list " data-index="${'${index}'}">`;
				    	
						let gradList = "${gradList}";
				    	
				    	// cmcd 만 가져오기
						var cmcdArray = gradList.match(/cmcd=([^,]+)/g).map(function(match) {
						    return match.split('=')[1].trim();
						});
				    	
				    	// cmcdNm 값을 추출하여 JavaScript 배열로 만들기
						var cmcdNmArray = gradList.match(/cmcdNm=([^,]+)/g).map(function(match) {
						    return match.split('=')[1].trim();
						});
				    	
					    
					  	keyList.forEach(function(value) 
						{
				  			for (let i = 0; i < gradList.length; i++) {
				  			    if (value == cmcdArray[i]) 
				  			    {
				  			        value = cmcdNmArray[i];
				  			        break;
				  			    }
				  			}
					  		
					  		dataResult += `<div class="col text-primary selDataList text-wrap text-black text-center " > ${'${value}'} </div>`;
						});
					  
					  	dataResult += 
					  	`
						  	<div class="col text-end px-5" >
						  		<a href="javascript:void(0);" class="text-decoration-none removeDataListBtn">
					  				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
			  	  						<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"></path>
			  	  						<path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"></path>
			  						</svg> 삭제
			             		</a>
					    	</div>
						 `;	
						 
					  	dataResult += `</div></div><hr class="custom-hr">`;
			    		
					  	return dataResult;
			    	
			    	}
				    
				    else if(formDivId == "#siDiv")
				    	{
							let toggle = true;
			    		
				    	dataResult += `<div><div class="row row-cols-1 align-items-center data-list   " data-index="${'${index}'}">`;
				    	
				    	let sITitleList = "${sITitleList}";
				    	
				    	// cmcd 만 가져오기
				    	let cmcdArray = sITitleList.match(/cmcd=(\d+)/g).map(function(match) {
				    	    return match.split('=')[1];
				    	});
				    	
				    	// cmcdNm 값을 추출하여 JavaScript 배열로 만들기
				    	let cmcdNmArray = sITitleList.match(/cmcdNm=([^,]+)/g).map(function(match) {
				    	    return match.split('=')[1];
				    	});
				    	
				    	let title = "";

					  	keyList.forEach(function(value) 
						{
					    	
					  		if(toggle)
					  			{

						  			for (let i = 0; i < sITitleList.length; i++) {
						  			    if (value == cmcdArray[i]) {
						  			        title = cmcdNmArray[i];
						  			        break;
						  			    }
						  			}

					  				dataResult += `
					  				<div class="col-md-10 text-primary selDataList text-wrap text-black text-start fs-6 mt-2 mb-2 px-5" >
					  					${'${title}'}
					  				</div>
					  				<div class="col-md-1 text-end px-5">
							  		<a href="javascript:void(0);" class="text-decoration-none removeDataListBtn">
							  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
						  	  				<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"></path>
						  	  				<path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"></path>
						  				</svg> 삭제
				             		</a>
					  				</div>
					  				`;
					  				
					  				toggle = false;
					  			}
					  		else
					  			{
						  			dataResult += `<div class="col text-primary selDataList text-wrap text-black text-left px-3" ><span style="white-space:pre-wrap;">${'${value}'}</span> </div>`;
						  			toggle = true;
					  			}

						});
						  	dataResult += `</div></div><div class="mb-3"></div><hr class="custom-hr">`;
						  	return dataResult;
				    	}
				    
				    	dataResult += `<div><div class="row row-cols-${'${keyCnt + 1}'} align-items-center data-list  " data-index="${'${index}'}">`;
				    
					  	keyList.forEach(function(value) 
						{
					  		dataResult += `<div class="col text-primary selDataList  text-wrap text-black text-center px-3 " ><span style="white-space:pre-wrap;"> ${'${value}'} </span></div>`;
						});
					  
					  	dataResult += 
					  	`
						  	<div class="col text-end px-5" >
						  		<a href="javascript:void(0);" class="text-decoration-none removeDataListBtn">
						  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
						  	  		<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"></path>
						  	  		<path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"></path>
						  		</svg> 삭제
				             	</a>
					    	</div>
						 `;	
						 
					  	dataResult += `</div></div><hr class="custom-hr">`;
			})

			return dataResult;
}
	
				
	//--------------------------- 데이터 컬럼 정보 ------------------------------		
	 var acbgDataInfo =	
		`	
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-5 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">학교명</div>
				  <div class="col text-center text-black fs-6">입학일자</div>
				  <div class="col text-center text-black fs-6">졸업일자</div>
				  <div class="col text-center text-black fs-6">졸업구분</div>
				</div>
			<hr class="custom-hr"></div>
		
		`;

	 var cDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-6 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">회사명</div>
				  <div class="col text-center text-black fs-6">직책명</div>
				  <div class="col text-center text-black fs-6">근무시작일자</div>
				  <div class="col text-center text-black fs-6">근무종료일자</div>
				  <div class="col text-center text-black fs-6">근무부서명</div>
				</div>
			<hr class="custom-hr"></div>			
		`;
		
	 var pcDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-5 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">발주처명</div>
				  <div class="col text-center text-black fs-6">프로젝트명</div>
				  <div class="col text-center text-black fs-6">프로젝트시작일자</div>
				  <div class="col text-center text-black fs-6">프로젝트종료일자</div>
				</div>
			<hr class="custom-hr"></div>
		`;
		
	var crtDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-5 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">자격증명</div>
				  <div class="col text-center text-black fs-6">자격증번호</div>
				  <div class="col text-center text-black fs-6">자격증발급일자</div>
				  <div class="col text-center text-black fs-6">발급기관명</div>
				</div>
			<hr class="custom-hr"></div>	

		`;

	 var satDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-5 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">연수과정명</div>
				  <div class="col text-center text-black fs-6">연수기관명</div>
				  <div class="col text-center text-black fs-6">연수시작일자</div>
				  <div class="col text-center text-black fs-6">연수종료일자</div>
				</div>
			<hr class="custom-hr"></div>	
		`;		
				
	 var pDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
				<div class="row row-cols-6 mb-2 dataInfo">
				  <div class="col text-center text-black fs-6">병역여부</div>
				  <div class="col text-center text-black fs-6">결혼여부</div>
				  <div class="col text-center text-black fs-6">장애여부</div>
				  <div class="col text-center text-black fs-6">보훈대상여부</div>
				  <div class="col text-center text-black fs-6">고용지원금대상여부</div>
				</div>
			<hr class="custom-hr"></div>	
		`;			
		
	  var siDataInfo =	
		`
			<hr class="custom-hr title-hr"><div>
		`;		
		
		
		
	//--------------------------- 입력 폼 추가 버튼 이벤트 ------------------------------
	function addForm(divId,formHtml)
	{
		//데이터 리스트 숨김
		var showDataDiv = $(divId).find(".showDataDiv");
		if(showDataDiv != null)
		{
			$(divId).find(".showDataDiv").hide();
		}
		
		console.log("addForm()" + divId);
		//폼 추가할 div 가져와서 form div 추가.
	     var selDiv = document.querySelector(divId);
		
		// id가 divId + Form  인 입력폼 생성
		 let form = document.createElement("div");
		 form.innerHTML = formHtml;
		 
		 //cDivForm
		 form.id = divId.substring(1) + "Form";
		 
		 //가져온 div 에 자식으로 추가
		 selDiv.appendChild(form);
		 
		 //가져온 div 안의 addBtn을 숨김
		 let addBtn = selDiv.querySelector('.addBtn');
		 addBtn.style.visibility = "hidden";
		 
		 
	}
	
	  //--------------------------- 학력 폼 -------------------------

	var acbgInputForm = 
						  `
					    	<div class=" addForm">
							<hr class="custom-hr">
					    	  <div class="row row-cols-5 mb-2">
					    	    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="acbgDtl"		placeholder ="학교명"></div>
					    	    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="mtcltnYmd"		placeholder ="입학일자"></div>
					    	    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="grdtnYmd"		placeholder ="졸업일자"></div>
					    	    <div class="col mt-2 mb-2">
						    	    <select class="form-select" name="grdtnYn">
							    	    <option selected>졸업구분</option>
							    	    <option value="01">재학</option>
							    	    <option value="02">휴학</option>
							    	    <option value="03">중퇴</option>
							    	    <option value="04">졸업예정</option>
					    	  		</select>					    	    	
					    	    </div>
					    	    <div class="col mt-2 mb-2 text-end">
			      					<button type="button"  class="btn btn-primary bg-custom  btn-inline cancleBtn">취소</button>
			      					<button type="submit"  class="btn btn-primary bg-custom btn-inline saveBtn">저장</button>
			   					</div>
					    	  </div>
					    	  <hr class="custom-hr">
					    	</div>
					    	
						  `;

	//--------------------------- 경력 폼 -------------------------
	
	   var cInputForm = 
		  `
		  	<hr class="custom-hr">
	    	<div class=" mt-3 mb-3 addForm">
	    	  <div class="row row-cols-3 mb-2">
	    	  	<div class="col mt-2 mb-2"><input class="form-control" type="text" name="coNm"		placeholder ="회사명"></div>
	    	  	<div class="col mt-2 mb-2"><input class="form-control" type="text" name="jobPosNm"	placeholder ="직책명"></div>
	    	  	<div class="col mt-2 mb-2">
			        <select id="serveYn" name = "serveYn" class="form-select" aria-label="Default select example">
			        	<option selected>재직여부*</option>
			            <option value="Y">재직</option>
			            <option value="N">퇴사</option>
			        </select>
	    	  	</div>
	    	  </div>

	    	  <div class="row row-cols-2 mb-2">
	    	  	<div class="col mt-2 mb-2"><input class="form-control" type="text" name="salary"	placeholder ="급여"></div>
	    	  	<div class="col mt-2 mb-2"><input class="form-control" type="text" name="workDeptNm"	placeholder ="근무부서명"></div>
	  		  </div>

	    	  <div class="row row-cols-2 mb-2">
	    		<div class="col mt-2 mb-2">
    	    		<label for="workBgngYmd">근무시작일자</label><input class="form-control" type="date" id="workBgngYmd" name="workBgngYmd" >
    	    	</div>
	    		<div class="col mt-2 mb-2">
	    			<label for="workEndYmd">근무종료일자</label><input class="form-control" type="date" id="workEndYmd" name="workEndYmd" >
	    		</div>
	  		  </div>							  		  
	  		  
	    	  <div class="row row-cols-1 mb-2">
	    	    <div class="col mt-2 mb-2">
	    	    	<label for="assignTaskCn">담당업무</label>
	    	    	<textarea class="form-control" id="assignTaskCn" name="assignTaskCn" rows="7" placeholder="- 진행한 업무를 다 적기 보다는 경력사항 별로 중요한 내용만 엄선해서 작성하는 것이 중요합니다!
- 담당한 업무 내용을 요약해서 작성해보세요!
- 경력별 프로젝트 내용을 적을 경우, 역할/팀구성/기여도/성과를 기준으로 요약해서 작성해보세요!"></textarea>
    	    	</div>
	    	    <div class="col mt-2 mb-2 text-end">
	      			<button type="button"  class="btn btn-primary bg-custom  btn-inline cancleBtn">취소</button>
	      			<button type="submit"  class="btn btn-primary bg-custom btn-inline saveBtn">저장</button>
	   			</div>
	  		  </div>
	    	</div>
		  `;
		  

	
	//--------------------------- 프로젝트 경력 폼 -------------------------

		var pcInputForm = 
					 `
								    	<hr class="custom-hr">
										<div class=" mt-3 mb-3 addForm">
										<div class="row row-cols-2 mb-2">
											<div class="col mt-2 mb-2"><input class="form-control" type="text" name="pjNm"			placeholder ="프로젝트 명"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="ordererNm" 	placeholder ="발주처 명"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="orderBgngYmd"	placeholder ="프로젝트 시작 일자"></div>
										    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="orderEndYmd"	placeholder ="프로젝트 종료 일자"></div>
										</div>
										<div class="row row-cols-1 mb-2">
											<div class="col mt-2 mb-2">
											<label for="mainTask">주요업무</label>
							    	    	<textarea class="form-control" id="mainTask" name="mainTask" rows="7" placeholder="- 진행한 업무를 다 적기 보다는 경력사항 별로 중요한 내용만 엄선해서 작성하는 것이 중요합니다!
- 담당한 업무 내용을 요약해서 작성해보세요!
- 경력별 프로젝트 내용을 적을 경우, 역할/팀구성/기여도/성과를 기준으로 요약해서 작성해보세요!"></textarea>
											</div>
										    <div class="col mt-2 mb-2 text-end">
											      	<button type="button" class="btn btn-primary  bg-custom  btn-inline cancleBtn">취소</button>
											      	<button type="submit"  class="btn btn-primary  bg-custom  btn-inline saveBtn">저장</button>
										  	</div>
										</div>
					 `;
					 	 

	//---------------------------취업 특이사항 폼 -------------------------
	
		var pInputForm = 
					 `
								    	<hr class="custom-hr">
										<div class=" mt-3 mb-3 addForm">
											<div class="row row-cols-3 mb-2">
												<div class="col mt-2 mb-2 text-start text-black fs-4">병역 여부</div>
												<div class="col mt-2 mb-2"></div>
												<div class="col mt-2 mb-2 text-end">
													<input type="radio" class="btn-check" name="milYn" id="milYn1" value="Y">
													<label class="btn btn-outline-primary" for="milYn1">Y</label>
													<input type="radio" class="btn-check" name="milYn" id="milYn2" value="N">
													<label class="btn btn-outline-primary" for="milYn2">N</label>
												</div>
												<div class="col mt-2 mb-2 text-start text-black fs-4">결혼 여부</div>
												<div class="col mt-2 mb-2"></div>
												<div class="col mt-2 mb-2 text-end">
													<input type="radio" class="btn-check" name="marYn" id="marYn1" value="Y">
													<label class="btn btn-outline-primary" for="marYn1">Y</label>
													<input type="radio" class="btn-check" name="marYn" id="marYn2" value="N">
													<label class="btn btn-outline-primary" for="marYn2">N</label>
												</div>
												
												
												<div class="col mt-2 mb-2 text-start text-black fs-4">장애 여부</div>
												<div class="col mt-2 mb-2"></div>
												<div class="col mt-2 mb-2 text-end">
													<input type="radio" class="btn-check" name="disYn" id="disYn1" value="Y">
													<label class="btn btn-outline-primary" for="disYn1">Y</label>
													<input type="radio" class="btn-check" name="disYn" id="disYn2" value="N">
													<label class="btn btn-outline-primary" for="disYn2">N</label>
												</div>
												
												<div class="col mt-2 mb-2 text-start text-black fs-4">국가보훈 대상 여부</div>
												<div class="col mt-2 mb-2"></div>
												<div class="col mt-2 mb-2 text-end">
													<input type="radio" class="btn-check" name="ntnMrtYn" id="ntnMrtYn1" value="Y">
													<label class="btn btn-outline-primary" for="ntnMrtYn1">Y</label>
													<input type="radio" class="btn-check" name="ntnMrtYn" id="ntnMrtYn2" value="N">
													<label class="btn btn-outline-primary" for="ntnMrtYn2">N</label>
												</div>
												
												<div class="col mt-2 mb-2 text-start text-black fs-4">고용 지원금 대상 여부</div>
												<div class="col mt-2 mb-2"></div>
												<div class="col mt-2 mb-2 text-end">
													<input type="radio" class="btn-check" name="ntnSprtYn" id="ntnSprtYn1" value="Y">
													<label class="btn btn-outline-primary" for="ntnSprtYn1">Y</label>
													<input type="radio" class="btn-check" name="ntnSprtYn" id="ntnSprtYn2" value="N">
													<label class="btn btn-outline-primary" for="ntnSprtYn2">N</label>
												</div>
											</div>
										    <div class="col mt-2 mb-2 text-end">
									      		<button type="button" class="btn btn-primary  bg-custom  btn-inline cancleBtn">취소</button>
									      		<button type="submit"  class="btn btn-primary  bg-custom  btn-inline saveBtn">저장</button>
								  			</div>
										</div>
					 `;			
					 
	//---------------------------연수 등록 폼 -------------------------
	
		var satInputForm = 
					 `
								    	<hr class="custom-hr">
										<div class=" mt-3 mb-3 addForm">
											<div class="row row-cols-5 mb-2">
												<div class="col mt-2 mb-2"><input class="form-control" type="text" name="sdytrnNm"		placeholder ="연수 과정명"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="instNm" 		placeholder ="연수 기관명"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="sdytrnBgngYmd"	placeholder ="시작 일자"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="sdytrnEndYmd"	placeholder ="종료 일자"></div>
												<div class="col mt-2 mb-2 text-end">
												  <button type="button" class="btn btn-primary  bg-custom  btn-inline cancleBtn">취소</button>
												  <button type="submit"  class="btn btn-primary  bg-custom  btn-inline saveBtn">저장</button>
												</div>
											</div>
										</div>
					 `;
					 
	//---------------------------연수 등록 폼 -------------------------
	
		var crtInputForm = 
					 `
								    	<hr class="custom-hr">
										<div class=" mt-3 mb-3 addForm">
											<div class="row row-cols-5 mb-2">
												<div class="col mt-2 mb-2"><input class="form-control" type="text" name="crtfctNm"		placeholder ="자격증명"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="qlfcNo" 		placeholder ="자격증 번호"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="date" name="crtfctAcqsYmd"	placeholder ="자격증 취득 일자"></div>
											    <div class="col mt-2 mb-2"><input class="form-control" type="text" name="issueInstNm"	placeholder ="발급기관명"></div>
												<div class="col mt-2 mb-2 text-end">
												  <button type="button" class="btn btn-primary  bg-custom  btn-inline cancleBtn">취소</button>
												  <button type="submit"  class="btn btn-primary  bg-custom  btn-inline saveBtn">저장</button>
												</div>
											</div>
										</div>
					 `;
					 
					 
		//---------------------------자기소개서 등록 폼 -------------------------
	
		var siInputForm = 
					 `
								    	<hr class="custom-hr">
										<div class=" mt-3 mb-3 addForm">
											<div class="row row-cols-1 mb-2">
												<div class="col mt-2 mb-2">
													<c:if test="${not empty sITitleList}">
														<select id="siTtl" name ="siTtl" class="form-select" aria-label="Default select example">
												        	<c:forEach items="${sITitleList}" var="siTtlVo" varStatus="vs">
												        			<option value="${siTtlVo.cmcd}">${siTtlVo.cmcdNm}</option>
												            </c:forEach>
											        	</select>
													</c:if>
												</div>
											    <div class="col mt-2 mb-2">
											    	<label for="si_cn">자기소개서 내용</label>
								    	    		<textarea class="form-control" id="siCn" name="siCn" rows="7" placeholder="- 자기소개서 내용"></textarea>
											    </div>
												<div class="col mt-2 mb-2 text-end">
												  <button type="button" class="btn btn-primary  bg-custom  btn-inline cancleBtn">취소</button>
												  <button type="submit"  class="btn btn-primary  bg-custom  btn-inline saveBtn">저장</button>
												</div>
											</div>
										</div>
					 `;			 
					 
					 
</script>
  