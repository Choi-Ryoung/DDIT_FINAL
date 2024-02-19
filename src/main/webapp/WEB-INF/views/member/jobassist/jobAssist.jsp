<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
   body {
     background-color: white;
   }
   
   .container{
      min-height: 550px;
   }
   
   .title {
       text-transform: uppercase;
   }
   
   .card-block {
       font-size: 1em;
       position: relative;
       margin: 0;
       padding: 1em;
       border: none;
       box-shadow: none;
   }
   
   .card {
       font-size: 1em;
       overflow: hidden;
       padding: 5;
       border: none;
       border-radius: .28571429rem;
       box-shadow: 0 1px 3px 0 #d4d4d5, 0 0 0 1px #d4d4d5;
       margin-top:20px;
       padding: 15px;
       height: 500px;
   }
   
   .card2{
      width: 550px;
   }
   
   .carousel-indicators li {
       border-radius: 12px;
       width: 12px;
       height: 12px;
       background-color: #404040;
   }
   .carousel-indicators li {
       border-radius: 12px;
       width: 12px;
       height: 12px;
       background-color: #404040;
   }
   .carousel-indicators .active {
       background-color: white;
       max-width: 12px;
       margin: 0 3px;
       height: 12px;
   }
   .carousel-control-prev-icon {
      background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
   }
   
   .carousel-control-next-icon {
      background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
   }
    lex-direction: column;
   }
   
   #resumeText {
      margin: 0 auto;
      height: 300px;
      border: none;
      resize: none;
   }
   
   #count, #countNBSP{
      margin-left: 88%;
   }
   
   #caution{
      font-size: 0.8em;
   }
   
   .quitMoney{
      display: inline-block;
      width: 300px;
   }
   
/*    .btn{
      position: absolute;
      width: 100%;
      margin-top: 64%;
      border-radius: 0;
      height: 70px;
   }
    */
   .takeMoney{
      height: 325px;
   }
   
   input[type=number], input[type=text]{
      border: none;
   }
   
   input[type=number]{
      text-align: right;
   }
   
   input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
   }
   
   #textLimit{
      width : 100px;
      float : right;
   }
   
   	.br-top
	{
		border-top : 4px solid cornflowerblue;
	}
   
</style>

