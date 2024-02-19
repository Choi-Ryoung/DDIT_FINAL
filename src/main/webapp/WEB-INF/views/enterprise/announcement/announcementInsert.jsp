<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<c:set value="등록하기" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정하기" var="name"/>	
	</c:if>

 
    <div id="sh_container"> 
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <div id="greeting" class="pagecommon">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-outline card-danger mt-4">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/채용공고.jpg" width="1100px" height="300px">
								</div>
							</div>
						</div>
					</div>
					                	
						<div class="card-body">
							<form action="/announcement/insert.do" method="post" id="announcementForm">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="empmnPbancNo" value="${employment.empmnPbancNo }"/>
									<%-- <input type="hidden" namte="empmnPbancWrtrNm" value="${employment.empmnPbancWrtrNm }"/> --%>
								</c:if>
								<div class="row">
									<div class="col-7 mb-3">
								        <label for="empmnPbancTtl" class="form-label">제목</label>
										<div class="col-auto">
										    <input type="text" id ="empmnPbancTtl" name = "empmnPbancTtl" class="form-control" placeholder="" value="${employment.empmnPbancTtl }">
										</div>
									</div> 
									<div class="col-2 mb-3">
								        <label for="salary" class="form-label">급여</label>
										<div class="col-auto">
										    <input type="text" id ="salary" name = "salary" class="form-control" placeholder="" value="${employment.salary }">
										</div>
									</div>
								</div><br>
								<div class="row">
									<div class="col-2 mb-3">
								        <label for="empmnPbancDdlnYmd" class="form-label">채용마감일자</label>
										<div class="col-auto">
										    <input type="date" id ="empmnPbancDdlnYmd" name = "empmnPbancDdlnYmd" class="form-control" placeholder="" value="${employment.empmnPbancDdlnYmd}">
										</div>
									</div>
									<div class="col-2 mb-3">
								        <label for="docPassYmd" class="form-label">이력서 마감일자</label>
										<div class="col-auto">
										    <input type="date" id ="docPassYmd" name = "docPassYmd" class="form-control" placeholder="" value="${employment.docPassYmd}">
										</div>
									</div>
									<div class="col-2 mb-3">
								        <label for="interviewPassYmd" class="form-label">면접 응시일자</label>
										<div class="col-auto">
										    <input type="date" id ="interviewPassYmd" name = "interviewPassYmd" class="form-control" placeholder="" value="${employment.interviewPassYmd}">
										</div>
									</div>
									<div class="col-2 mb-3">
								        <label for="codingPassYmd" class="form-label">코딩테스트 응시일자</label>
										<div class="col-auto">
										    <input type="date" id ="codingPassYmd" name = "codingPassYmd" class="form-control" placeholder="" value="${employment.codingPassYmd}">
										</div>
									</div>
								</div><br>
														
								<div class="row">
									<div class="col-2 mb-3">
								        <label for="genderCd" class="form-label">성별</label>
								        <select id="genderCd" name = "genderCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${genderList}" var="gender" varStatus="vs">
								        		<option value="${gender.cmcd}" <c:if test="${employment.genderCd eq gender.cmcdNm }">selected</c:if>>${gender.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								    &emsp;  &emsp;
								    <div class="col-2 mb-3">
								        <label for="dutyCd" class="form-label">직무</label>
								        <select id="dutyCd" name = "dutyCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="duty" varStatus="vs">
								        		<option value="${duty.cmcd}" <c:if test="${employment.dutyCd eq duty.cmcdNm }">selected</c:if>>${duty.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>    
								    &emsp;  &emsp;
									 <div class="col-2 mb-3">
								        <label for="workType" class="form-label">근무형태</label>
								        <select id="workType" name = "workType" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${workTypeList}" var="workType" varStatus="vs">
												<option value="${workType.cmcd}" <c:if test="${employment.workType eq workType.cmcdNm }">selected</c:if>>${workType.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								    &emsp;  &emsp;
								    <div class="col-2 mb-3">
								        <label for="careerCd" class="form-label">경력</label>
								        <select id="careerCd" name ="careerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="career" varStatus="vs">
								        		<c:if test="${career.cmcd ne '01'}">
								        			<option value="${career.cmcd}" <c:if test="${employment.careerCd eq career.cmcdNm }">selected</c:if>>${career.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div> 
								</div><br>
								
								<div class="row">
								    <div class="col-3 mb-3">
								        <label for="acbgCd" class="form-label">학력</label>
								        <select id="acbgCd" name = "acbgCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${acbgList}" var="acbg" varStatus="vs">
												<option value="${acbg.cmcd}" <c:if test="${employment.acbgCd eq acbg.cmcdNm }">selected</c:if>>${acbg.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								    &emsp;  &emsp;
								    <div class="col-2 mb-3">
								        <label for="rgn" class="form-label">지역</label>
								        <select id="rgn" name = "rgn" class="form-select" aria-label="Default select example">
								       	 <option value="">선택</option>
								        	<c:forEach items="${rgnList}" var="rgn" varStatus="vs">
												<option value="${rgn.cityCd}" <c:if test="${employment.rgnCd eq rgn.cityCd }">selected</c:if>>${rgn.cityNm}</option>
								            </c:forEach>
								        </select>
								     </div>
								  	 &emsp;  &emsp;
								     <div class="col-2 mb-3">
								        <label for="sigungu" class="form-label">구</label>
								        <select id="sigungu" name = "sigungu" class="form-select" aria-label="Default select example">
								        	<c:if test="${not empty employment.sigungu}">
									        	<c:forEach items="${sigunguList}" var="sigungu" varStatus="vs">
													<option value="${sigungu.countyCd}" <c:if test="${employment.sigungu eq sigungu.countyNm }">selected</c:if>>${sigungu.countyNm}</option>
									            </c:forEach>
								        	</c:if>
								        </select>
								    </div>
								    &emsp;  &emsp;
									<div class="col-2 mb-3">
								        <label for="workHr" class="form-label">근무시간</label>
										<div class="col-auto">
										    <input type="text" id ="workHr" name = "workHr" class="form-control" value="${employment.workHr }">
										</div>
									</div>
								</div><br>
								
								<div class="form-group">
										<label for="empmnPbancCn">채용 공고 내용</label>
										<textarea id="empmnPbancCn" name="empmnPbancCn" class="form-control" rows="10">${employment.empmnPbancCn }</textarea>
								</div><br><br>

								<div class="d-grid gap-2 d-md-flex justify-content-md-center">
									<div class="row justify-content-center">
									    <div class="input-group mb-3 text-center">
									        <div class="form-group clearfix">
									            <input type="button" value="${name }" class="btn me-md-2 fas btn btn-success" id="intBtn">
									            <div class="icheck-primary d-inline">
									                <button type="button" class="btn btn-secondary btn-inline" id="backBtn">뒤로가기</button>&nbsp;&nbsp;&nbsp;
									                <c:if test="${status ne 'u' }">
									                	<button type="button" class="btn btn-primary btn-inline" id="autoSet">자동완성</button>
									                </c:if>
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

						

         
<script>

    
$(function() {
	
	if(`${status}`)
	{
		console.log(`${status}`);
		
		console.log(`${employment.empmnPbancDdlnYmd}`);
		let date1 = `${employment.empmnPbancDdlnYmd}`;
		console.log(date1);
		
		const dateParts = date1.split(' ')[0].split('-');
		const year = dateParts[0];
		const month = dateParts[1];
		const day = dateParts[2];
		const updDate = `\${year}-\${month}-\${day}`;
		console.log(updDate);
		$('#empmnPbancDdlnYmd').val(updDate);
	}
	
	var backBtn = $("#backBtn");
	var intBtn = $("#intBtn");
	var announcementForm = $("#announcementForm");
	
	backBtn.on("click", function(){
		location = "/announcement/list";
	});
	
	// 지역 셀텍트 박스 값이 변경될때 이벤트
	$('#rgn').on('change', function() {
		const _cityCd = $(this).val();
		if(_cityCd) {
			$.ajax({
	            type: "POST",
	            async: false,
	            url: "/announcement/countyList",
	            data: { cityCd: _cityCd },
	            success: function (result) {
	            	if(result) {
	            		$('#sigungu').empty();
		            	for(let i=0; i< result.length; i++) {
		            		$('#sigungu').append("<option value='"+result[i].countyCd+"'>"+result[i].countyNm+"</option>");
		            	}
	            	}
	            },
	            error: function () {
	                alert("서버 오류 발생. 다시 시도해주세요.");
	            }
	        });
		} else {
			$('#sigungu').empty();
		}
	});
	
	
	//등록 버튼 클릭 시, 등록 진행
	intBtn.on("click", function(){
		if($(this).val() == "수정하기"){
			announcementForm.attr("action", "/announcement/update.do");
		}
		announcementForm.submit();
	});
	
	
	
	$('#autoSet').on("click", function(){
		$('input[name = "empmnPbancTtl"]').val('보안 솔루션 웹 개발자 (3년 이상~)');
		$('input[name = "salary"]').val('협의 후 결정');
		$('input[name = "empmnPbancDdlnYmd"]').val('2023-03-22');
		$('input[name = "docPassYmd"]').val('2023-03-25');
		$('input[name = "interviewPassYmd"]').val('2023-03-28');
		$('input[name = "codingPassYmd"]').val('2023-04-02');
		$('select[name = "genderCd"]').val('M');
		$('select[name = "dutyCd"]').val('03');
		$('select[name = "workType"]').val('03');
		$('select[name = "careerCd"]').val('05');
		$('select[name = "acbgCd"]').val('03');
		$('select[name = "rgn"]').val('30');
		$('select[name = "rgn"]').trigger("change");
		$('select[name = "sigungu"]').val('25040');
		$('input[name = "workHr"]').val('10시 ~ 7시 탄력근무');
		$('textarea[name = "empmnPbancCn"]').val(`주요업무
• IT 보안솔루션 프론트엔드 및 백엔드 웹 개발

자격요건
• IT 관련 전공자
• Java, javascript, Spring framework, SpringBoot, 템플릿 엔진(JSP, Thymeleaf 등) 프로그래밍 가능자
• PostgreSQL, MySQL, Oracle 등 RDBMS 경험자
• 기본적인 Linux 명령어 사용 가능자

우대사항
• 빌드/테스트/배포 자동화 경험자 우대
• Java Network Programming 경험
• JPA, Hibernate 등 ORM 사용과 도메인 모델링 경험자 우대
• Vue.js, React.js 및 RESTful API 경험자 우대
• 다양한 오픈소스SW 활용 경험자 우대
• 관련 자격사항 및 경력자 우대

복지 및 혜택
1) 유연한 업무환경
• 선택적 근로시간제, 부서 재량 원격 (재택)근무 운영
• 자유로운 복장 근무

2) 최상의 업무 환경
• 고사양 최신장비 지원
• 사내 안마의자, 마사지케어
• 조식, 스낵바 운영 (음료, 커피, 간식 무제한)
• 카페테리아 운영 (직원들 힐링 공간)

3) 자기계발 지원
• 직무 교육비 무제한 지원 (외국어도 가능!)
• 도서 구매 지원 (만화책, 가족도서도 구매 가능!)
• 직무 발명 보상 제 운영 (특허출원 시 지원)

4) 직원/가족복지 지원
• 체력 단련비 지원 (운동 하면서 지원금도 받고 내 몸도 챙기고~)
• 종합 건강 검진 지원 (MRI/CT/초음파/내시경 등)
• 가족 종합 건강 검진 지원
• 가족 장례 서비스 지원
• 보육료, 자녀학자금 지원

5) 친목 및 교류
• 사내 동호회 운영
• 힐링 및 친목을 위한 사내 워크샵
• 신년행사, 송년회, 팀 회식 운영

6) 행복한 복지
• 5년 단위 장기 근속 포상, 인재 추천 포상
• 리프레시 휴가, 휴가샵 운영
• 생일선물, 명절선물, 가정의달 선물 지원
• 시즌 별 굿즈 선물
채용절차 및 기타 지원 유의사항
[근무 형태]
• 3개월 수습 이후 정규 채용 / 주 5일 (월~금) 근무

[서류 접수]
• 이력서/자기소개서/포트폴리오

[채용 절차]
• 서류지원 ＞ 실무진면접 ＞ 처우 협의 ＞ 임원면접 ＞ 최종합격

1) 서류심사
직무 관련 경험의 깊이와 직무/생활 속에서 문제를 해결하는 능력 및 방식을 중점적으로 확인합니다.

2) 실무면접
지원서류에 기재된 직무관련 사항에 관하여, 기존에 무엇을 해왔으며, 어떤 방식으로 실무적 성장을 하였는지 중점적으로 확인합니다.

3) 처우협의
출근 날짜, 근무지(대전/판교), 연봉 등을 협의합니다.

4) 임원면접
실무면접 결과를 토대로 추가 확인이 필요한 인성, 가치관 등 실무 외적인 사항 전반을 중점적으로 확인합니다.

5) 최종합격
최종합격 내용을 전달 드리며, 입사 일자를 확정 합니다.

* 대면 면접을 기본으로 하고 있으며, 부득이하게 어려울 경우 화상 면접 가능합니다.

* 면접 시 면접비를 기본적으로 지원해 드리고 있습니다. (대면면접)`);
		
	});
	
	
	
		
});

</script>