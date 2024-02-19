<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>


<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: lightblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}

table {
	width : 100%;
	text-align : center;
}

.sttext {
	font-weight: bold;
	font-size: large;
}

.modal body {
	float : center;
	text-align: center;
}

.proimg {
	border-radius: 50%;
}

/* 
th:nth-child(1) {
	width: 4%;
}

th:nth-child(2) {
	width: 10%;
}

th:nth-child(4) {
	width: 15%;
}
th:nth-child(5) {
	width: 8%;
}
th:nth-child(6) {
	width: 8%;
} */

 #drop-area {
            border: 2px dashed #ccc;
            width: 1000px;
            height: 700px;
            text-align: center;
            padding: 10px;
            margin: 10px auto;
            transition: background-color 0.3s ease-in-out;
        }
        #drop-area:hover {
            background-color: #eee;
        }
        #image-preview {
            margin: 10px auto;
            max-width: 1000px;
            max-height: 1200px;
            display: none;
        }
        
        #noDisplay{
        	position: absolute;
        	z-index: 3;
		    width: 900px;
    		height: 676px;
    		margin: 50px 150px;
        }
        
        #remote_video{
        	position: absolute;
        	z-index: 1;
		    width: 900px;
    		height: 676px;
    		margin: 50px 150px;
        }
        
        #local_video{
        	position: absolute;
		    z-index: 2;
		    width: 300px;
		    margin-left: 750px;
		    margin-top: 556px;
        }
</style>

<div class="modal fade" id="evalueDocModal" aria-hidden="true" aria-labelledby="evalueDocModal" tabindex="-1">
<input type="hidden" name="prMbrId">
<input type="hidden" name="resNo">
<input type="hidden" name="codingPassYn">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen">
    <div class="modal-content">
      <div class="modal-header">
		<ul class="nav nav-pills">
		  <li class="nav-item ">
		    <a class="nav-link menuRes active fs-6"  data-bs-target="#evalueDocModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">서류</a>
		  </li>
			  <li class="nav-item">
			  	 <a class="nav-link menuCt fs-6" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">코딩테스트</a>
			  </li>
		  <li class="nav-item ">
		  	<a class="nav-link menuIv fs-6" data-bs-target="#evalueIvModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">면접</a>
		  </li>
		</ul>
      </div>
      <div class="modal-body">
		<div class="row">
			<div class="col-md-8"><iframe class= "showRes" src=""  style="width:1250px; height:800px;" id="resumeImg"></iframe></div>
			<div class="col-md-4">
				<div class="col align-items-center text-center">
					<span class="text-black fs-5">평가하기</span>&emsp;&emsp;&emsp;
					<input type="button" id="autoDocBtn" class="btn btn-outline-primary" value="자동완성">
					<hr>
				</div>
				 <div class="col align-items-center text-center">
					<input type="radio" id="docPassY" name="docPassYn" value="Y" class="btn-check">
					<label class="btn btn-outline-primary" for="docPassY">합격</label>
					<input type="radio" id="docPassN" name="docPassYn" value="N" class="btn-check">
					<label class="btn btn-outline-danger" for="docPassN">불합격</label>
				 	<hr>
				 </div>
				  <div class="col align-items-center text-center">
					<textarea id="docEvalue" name="docEvalue" class="form-control" rows="18" placeholder="코멘트는 평가내용에 기록됩니다."></textarea><hr>
				 </div>
				 <div class="col align-items-center text-center">
				 	<button class="btn btn-outline-primary saveEvalueBtn">평가 결과 저장 및 결과 통보</button>
				 	<hr>
				 </div>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary closeModalBtn" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>