<div id="sh_container">
   <div id="sh_container_wrapper">
      <div id="sh_content">
         <div id="greeting" class="pagecommon">
            <div class="row">
               <div class="col-md-12">
                  <nav>
                     <div class="nav nav-tabs " id="nav-tab" role="tablist">
                        <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab"   aria-controls="nav-home" aria-selected="false" onClick="location.href='${cxtp}/employment/list'">채용공고</button>
                        <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"   type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${cxtp}/employment/briefingList'">채용설명회</button>
                        <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true" onClick="location.href='${cxtp}/member/jobAssist'">취업도우미</button>
                     </div>
                  </nav>
                  <hr>
                  <div class="mt-4">
                     <img alt="취업도우미.jpg" src="${ctxp }/resources/img/main/menu_banner/취업도우미.jpg">
                  </div>
                  <hr>
               </div>
            </div>
            <div class="container py-3">
               <!-- Card Start -->
               <div class="card br-top">
                  <div class="title h4 text-center text-black pb-2 border-bottom ">
                    	 글자 수 세기
                     <select id="textLimit" class="form-select">
                        <option value="500" selected>500자</option>
                        <option value="750">750자</option>
                        <option value="1000">1000자</option>
                     </select>
                  </div>
                  <div class="row">
                     <textarea class="form-control resumeText" id="resumeText" style="margin: 0 auto; height: 300px;   border: none; resize: none;" placeholder="여기에 내용을 입력하세요." onkeyup="countingText();"></textarea>
                  </div>
                  <hr/>
                  <span id="count" class="text-black">공백 포함 : 0</span>
                  <span id="countNBSP"  class="text-black">공백 제외 : 0</span>
               </div>
               <span id="caution" class="text-black fs-6">※ 해당 데이터는 저장되지 않습니다.</span>
               <!-- End of card -->
            </div>
            
            <div class="row">
               <div class="card card2 mx-5 br-top">
                  <div class="title h4 text-center text-black pb-3 border-bottom">퇴직금 계산기</div>
                  <div class="row ">
                     <div class="col-sm-12 text-black ">
                        <p class="text-black mt-2 mb-4">입사일 <input type="date" id="hireDate"> ~ 퇴사일 <input type="date" id="quitDate"></p>
                        <p><span class="quitMoney text-black">3개월 급여 총액</span><input type="number" id="threeMonth" class="commaClass" placeholder="0"> 원</p>
                        <p><span class="quitMoney text-black">연간 상여금 총액</span><input type="number" id="bonus" class="commaClass" placeholder="0"> 원</p>
                        <p><span class="quitMoney text-black">연차수당</span><input type="number" id="yearBonus" class="commaClass" placeholder="0"> 원</p>
                        <hr/>
                        <p><span class="quitMoney text-black">재직일수</span><input type="number" id="empDate" placeholder="0" readonly> 일</p>
                        <p><span class="quitMoney text-black">1일 평균임금</span><input type="number" id="avgSalary" placeholder="0" readonly> 원</p>
                        <p><span class="quitMoney text-black">예상퇴직금(세전 기준)</span><input type="number" id="preQuitMoney"placeholder="0"  readonly> 원</p>
                     </div>
                     <div class="col mt-5 text-center">
                     	<button type="submit" id="calQuitBtn" onclick="calQuitMoney();" class="btn btn-primary" style="width:510px; margin-top:51px;">계산하기</button>
                     </div>
                  </div>
               </div>
               
               
               <div class="card card2 br-top">
                  <div class="title h4 text-center text-black pb-3 border-bottom">실수령액 계산기(월급 기준)</div>
                  <div class="row">
                     <div class="col-sm-6 takeMoney">
                        <p class="text-black mt-2 mb-2"><span class="quitMoney text-black">월급</span><input type="number" class="commaClass text-black" placeholder="예) 1000000"> 원</p>
                        <p class="text-black"><span class="InputTakeMoney text-black">비과세액(식대포함)</span><input type="number" id="taxFree" class="commaClass text-black" placeholder="0"> 원</p>
                        <p class="text-black"><span class="InputTakeMoney text-black">부양가족수(본인포함) </span><input type="number" id="depFamCnt" class="commaClass text-black" placeholder="1"> 명</p>
                        <p class="text-black"><span class="InputTakeMoney text-black">8세 이상 20세 이하 자녀수 </span><input type="number" id="childCnt" class="commaClass text-black" placeholder="0"> 명</p>
                     </div>
                     <div class="col-sm-6 takeMoney" style="border-left: 1px solid rgba(0,0,0,.1);">
                        <p class="text-black mt-2 mb-2"><b class="text-black">예상 소득액 : </b><span id="prdictTakeMoney" class="text-black"></span> 원</p>
                        <hr/>
                        <p><b class="text-black">공제액 합계 : <span id="totalGongJe" class="text-black"></span> 원</b></p>
                       <span class="text-black"> 국민연금 : <span id="yenGuem" class="text-black"></span> 원 </span><br/>
                        <span class="text-black"> 건강보험 : <span id="gungang" class="text-black"></span> 원</span><br/>
                        <span class="text-black"> 장기요양 : <span id="yoYang" class="text-black"></span> 원</span><br/>
                        <span class="text-black"> 고용보험 : <span id="goYong" class="text-black"></span> 원</span><br/>
                        <span class="text-black"> 소득세 : <span id="soDuek" class="text-black"></span> 원</span><br/>
                         <span class="text-black">지방소득세 : <span id="jibangSoDuek"></span> 원</span><br/>
                        <hr/>
                     </div>
                     <div class="col mt-5 text-center">
                     	<button type="submit" id="calTakeBtn" onclick="calTakeMoney();" class="btn btn-primary" style="width:510px;">계산하기</button>
                     </div>
                     
                  </div>
               </div>
               <div class="row p-3 rounded bg-light mt-5">
					<div class="col-md-12">
						<div class="col mt-2 mb-2">
							<span class="text-black fs-5 fw-bold">※ 퇴직금 = 1일 평균임금 × 30(일) × (재직일수/365)</span>
						</div>
						<div class="col-sm-12 mt-2 mb-2 text-black">
							 ※ 1년 이상 계속 근로한 경우에 지급됩니다.
						</div>
						<div class="col-sm-12 mt-2 mb-2 text-black">
				          	  ※ 회사마다 평균임금 및 통상임금 기준이 다르기 때문에 실제 퇴직금과는 차이가 있습니다.
				        </div>
					</div>
			   </div>
            </div>
         </div>
      </div>
   </div>
