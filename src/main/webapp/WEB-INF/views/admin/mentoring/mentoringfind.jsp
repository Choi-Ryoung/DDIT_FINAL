<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<style>
    	.card{
   	    	width: 70%;
		    margin-left: 23%;
		    margin-top: 5%;
    	}
    	
    	#searchForm{
    		margin: 10px 0;
    	}
    	
    	.border3{
    		border 			: 1px solid lightgray;
    		border-radius	: 5px;
    	}
    </style>

<!-- 
<form action="/admin/mentoupdate" method="post" id="memberInfoForm">
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">채용설명회 등록창</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					
					<p>활동정지 처분</p>
						<select name="procCd" id="procCd" class="form-select" aria-label="Default select example">
							<option value="" disabled>선택하세요.</option>
							<option value="1">1일</option>
							<option value="3">3일</option>
							<option value="5">5일</option>
							<option value="0">해제</option>
						</select><br/>
					<p>활동정지 일자</p>
					<input type="text" class="form-control" name="procCd" id="procCd" readonly><br/>
				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-success" value="수정하기" id="updateBtn"/>
					<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
				</div>       
			</div>
		</div>
	</div>
</form> 
-->

<div class="card">
    <div class="card-body">
        <!-- Grid row -->
        <div class="row">
            <!-- Grid column -->
            <div class="col-md-12">
                <h2 class="py-3 font-bold font-up blue-text">${mento.menNcnm }</h2>
            </div>
            <!-- Grid column -->
        </div>
        			<form action="/admin/mentoupdate" method="post" id="memberInfoForm">
		<div>
					<input type="hidden" name="menNcnm" id="menNcnm" value="${mento.menNcnm }"/>
                	<div class="row align-items-center">
					<div class="col-sm-3 text-center">
						<c:set value="${mento.menFileList}" var="menFileList" />
                        <c:if test="${not empty menFileList}">
                            <div class="row">
                                <c:forEach items="${menFileList}" var="mentoFile">
                                    <c:choose>
                                        <c:when test="${fn:split(mentoFile.menFileMime, '/')[0] eq 'image'}">
                                            <img src="/resources/profile/${mento.menNcnm}/${fn:split(mentoFile.menFileSavepath, '/')[1]}" style="width: 14rem;" alt="img-blur-shadow">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty menFileList }">
                        	<img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg" style="width: 20rem;">
                        </c:if>
					</div>
					<div class="col-sm-9">
						<div class="col mt-2 mb-2 text-black fs-6 px-2 section-header" style="padding-top:5px;">멘토정보</div>
						<hr class="my-hr">
						<br>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">닉네임 : <c:out value="${mento.menNcnm}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">직무정보 : <c:out value="${mento.applyTaskCd}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">경력정보 : <c:out value="${mento.applyCareerCd}" escapeXml="true"></c:out></div>
						<div class="col mt-2 mb-2 text-black fs-6 px-2 info-item">
							<c:set value="${mento.tagList}" var="tagList"/>
                            <c:if test="${not empty tagList}">
                                <c:forEach items="${tagList}" var="tag">
                                    <c:if test="${tag ne null}">
                                        <span class="badge bg-warning">#<c:out value="${tag.menTag}" escapeXml="true"></c:out></span>
                                    </c:if>
                                    <c:if test="${tag eq null}"></c:if>
                                </c:forEach>
                            </c:if>
						</div>
						<br>
						<hr class="my-hr">
					</div>
				</div>
				<div class="col-md-12">
		<div class="text-black fs-6 px-2">소개글</div>
			<div class="text-black fs-6 px-2 career-item">
							<span class="ms-1 fs-5 career-title" style="white-space: pre-line">
								<c:out value="${mento.menIndt }"></c:out>
							</span><br>
									</div>
							</div>
			<hr class="me-hr"/>
                <br>
	               		<%-- <div class="row">
							    <div class="col-8 mb-3">
							        <label for="procCd" class="form-label">신입/경력</label>
							        <select id="procCd" name ="procCd" class="form-select" aria-label="Default select example">
							        	<c:forEach items="${proceedList}" var="proceedList" varStatus="vs">
							        		<c:if test="${proceedList.cmcd ne '01'}">
							        			<option value="${proceedList.cmcdNm}">${proceedList.cmcdNm}</option>
							        		</c:if>
							            </c:forEach>
							        </select>
							    </div>
							</div><hr> --%>
							
							<div class="row">
								<div class="col-3 mb-3">
							        <label for="procCd" class="form-label">진행상황</label>
							        <select id="procCd" name = "procCd" class="form-select" aria-label="Default select example">
							          	<c:forEach items="${proceedList}" var="proceedList" varStatus="vs">
							        		<option value="${proceedList.cmcdNm}">${proceedList.cmcdNm}</option>
							            </c:forEach>
							        </select>
							    </div>
							</div><hr>
							<div>
							<label for="rjctRsn" class="form-label">진행상황</label><br>
							<textarea class="col-8 mb-3" rows="5" cols="150" id="rjctRsn" name="rjctRsn" style="white-space: pre;"></textarea>
                			</div>
                		<div class="d-flex" style="margin-top:15px;">
						  	<!--Pagination -->
							<button type="submit" class="btn btn-outline-warning" id="modifyBtn">수정</button>
									<button type="button" class="btn btn-outline-info" id="listBtn" 
										onclick="javascript:location.href='/admin/mentolist'">목록</button>
						    <!--/Pagination -->
						</div>
						
                	</div>
                	</form>
    </div>
</div>			 
    

<script type="text/javascript">

var modifyBtn = $("#modifyBtn");
var memberInfoForm = $("#memberInfoForm");
var procCd = $("#procCd").val();
var procCd2 = "${mento.procCd }";
var rjctRsn = $("#rjctRsn");
console.log("rjctRsn : " + rjctRsn);
console.log("procCd2 : " + procCd2);
console.log("procCd : " + procCd);

$(function(){
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	rjctRsn.hide();
	
	$("select[name=procCd]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=procCd] option:selected").text()); //text값 가져오기
		  if($("select[name=procCd] option:selected").text() == "반려") {
			  rjctRsn.show();
		  } else if ($("select[name=procCd] option:selected").text() == "승인") {
			  rjctRsn.hide();
		  } else if ($("select[name=procCd] option:selected").text() == "대기중") {
			rjctRsn.hide();
		  }
		});
	
	
});

</script>