<!-- 코딩테스트 모달 -->
<div class="modal fade" id="evalueCtModal" aria-hidden="true" aria-labelledby="evalueCtModal" tabindex="-1">
<input type="hidden" name="prMbrId">
<input type="hidden" name="resNo">
   <div class="modal-dialog modal-dialog-centered modal-fullscreen">
    <div class="modal-content">
      <div class="modal-header">
		<ul class="nav nav-pills">
		  <li class="nav-item ">
		    <a class="nav-link menuRes fs-6"  data-bs-target="#evalueDocModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">서류</a>
		  </li>
			  <li class="nav-item ">
			    <a class="nav-link menuCt active fs-6" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">코딩테스트</a>
			  </li>
		  <li class="nav-item ">
		  	<a class="nav-link menuIv fs-6" data-bs-target="#evalueIvModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">면접</a>
		  </li>
		</ul>
      </div>
      <div class="modal-body">
		<div class="row">
			<div class="col-md-8">
				<div class="col">
					<span class="text-black fs-5 px-3">지원자 풀이 보기</span>&emsp;&emsp;
					<c:forEach var="i" begin="1" end="5" step="1" varStatus="vs"> 
						<input type="radio" id="sel${i}" name="selAnswer" value="${i}" class="btn-check mr-2" <c:if test="${vs.index eq '1'}">checked</c:if>>
						<label class="btn btn-outline-primary" for="sel${i}">${i}</label>&ensp;
					</c:forEach>
					<br>
				</div>
				<div id="ctResult" class="mt-3" style="width: 100%; height: 400px;"></div>
			</div>
			<div class="col-md-4">
				<div class="col align-items-center text-center">
					<table class="table table-hover">
					  <thead>
					    <tr>
					      <th class="fs-5 text-center" scope="col" colspan="8">코딩테스트 채점표</th>
					      <td scope="col" colspan="2"><input type="button" id="autoCtBtn" class="btn btn-outline-primary" value="자동완성"></td>
					    </tr>
					  </thead>
					  <tbody>
					   <tr>
					      <th scope="row" colspan="1" >No</th>
					      <td colspan="6">문제 제목</td>
					      <td colspan="3">점수</td>
					    </tr>
					  <c:set var="cnt" value="1"></c:set>
					  <c:forEach var="i" begin="1" end="5" varStatus="vs"> 
					    <tr>
					      <td scope="col">${vs.count}</td>
					      <td colspan="6" class="qTitle${vs.count}">문제 제목</td>
					      <td colspan="3">
					      <c:forEach var="i" begin="1" end="5" step="1"> 
								<input type="radio" id="q${cnt}" name="ctQ${vs.count}" value="${i}" class="btn-check mr-2">
								<label class="btn btn-outline-primary" for="q${cnt}">${i}</label>&ensp;
						    	<c:set var="cnt" value="${cnt + 1}"></c:set>
					      </c:forEach>
					      </td>
					    </tr>
					  </c:forEach>
						   <tr>
						    	<td colspan="9"><hr></td>
						   </tr>
						   <tr class="fs-5 text-center">
					       	<th scope="row" colspan="8"> 합격 여부 </th>
							<td scope="col">
								<input type="radio" id="codingPassY" name="codingPassYn" value="Y" class="btn-check">
								<label class="btn btn-outline-primary" for="codingPassY">합격</label> 
								<input type="radio" id="codingPassN" name="codingPassYn" value="N" class="btn-check">
								<label class="btn btn-outline-danger" for="codingPassN">불합격</label>
							</td>
					      </tr>
					  </tbody>
					</table>				
				</div>
				  <div class="col align-items-center text-center">
					<hr><textarea id="codingEvalue" name="codingEvalue" class="form-control" rows="3" placeholder="코멘트는 평가내용에 기록됩니다."></textarea><hr>
				 </div>
				 <div class="col align-items-center text-center">
				 	<button class="btn btn-outline-primary saveEvalueBtn">평가 결과 저장 및 결과 통보</button>
				 	<hr>
				 </div>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary closeModalBtn" data-bs-target="#evalueIvModal" data-bs-toggle="modal" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>


<!-- 코딩테스트 감독화면 -->
<div class="modal fade" id="inspCtModal" aria-hidden="true" aria-labelledby="inspCtModal" tabindex="-1">
<input type="hidden" name="prMbrId">
<input type="hidden" name="resNo">
   <div class="modal-dialog modal-dialog-centered modal-fullscreen">
    <div class="modal-content">
      <div class="modal-header">
		<ul class="nav nav-pills">
		  <li class="nav-item ">
		    <a class="nav-link menuRes fs-6"  data-bs-target="#evalueDocModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">서류</a>
		  </li>
			  <li class="nav-item ">
			    <a class="nav-link menuCt active fs-6" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">코딩테스트</a>
			  </li>
		  <li class="nav-item ">
		  	<a class="nav-link menuIv fs-6" data-bs-target="#evalueIvModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">면접</a>
		  </li>
		</ul>
      </div>
      <div class="modal-body">
		<div class="row">
			<div class="col-md-8">
				<span class="text-black fs-5 px-2">코딩테스트 감독 화면</span><br>
				<video id="video" autoplay style="width :1200px; height : 700px;" class="mt-3"></video>
			</div>
			<div class="col-md-4">
			<table class="table table-hover">
  <thead>
    <tr class="text-black fs-5">
      <th scope="col" colspan="4"># 유의사항</th>
    </tr>
  </thead>
  <tbody>
    <tr class="border-top">
      <th scope="row" class="fs-5 text-black">1</th>
      <td colspan="3" class="fs-6 text-black">코딩테스트 감독화면은 화상 공유가 아닌 화면 공유로 진행 됩니다</td>
    </tr>
    <tr class="border-top">
      <th scope="row" class="fs-5 text-black">2</th>
      <td colspan="3" class="fs-6 text-black">별도의 카메라가 따로 필요하지 않습니다</td>
    </tr>
    <tr class="border-top">
      <th scope="row" class="fs-5 text-black">3</th>
      <td colspan="3" class="fs-6 text-black">주의 사항은 아래와 같습니다</td>
    </tr>
    <tr class="border-top">
      <th scope="row" class="fs-5 text-black">4</th>
      <td colspan="3" class="fs-6 text-black">해당 화면은 따로 녹화 하실 수 없으며 부정행위 방지 용도 이외에 사용할 수 없습니다</td>
    </tr>
    <tr class="border-top">
      <th scope="row" class="fs-5 text-black">5</th>
      <td colspan="3" class="fs-6 text-black">부정 행위 적발 시 아래의 실격 버튼을 눌러 불합격 처리 할 수 있습니다</td>
    </tr>
    <tr class="border-top">
    	<td colspan="4"><textarea class="form-control" rows="15" placeholder="MEMO"></textarea></td>
    </tr>
    <tr class="border-top">
    	<td colspan="4"><input type="button" class="btn btn-outline-danger disQualifyBtn"  value="실격" style="width:300px;"></td>
    </tr>
  </tbody>
</table>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal">평가화면으로 이동</button>
      </div>
    </div>
  </div>
</div>