</div>

<script>

/* 퇴직금 계산기 버튼 */
var calQuitBtn = $('#calQuitBtn');
/* 입사일 */
var hireDate = $('#hireDate');
/* 퇴사일 */
var quitDate = $('#quitDate');
/* 3개월 급여 총액 */
var threeMonth = $('#threeMonth');
/* 상여금 총액 */
var bonus = $('#bonus');
/* 연차수당 */
var yearBonus = $('#yearBonus');
/* 재직일수 */
var empDate = $('#empDate');
/* 평균임금 */
var avgSalary = $('#avgSalary');
/* 예상퇴직금 */
var preQuitMoney = $('#preQuitMoney');

/* 실수령액 계산기 버튼 */
var calTakeBtn = $('#calTakeBtn');
/* 비과세액 */
var taxFree = $('#taxFree');
/* 부양가족수 */
var depFamCnt = $('#depFamCnt');
/* 월급 */
var childCnt = $('#childCnt');
/* 국민연금 */
var yenGuem = $('#yenGuem');
/* 건강보험 */
var gungang = $('#gungang');
/* 장기요양 */
var yoYang = $('#yoYang');
/* 고용보험 */
var goYong = $('#goYong');
/* 소득세 */
var soDuek = $('#soDuek');
/* 지방소득세 */
var jibangSoDuek = $('#jibangSoDuek');
/* 예상소득액 */
var prdictTakeMoney = $('#prdictTakeMoney');
/* 공제액 합계 */
var totalGongJe = $('#totalGongJe');

/* 글자 수 */
var textLimit = $('#textLimit');

textLimit.on('change', function(){
   console.log($(this).val());
});

/* 글자 수 세기 */
function countingText() {
    var content = document.getElementById('resumeText').value;
   console.log("textLimit : ", textLimit);
    if (content.length > textLimit.val()) {
        content = content.substring(0, textLimit.val());
        document.getElementById('resumeText').value = content;
    }
    document.getElementById('count').innerHTML = "공백 포함 : " + content.length;
    document.getElementById('countNBSP').innerHTML = "공백 제외 : " + content.replace(/\s+/g, '').length;
}

function calQuitMoney(){
   const hireDateMilli = new Date(hireDate.val());
   console.log(hireDateMilli.getTime());
   
   const quitDateMilli = new Date(quitDate.val());
   console.log(quitDateMilli.getTime());
   
   var diffTime = quitDateMilli.getTime() - hireDateMilli.getTime();
   var diffDay = diffTime / 86400000;
   var dayAvgSalary = Math.round((threeMonth.val()*3)/(30.3*3));
   empDate.val(diffDay);
   avgSalary.val(dayAvgSalary);
   preQuitMoney.val(dayAvgSalary * 30);
}

function calTakeMoney(){
   prdictTakeMoney.text("1,614,110");
   totalGongJe.text("185,890");
   yenGuem.text("81,000");
   gungang.text("63,810");
   yoYang.text("8,260");
   goYong.text("16,200");
   soDuek.text("15,110");
   jibangSoDuek.text("1,510");
}

</script>