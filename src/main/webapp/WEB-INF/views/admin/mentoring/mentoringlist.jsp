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

<form action="/admin/manage/updateMemberInfo.do" method="post" id="memberInfoForm">
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">채용설명회 등록창</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>닉네임</p>
					<p id="menNcnm"></p>
				<div class="modal-footer">
					<input type="submit" class="btn btn-success" value="수정하기" id="updateBtn"/>
					<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
				</div>       
			</div>
		</div>
	</div>
	</div>
</form>

<div class="card">
    <div class="card-body">
        <!-- Grid row -->
        <div class="row">
            <!-- Grid column -->
            <div class="col-md-12">
                <h2 class="py-3 text-center font-bold font-up blue-text">멘토 회원 목록</h2>
            </div>
            <!-- Grid column -->
        </div>
		<div>
			<form class="input-group input-group-sm" method="post" id="searchForm" style="width: 440px;">
				<input type="hidden" name="page" id="page"/>
				<select class="form-control" name="searchType">
					<option value="job" <c:if test="${searchType eq 'job' }">selected</c:if>>직무별 검색</option>
					<option value="enterprise" <c:if test="${searchType eq 'enterprise' }">selected</c:if>>기업명</option>
					<option value="career" <c:if test="${searchType eq 'career' }">selected</c:if>>경력</option>
				</select>
				<input type="text" name="searchWord" value="${searchWord }" class="form-control float-right" placeholder="Search">
				<div class="input-group-append">
					<button type="submit" class="btn btn-default">
						<i class="fas fa-search btn btn-primary">검색</i>
					</button>
				</div>
			</form><br>
			<c:set value="${pagingVO.dataList }" var="mentoList"/>
			<c:set value="${dutyList }" var="duty"/>
			<c:set value="${careerList }" var="career"/>
			<c:choose>
				<c:when test="${empty mentoList }">
					<tr>
						<td colspan="5">등록된 글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${mentoList }" var="mentoVo" varStatus="vs">
						<div class="border3">
							<div class="card-body">
								<div class="d-flex flex-column flex-lg-row">
									<div class="row flex-fill">
										<div class="col-sm-4 py-2">
											<h4 class="h5" style="font-weight: bold;">
												<a href="/admin/find?menNcnm=${mentoVo.menNcnm}">${mentoVo.menNcnm}</a>
												<c:if test="${mentoVo.procCd eq '대기중'}">
													<span class="badge mr-3" style="color: darkgray; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
												</c:if>
												<c:if test="${mentoVo.procCd eq '승인'}">
													<span class="badge mr-3" style="color: blue; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
												</c:if>
												<c:if test="${mentoVo.procCd eq '반려'}">
													<span class="badge mr-3" style="color: red; background-color: white; border: solid darkgray;">${mentoVo.procCd }</span>
												</c:if>
											</h4>
											<span class="h6">${mentoVo.menPstCn }</span>
											<br>
											<span class="badge bg-warning mr-3">${mentoVo.applyTaskCd }</span>
											<span class="badge bg-warning mr-3">${mentoVo.applyCareerCd }</span><br>
										</div>
										<div class="row">
										
								</div><hr>
									</div>
								</div>
							</div>
						</div>											
					</c:forEach>
				</c:otherwise>
			</c:choose>  
		</div>
		<!-- 페이징 -->    
		<!--Bottom Table UI-->
		<div class="d-flex justify-content-center" style="margin-top:15px;">
		  	<!--Pagination -->
			<div class="card-footer clearfix" id="pagingArea">
				<a>${pagingVO.pagingHTML }</a>
			</div>
		    <!--/Pagination -->
		</div>
    </div>
</div>			 
    

<script type="text/javascript">

var registerBtn = $("#registerBtn");

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
	
	registerBtn.on("click", function(){
		location.href = "/mento/form";
	})
	
	
	
});

const fn_goFind = () => {
	
	var formData = { menNcnm : $('input[name=menNcnm]').val() };
	
	 // JavaScript 객체를 JSON 문자열로 변환
    var jsonData = JSON.stringify(formData);
 	var mpVo = {};
	$.ajax({
        type:"POST",
        url:"/admin/mentofind",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: jsonData,
        success:function(result) {
        	console.log("체크:",result);
        	$("#menNcnm").html(result);
        	
        	$("#staticBackdrop").modal("show");
				
        },
        error: function (error) {
            
        }
     });
	
	console.log(mpVo);
	
}


</script>