<!-- 면접 모달 -->
<div class="modal fade" id="evalueIvModal" aria-hidden="true" aria-labelledby="evalueIvModal" tabindex="-1">
<input type="hidden" name="prMbrId">
<input type="hidden" name="resNo">
   <div class="modal-dialog modal-dialog-centered modal-fullscreen">
    <div class="modal-content">
      <div class="modal-header">
		<ul class="nav nav-pills">
		   <li class="nav-item ">
		    <a class="nav-link menuRes fs-6"  data-bs-target="#evalueDocModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">서류</a>
		   </li>
		  <li class="nav-item ">
		    <a class="nav-link menuCt fs-6" data-bs-target="#evalueCtModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">코딩테스트</a>
		  </li>
		  <li class="nav-item ">
		  	<a class="nav-link active menuIv  fs-6" data-bs-target="#evalueIvModal" data-bs-toggle="modal" data-bs-dismiss="modal" href="javascript:void(0);">면접</a>
		  </li>
		</ul>
      </div>
      <div class="modal-body">
		<div class="row">
			<div class="col-md-8">
				<video id="local_video" autoplay></video>
				<video id="remote_video" autoplay></video>
				<div id="noDisplay">
					<img alt="화면  연결.jpg" src="${ctxp }/resources/img/common/면접대기.JPG">
				</div>
			</div>
			<div class="col-md-4">
				 <div class="col align-items-center text-center">
					<table class="table table-hover">
					  <thead>
					    <tr>
					      <th scope="col" colspan="5" class="fs-5">면접 평가표</th>
					      <td scope="col"><input type="button" id="autoIvBtn" class="btn btn-outline-primary" value="자동완성"></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row"></th>
					      <td colspan="2">평가사항</td>
					      <td colspan="3">평점</td>
					    </tr>
					    <c:set var="index" value="1"></c:set>
					    <c:forEach items="${evalueList}" var="evalueVo" varStatus ="vs">
					     <tr>
					      <th scope="row">${vs.count}</th>
						      <td colspan="2" >${evalueVo.Q_NM}</td>
						      <c:forEach var="i" begin="1" end="3">
						      	<c:if test="${i eq 1}"><c:set var="val" value="5"></c:set></c:if>
						      	<c:if test="${i eq 2}"><c:set var="val" value="3"></c:set></c:if>
						      	<c:if test="${i eq 3}"><c:set var="val" value="2"></c:set></c:if>
							      <td scope="col" style="width: 16.66%;">
										<input type="radio" id="r${index}" name="ivQ${vs.count}" value="${val}" class="btn-check">
										<label class="btn btn-outline-primary" for="r${index}">${val}</label>
								  </td>
								<c:set var="index" value="${index + 1}" />
						      </c:forEach>
					      </tr>
					     </c:forEach>
					     	<tr>
						    	<td colspan="9"><hr></td>
						   </tr>
					       <tr class= "fs-5 text-start">
					       	<th scope="row"></th>
					       	<td scope="col" colspan="3">
								합격 여부
							</td>
							<td scope="col">
								<input type="radio" id="interviewPassY" name="interviewPassYn" value="Y" class="btn-check">
								<label class="btn btn-outline-primary" for="interviewPassY">합격</label>
							</td>
							<td scope="col">
								<input type="radio" id="interviewPassN" name="interviewPassYn" value="N" class="btn-check">
								<label class="btn btn-outline-danger" for="interviewPassN">불합격</label>
							</td>
					      </tr>
					  </tbody>
					</table>
				 </div>
				 <div class="col align-items-center text-center">
					<hr><textarea id="interviewEvalue" name="interviewEvalue" class="form-control" rows="2" placeholder="코멘트는 평가내용에 기록됩니다."></textarea><hr>
				 </div>
				 <div class="col align-items-center text-center">
				 	<button class="btn btn-outline-primary saveEvalueBtn">평가 결과 저장 및 결과 통보</button><hr>
				 </div>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary closeModalBtn" data-bs-dismiss="modal" aria-label="Close">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4 mb-4">
								<img src="${ctxp}/resources/img/main/menu_banner/지원자관리.png" width="1100px" height="300px">
						</div>
					</div>
				</div>
				
				<hr>
				
				<c:set value="${pagingVO.dataList}" var="entApplyList" />
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">프로필</th>
							<th scope="col">지원자</th>
							<th scope="col">경력</th>
							<th scope="col">지원날짜</th>
							<th scope="col">서류 합격여부</th>
							<th scope="col">코딩테스트 합격여부</th>
							<th scope="col">면접합격 여부</th>
							<th scope="col">최종합격 여부</th>
							<th scope="col">평가</th>
						</tr>
					</thead>
					<tbody class="applicantList">
						<c:choose>
							<c:when test="${empty applyList}">
								<h1>지원자 없음!</h1>
							</c:when>
							<c:otherwise>
								<c:forEach items="${applyList }" var="applyVo" varStatus="vs">
									<tr class="applicantOne">
										<td style="display: none;">
											<input type="hidden" class="applyOne" value="${applyVo}">
											<input type="hidden" class="prMbrId" value="${applyVo.PR_MBR_ID}">
											<input type="hidden" class="resNo" value="${applyVo.RES_NO}">
											<input type="hidden" class="docPassYn" value="${applyVo.DOC_PASS_YN}">
											<input type="hidden" class="docChkYn" value="${applyVo.DOC_CHK_YN}">
											<input type="hidden" class="docEvalue" value="${applyVo.DOC_EVALUE}">
											<input type="hidden" class="codingPassYn" value="${applyVo.CODING_PASS_YN}">
											<input type="hidden" class="codingEvalue" value="${applyVo.CODING_EVALUE}">
											<input type="hidden" class="interviewPassYn" value="${applyVo.INTERVIEW_PASS_YN}">
											<input type="hidden" class="interviewEvalue" value="${applyVo.INTERVIEW_EVALUE}">
											<input type="hidden" class="resumeFile" value="${applyVo.RESUME_FILE}">
											<!-- 면접 결과 -->
											<input type="hidden" class="ivQ1" value="${applyVo.IV_Q1}">
											<input type="hidden" class="ivQ2" value="${applyVo.IV_Q2}">
											<input type="hidden" class="ivQ3" value="${applyVo.IV_Q3}">
											<input type="hidden" class="ivQ4" value="${applyVo.IV_Q4}">
											<input type="hidden" class="ivQ5" value="${applyVo.IV_Q5}">
											<input type="hidden" class="ivQ6" value="${applyVo.IV_Q6}">
											<input type="hidden" class="ivQ7" value="${applyVo.IV_Q7}">
											<input type="hidden" class="ivQ8" value="${applyVo.IV_Q8}">
											<input type="hidden" class="ivQ9" value="${applyVo.IV_Q9}">
											<input type="hidden" class="ivQ10" value="${applyVo.IV_Q10}">
											
											<!-- 코테 결과 -->
											<input type="hidden" class="ctQ1" value="${applyVo.CT_Q1}">
											<input type="hidden" class="ctQ2" value="${applyVo.CT_Q2}">
											<input type="hidden" class="ctQ3" value="${applyVo.CT_Q3}">
											<input type="hidden" class="ctQ4" value="${applyVo.CT_Q4}">
											<input type="hidden" class="ctQ5" value="${applyVo.CT_Q5}">
										</td>
										<td>
											<c:if test="${applyVo.DOC_CHK_YN eq 'N'}"><span class="text-danger">New</span></c:if>
										</td>
										<td><img src="${ctxp}${applyVo.PROV_PHOTO}" width="100" height="100" class="proimg"></td>
										<td><span class="sttext">${applyVo.PR_MBR_NM }</span><br>
											${applyVo.SEXDSTN_CD }&emsp;/&emsp;${applyVo.AGE }&nbsp;세
										</td>
										<td>${applyVo.CAREER_CD}</td>
										<td> ${fn:substring(applyVo.APPLY_YMD, 0, 4)}년
											 ${fn:substring(applyVo.APPLY_YMD, 5, 7)}월 
											 ${fn:substring(applyVo.APPLY_YMD, 8, 10)}일
										</td>
										<td class="docPassYn">
										<c:if test="${applyVo.DOC_PASS_YN eq 'Y'}"> 합격 </c:if>
										<c:if test="${applyVo.DOC_PASS_YN eq 'N'}"> 불합격 </c:if>
										</td>	
									 	<td class="codingPassYn">
									 	<c:if test="${applyVo.CODING_PASS_YN eq 'Y'}">
									 		합격 <input type="hidden" class="setInspCtView" value="0">
									 	</c:if>
									 	<c:if test="${applyVo.CODING_PASS_YN eq 'N'}">
									 		불합격 <input type="hidden" class="setInspCtView" value="0">
									 	</c:if>
									 	<c:if test="${empty applyVo.CODING_PASS_YN}">
									 		<input type="hidden" class="setInspCtView" value="1">
									 	</c:if>
									 	</td>
									 	<td class="interviewPassYn">
									 		<c:if test="${applyVo.INTERVIEW_PASS_YN eq 'Y'}"> 합격 </c:if>
											<c:if test="${applyVo.INTERVIEW_PASS_YN eq 'N'}"> 불합격 </c:if>
									 	</td>
									 	<td>
									 		<c:if test="${applyVo.DOC_PASS_YN eq 'Y' and applyVo.CODING_PASS_YN eq 'Y' and applyVo.INTERVIEW_PASS_YN eq 'Y'}">
									 			<c:set var="passChk" value="1"></c:set><span class="text-primary">합격</span>
									 		</c:if>
									 		<c:if test="${applyVo.DOC_PASS_YN eq 'N' or applyVo.CODING_PASS_YN eq 'N' or applyVo.INTERVIEW_PASS_YN eq 'N'}">
									 			<c:set var="passChk" value="1"></c:set><span class="text-danger">불합격</span>
									 		</c:if>
									 		<c:if test="${passChk ne '1'}">
									 			<c:set var="passChk" value="0"></c:set><span class="text-warning">대기중</span>
									 		</c:if>
									 	</td>
									 	<td>
									 		<button type="button" class="btn me-md-2 fas btn btn-primary btn-sm openModalBtn">
									 			<c:if test="${passChk eq '1'}">결과보기</c:if>
									 			<c:if test="${passChk ne '1'}">평가하기</c:if>
									 		</button>
									 	</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
const dropArea = document.getElementById("drop-area");
const fileInput = document.getElementById("file-input");
const imagePreview = document.getElementById("image-preview");

$("#image-preview").on("click",function(){
	fileInput.click();
})

// 드래그 앤 드롭 이벤트 처리
dropArea.addEventListener("dragover", (e) => {
    e.preventDefault();
    dropArea.style.backgroundColor = "#eee";
});

dropArea.addEventListener("dragleave", () => {
    dropArea.style.backgroundColor = "#fff";
});

dropArea.addEventListener("drop", (e) => {
    e.preventDefault();
    dropArea.style.backgroundColor = "#fff";
    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith("image")) {
        displayImage(file);
    }
});

// 파일 입력 필드 변경 이벤트 처리
fileInput.addEventListener("change", () => {
    const file = fileInput.files[0];
    $("#drop-area").hide();
    if (file && file.type.startsWith("image")) {
        displayImage(file);
    }
});

// 클릭 이벤트 처리
dropArea.addEventListener("click", () => {
    fileInput.click();
});

// 이미지 표시 함수
function displayImage(file) {
    const reader = new FileReader();
    reader.onload = () => {
        imagePreview.src = reader.result;
        imagePreview.style.display = "block";
    };
    reader.readAsDataURL(file);
}
</script>

<!-- 화상이랑 화면공유 -->
<script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<script>
/* 코딩테스트 화면공유 */
	const video = document.getElementById('video');

	var peer2 = new Peer('client3', {
 	      host: '192.168.36.103',
	      port: 8001,
	      path: '/'
	    });
	
	peer2.on('call', function(call) {
		navigator.mediaDevices.getUserMedia({video : true, audio : true}).then(function (stream) {
			call.answer(stream);
			
			call.on('stream', function(stream) {
				video.srcObject = stream;
			});
			
		}).catch(function (error) {
			console.log(error);
		});
	});
	
	/* 화상 */
	// 여기부터
	const localVideo = document.getElementById('local_video');
	const RemoteVideo = document.getElementById('remote_video');

    var peer = new Peer('client4', {
      host: '192.168.36.103',
      port: 8001,
      path: '/'
    });
    
    peer.on('connection', conn => {
	    console.log('다른 클라이언트가 접속했습니다.')
	});
    
    peer.on('call', function(call) {
    	navigator.mediaDevices.getUserMedia({video : true, audio : true}).then(function (stream) {
			localVideo.srcObject = stream;
			call.answer(stream);
			
			call.on('stream', function(stream) {
				$('#noDisplay *').hide();
				RemoteVideo.srcObject = stream;
			});
			
		}).catch(function (error) {
			console.log(error);
		});
	});
    

</script>

<!-- 모나코 에디터 -->
<script src="${ctxp}/resources/monacoEditorLib/min/vs/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/monaco-editor"></script>

<!-- 모달 이벤트 -->
<script type="text/javascript">


$(".disQualifyBtn").click(function(){
	if(confirm("해당 지원자를 실격처리 하시겠습니까?"))
	{
		// ex) evalueIvModal
		
		
		
		//문서 확인 상태로 변경
		$.ajax({
	        type: "POST",
	        url: "${ctxp}/entapply/disQualifyCt.do",
	        data: {
	        	prMbrId :prMbrId,
	        	resNo : resNo,
	        	empmnPbancNo : empmnPbancNo
	        	},
	        success: function(response) 
	        {
	        	   if (response === "OK") 
	        	   {
	                 	location.reload();
	               } 
	        }
	    });
		
	}
	
})

// 버튼 클릭 시 모달 열기(평가하기)
$('.openModalBtn').click(function() {
	
	 row = $(this).closest('.applicantOne');
	// 리스트에서 선택한 요소의 데이터 가져옴
	 prMbrId = row.find(".prMbrId").val();
	 resNo = row.find(".resNo").val();
	 docChkYn = row.find(".docChkYn").val();
	 docPassYn = row.find(".docPassYn").val();
	 docEvalue = row.find(".docEvalue").val();
	 codingPassYn = row.find(".codingPassYn").val();
	 codingEvalue = row.find(".codingEvalue").val();
	 interviewPassYn = row.find(".interviewPassYn").val();
	 interviewEvalue = row.find(".interviewEvalue").val();
	 resumeFile = row.find(".resumeFile").val();
	 setInspCtView = row.find(".setInspCtView").val();
	 empmnPbancNo = "${empmnPbancNo}";
	 
	 ivQ1 = row.find(".ivQ1").val();
	 ivQ2 = row.find(".ivQ2").val();
	 ivQ3 = row.find(".ivQ3").val();
	 ivQ4 = row.find(".ivQ4").val();
	 ivQ5 = row.find(".ivQ5").val();
	 ivQ6 = row.find(".ivQ6").val();
	 ivQ7 = row.find(".ivQ7").val();
	 ivQ8 = row.find(".ivQ8").val();
	 ivQ9 = row.find(".ivQ9").val();
	 ivQ10 = row.find(".ivQ10").val();
	 
	 ctQ1 = row.find(".ctQ1").val();
	 ctQ2 = row.find(".ctQ2").val();
	 ctQ3 = row.find(".ctQ3").val();
	 ctQ4 = row.find(".ctQ4").val();
	 ctQ5 = row.find(".ctQ5").val();
	 
	if(docChkYn == 'N')
	{
	  	//문서 확인 상태로 변경
		$.ajax({
	        type: "POST",
	        url: "${ctxp}/entapply/setDocChkY.do",
	        data: {
	        	prMbrId :prMbrId,
	        	resNo : resNo,
	        	empmnPbancNo : empmnPbancNo
	        	},
	        success: function(response) 
	        {
	        	   if (response === "OK") 
	        	   {
	                  	return;
	               } 
	        }
	    });
	}
	// 모달 열기
	$("#evalueDocModal").modal('show');
  	
});


//버튼 클릭 시 모달 열기
$('.closeModalBtn').click(function() {
	// 페이지 새로고침 전 페이드 아웃 효과
	document.body.style.transition = 'opacity 0.3s ease';
	document.body.style.opacity = 0;
	// 페이지 새로고침
	location.reload(true); 
});


$("#evalueDocModal").on('show.bs.modal', function () 
{
	    // 모달 내의 숨겨진 input 엘리먼트에 값을 설정
	    // 모달에 값 설정
	$(this).find("input[name='prMbrId']").val(prMbrId);
	$(this).find("input[name='resNo']").val(resNo);
	$(this).find("input[name='docPassYn'][value='" + docPassYn + "']").prop('checked', true);
	$(this).find("textarea[name='docEvalue']").val(docEvalue);

	//코딩 합격 여부 체크 후 합격 아니면 초기화면으로 이동
	$(this).find("input[name='codingPassYn']").val(codingPassYn);
	
	//이력서 출력
	$(this).find(".showRes").attr('src',resumeFile);
	
	// 코테 합격 여부 체크 후 메뉴 변경
	if(setInspCtView == '0')
	{
		$(".nav-link.menuCt").attr("data-bs-target", "#evalueCtModal");	
	}
	
	else if(setInspCtView == '1')
	{
		$(".nav-link.menuCt").attr("data-bs-target", "#inspCtModal");	
	}
	
    if(docPassYn != '')
    {
    	 $(this).find(".saveEvalueBtn").hide();
    	 $(this).find("input[name='docPassYn']").each(function(){
    		 $(this).prop('disabled', true);
    	 })
    	 $(this).find("textarea[name='docEvalue']").prop('readonly', true);
    }
    else
    {
    	$(this).find(".saveEvalueBtn").show();
    	$(this).find("input[name='docPassYn']").prop('disabled', false);
    	$(this).find("textarea[name='docEvalue']").prop('readonly', false);
    }
	    
});

/* 코테 평가 */
$('#evalueCtModal').on('shown.bs.modal', function () 
{
	(async function() {
	    try {
	        // 첫 번째 AJAX 요청
	        var getCtResultResponse = await fetch("${ctxp}/entapply/getCtResult.do", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify({
	                "empmnPbancNo": empmnPbancNo,
	                "prMbrId": prMbrId
	            })
	        });

	        if (!getCtResultResponse.ok) {
	            throw new Error("첫 번째 AJAX 요청이 실패했습니다.");
	        }
	        // 서버로부터의 응답을 JSON 형식으로 파싱
	        ctRes = await getCtResultResponse.json();

	        for(let i = 0 ; i < ctRes.length; i++)
	        {
	        	let sQTitle = ".qTitle" + (i + 1);
		  		$(sQTitle).text(ctRes[i].ENT_PQ_TTL);
	        }
	        
	        selAnswer = parseInt($("input[name='selAnswer']:checked").val());
	        
	        setTimeout(function () {
			      require.config({ paths: { 'vs': 'https://cdn.jsdelivr.net/npm/monaco-editor@latest/min/vs' } });
			      require(['vs/editor/editor.main'], function () {
			          var editor = monaco.editor.create(document.getElementById('ctResult'), {
			          		value: 
			          		"1번 문제 : " + ctRes[selAnswer-1].ENT_PQ_TTL + "\n\n" + ctRes[selAnswer-1].ENT_PQ_ANS + "\n",
							language: 'java',
							theme: 'vs-dark',
							minimap: { enabled: false },
							fontSize: 25,
							dimension: { width: '1000', height: '800' }, // 너비와 높이 설정
							readOnly : true
			          });
			      });
			  }, 0); // 적절한 지연 시간을 설정하여 조절
	        
	        
	        $("input[name='selAnswer']").change(function() {
	            // 체크된 요소의 값 가져오기
	            selAnswer = parseInt($("input[name='selAnswer']:checked").val());
	            $(".monaco-editor").each(function() {
	                $(this).remove(); // 각 monaco-editor 클래스를 가진 요소를 삭제합니다.
	            });
						  setTimeout(function () {
						      require.config({ paths: { 'vs': 'https://cdn.jsdelivr.net/npm/monaco-editor@latest/min/vs' } });
						      require(['vs/editor/editor.main'], function () {
						          var editor = monaco.editor.create(document.getElementById('ctResult'), {
						          		value: 
						          			selAnswer + "번 문제 : " + ctRes[selAnswer-1].ENT_PQ_TTL + "\n\n" + ctRes[selAnswer-1].ENT_PQ_ANS + "\n",
										language: 'java',
										theme: 'vs-dark',
										minimap: { enabled: false },
										fontSize: 25,
										dimension: { width: '1000', height: '800' }, // 너비와 높이 설정
										readOnly : true
						          });
						      });
						  }, 0); // 적절한 지연 시간을 설정하여 조절
	        });
	        
	      
	        
	        // 서버로부터의 응답이 배열 형태이고, 적어도 하나 이상의 요소가 있는지 확인
	        if (!Array.isArray(ctRes) || ctRes.length === 0) {
	            throw new Error("서버로부터의 응답이 유효하지 않습니다.");
	        }

	    } catch (error) {
	        // 오류 발생 시 처리
	        console.error("오류가 발생했습니다:", error);
	    }
	})();
	
		

	    $(this).find("input[name='prMbrId']").val(prMbrId);
	    $(this).find("input[name='resNo']").val(resNo);
	    $(this).find("input[name='codingPassYn'][value='" + codingPassYn + "']").prop('checked', true);
	    $(this).find("textarea[name='codingEvalue']").val(codingEvalue);
  
	    $(this).find("input[name='ctQ1'][value='" + ctQ1 + "']").prop('checked', true);
	    $(this).find("input[name='ctQ2'][value='" + ctQ2 + "']").prop('checked', true);
	    $(this).find("input[name='ctQ3'][value='" + ctQ3 + "']").prop('checked', true);
	    $(this).find("input[name='ctQ4'][value='" + ctQ4 + "']").prop('checked', true);
	    $(this).find("input[name='ctQ5'][value='" + ctQ5 + "']").prop('checked', true);
	    
	    
		if(codingPassYn != '')
		{
			 $(this).find(".saveEvalueBtn").hide();
			 $(this).find("input[name='codingPassYn']").prop('disabled', true);
			 $(this).find("textarea[name='codingEvalue']").prop('readonly', true);
			 
			 for(let i = 0 ; i < 31; i++)
			{
				let selBtn = "#q" + i;
				$(this).find(selBtn).prop('disabled', true);
			}

		}
		else
		{
			$(this).find(".saveEvalueBtn").show();
			$(this).find("input[name='codingPassYn']").prop('disabled', false);
			$(this).find("textarea[name='codingEvalue']").prop('readonly', false);
			
			for(let i = 0 ; i < 31; i++)
			{
				let selBtn = "#q" + i;
				$(this).find(selBtn).prop('disabled', false);
			}
		
		}
  
});


$('#evalueIvModal').on('shown.bs.modal', function () 
{
	    // 모달에 값 설정
	    $(this).find("input[name='prMbrId']").val(prMbrId);
	    $(this).find("input[name='resNo']").val(resNo);
	    $(this).find("input[name='interviewPassYn'][value='" + interviewPassYn + "']").prop('checked', true);
	    $(this).find("textarea[name='interviewEvalue']").val(interviewEvalue);

	    $(this).find("input[name='ivQ1'][value='" + ivQ1 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ2'][value='" + ivQ2 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ3'][value='" + ivQ3 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ4'][value='" + ivQ4 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ5'][value='" + ivQ5 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ6'][value='" + ivQ6 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ7'][value='" + ivQ7 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ8'][value='" + ivQ8 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ9'][value='" + ivQ9 + "']").prop('checked', true);
	    $(this).find("input[name='ivQ10'][value='" + ivQ10 + "']").prop('checked', true);
	    
	    
		if(interviewPassYn != '')
		{
			 $(this).find(".saveEvalueBtn").hide();
			 $(this).find("input[name='interviewPassYn']").prop('disabled', true);
			 $(this).find("textarea[name='interviewEvalue']").prop('readonly', true);
			 $(this).find("#file-input").prop('disabled',true);
			 for(let i = 0 ; i < 31; i++)
			 {
				let  selBtn = "#r" + i;	 
				 $(this).find(selBtn).prop('disabled', true);
			 }
			
		}
		else
		{
			$(this).find(".saveEvalueBtn").show();
			$(this).find("input[name='interviewPassYn']").prop('disabled', false);
			$(this).find("textarea[name='interviewEvalue']").prop('readonly', false);
			$(this).find("#file-input").prop('disabled',true);
			
			 for(let i = 0 ; i < 31; i++)
			 {
				let  selBtn = "#r" + i;	 
				 $(this).find(selBtn).prop('disabled', false);
			 }
		}
		
		
});


$(".saveEvalueBtn").on("click",function(){
	
	// ex) evalueIvModal
	let modalId = $(this).closest(".modal").attr('id');
	
	let sPrMbrId = $(this).closest(".modal").find("input[name='prMbrId']");
	let sResNo = $(this).closest(".modal").find("input[name='resNo']");
	let sSaveEvalueBtn = $(this).closest(".modal").find(".saveEvalueBtn");
	let sPassYn;
	let sEvalue;
	let empmnPbancNo = "${empmnPbancNo}";
	
	if(modalId == 'evalueDocModal'){	
		 sPassYn = $(this).closest(".modal").find("input[name='docPassYn']:checked");
		 sEvalue = $(this).closest(".modal").find("textarea[name='docEvalue']");
		 evalue =
		 {
				empmnPbancNo : empmnPbancNo,
				modalId : modalId,
				prMbrId : sPrMbrId.val(),
				resNo : sResNo.val(),
				passYn : sPassYn.val(),
				comment : sEvalue.val(),
		 };
		
	}
	else if(modalId == 'evalueCtModal'){
		 sPassYn = $(this).closest(".modal").find("input[name='codingPassYn']:checked");
		 sEvalue = $(this).closest(".modal").find("textarea[name='codingEvalue']");
		 evalue =
		 {
				empmnPbancNo : empmnPbancNo,
				modalId : modalId,
				prMbrId : sPrMbrId.val(),
				resNo : sResNo.val(),
				passYn : sPassYn.val(),
				comment : sEvalue.val(),
				ctQ1 : $(this).closest(".modal").find("input[name='ctQ1']:checked").val(),
				ctQ2 : $(this).closest(".modal").find("input[name='ctQ2']:checked").val(),
				ctQ3 : $(this).closest(".modal").find("input[name='ctQ3']:checked").val(),
				ctQ4 : $(this).closest(".modal").find("input[name='ctQ4']:checked").val(),
				ctQ5 : $(this).closest(".modal").find("input[name='ctQ5']:checked").val()
		 };
	}
	else if(modalId == 'evalueIvModal'){
		 sPassYn = $(this).closest(".modal").find("input[name='interviewPassYn']:checked");
		 sEvalue = $(this).closest(".modal").find("textarea[name='interviewEvalue']");
		 evalue = 
			 {		
				empmnPbancNo : empmnPbancNo,
				modalId : modalId,
				prMbrId : sPrMbrId.val(),
				resNo : sResNo.val(),
				passYn : sPassYn.val(),
				comment : sEvalue.val(),
				ivQ1 : $(this).closest(".modal").find("input[name='ivQ1']:checked").val(),
				ivQ2 : $(this).closest(".modal").find("input[name='ivQ2']:checked").val(),
				ivQ3 : $(this).closest(".modal").find("input[name='ivQ3']:checked").val(),
				ivQ4 : $(this).closest(".modal").find("input[name='ivQ4']:checked").val(),
				ivQ5 : $(this).closest(".modal").find("input[name='ivQ5']:checked").val(),
				ivQ6 : $(this).closest(".modal").find("input[name='ivQ6']:checked").val(),
				ivQ7 : $(this).closest(".modal").find("input[name='ivQ7']:checked").val(),
				ivQ8 : $(this).closest(".modal").find("input[name='ivQ8']:checked").val(),
				ivQ9 : $(this).closest(".modal").find("input[name='ivQ9']:checked").val(),
				ivQ10 : $(this).closest(".modal").find("input[name='ivQ10']:checked").val()
			 };
	}

	
	var evalueData = JSON.stringify(evalue);

		if(confirm(`결과를 저장하시겠습니까? 저장 후에는 지원자에게 문자로 결과가 통보되며 결과는 수정할 수 없습니다.`))
			{
				$.ajax({
		            type: "POST",
		            contentType: 'application/json',
		            data: evalueData,
		            url: "${ctxp}/entapply/savePassRes.do",
		            success: function(response) 
		            {
		            	   if (response === "OK") 
		            	   {
		            			alert("저장 되었습니다");	
		            			if(modalId == 'evalueDocModal')
		            			{
		            				$("input[name='docPassYn']").prop('disabled',true);
		            			}
		            			if(modalId == 'evalueCtModal')
		            			{
		            				$("input[name='ctQ1']").prop('disabled',true);
			            			$("input[name='ctQ2']").prop('disabled',true);
			            			$("input[name='ctQ3']").prop('disabled',true);
			            			$("input[name='ctQ4']").prop('disabled',true);
			            			$("input[name='ctQ5']").prop('disabled',true);
			            			$("input[name='codingPassYn']").prop('disabled',true);
		            			}
		            			if(modalId == 'evalueIvModal')
		            			{
		            				$("input[name='ivQ1']").prop('disabled',true);
		            				$("input[name='ivQ2']").prop('disabled',true);
		            				$("input[name='ivQ3']").prop('disabled',true);
		            				$("input[name='ivQ4']").prop('disabled',true);
		            				$("input[name='ivQ5']").prop('disabled',true);
		            				$("input[name='ivQ6']").prop('disabled',true);
		            				$("input[name='ivQ7']").prop('disabled',true);
		            				$("input[name='ivQ8']").prop('disabled',true);
		            				$("input[name='ivQ9']").prop('disabled',true);
		            				$("input[name='ivQ10']").prop('disabled',true);
		            				$("input[name='interviewPassYn']").prop('disabled',true);
		            			}
		            			
		            			/* 비활성화 */
		            			sSaveEvalueBtn.hide();
		            			sEvalue.prop('readonly', true);
		                      	return;
		                   } 
		            }
		        });
			}	
		
})

$("#autoDocBtn").on("click",function(){
	$("#docPassY").prop('checked',true);
})



$("#autoCtBtn").on("click",function(){
	$("input[name='ctQ1'][value='2']").prop('checked',true);
	$("input[name='ctQ2'][value='5']").prop('checked',true);
	$("input[name='ctQ3'][value='2']").prop('checked',true);
	$("input[name='ctQ4'][value='3']").prop('checked',true);
	$("input[name='ctQ5'][value='3']").prop('checked',true);
	$("#codingPassY").prop('checked',true);
})


$("#autoIvBtn").on("click",function(){
	$("input[name='ivQ1'][value='2']").prop('checked',true);
	$("input[name='ivQ2'][value='5']").prop('checked',true);
	$("input[name='ivQ3'][value='2']").prop('checked',true);
	$("input[name='ivQ4'][value='5']").prop('checked',true);
	$("input[name='ivQ5'][value='5']").prop('checked',true);
	$("input[name='ivQ6'][value='2']").prop('checked',true);
	$("input[name='ivQ7'][value='5']").prop('checked',true);
	$("input[name='ivQ8'][value='3']").prop('checked',true);
	$("input[name='ivQ9'][value='5']").prop('checked',true);
	$("input[name='ivQ10'][value='3']").prop('checked',true);
	$("input[name='interviewPassYn'][value='Y']").prop('checked',true);
})
</script>