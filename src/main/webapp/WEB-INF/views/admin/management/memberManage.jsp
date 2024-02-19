<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
.card{
	width: 70%;
	margin-left: 23%;
	margin-top: 5%;
}

#searchForm{
	margin: 10px 0;
}
</style>
    
<!-- Modal -->
<form action="/admin/manage/updateMemberInfo.do" method="post" id="memberInfoForm">
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">일반회원 상세정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>이름</p>
					<input type="text" class="form-control" name="prMbrNm" id="prMbrNm"><br/>
					<p>아이디</p>
					<input type="text" class="form-control" name="prMbrId" id="prMbrId" readonly><br/>
					<p>닉네임</p>
					<input type="text" class="form-control" name="prMbrNcnm" id="prMbrNcnm"><br/>
					<p>전화번호</p>
					<input type="text" class="form-control" name="prMbrTelno" id="prMbrTelno"><br/>
					<p>E-Mail</p>
					<input type="text" class="form-control" name="prMbrEmail" id="prMbrEmail"><br/>
					<p>생년월일</p>
					<input type="text" class="form-control" name="prMbrBirthdy" id="prMbrBirthdy"><br/>
					<p>성별</p>
					<input type="text" class="form-control" name="sexdstnCd" id="sexdstnCd" readonly><br/>
					<p>주소</p>
					<input type="text" class="form-control" name="prMbrAddress" id="prMbrAddress" readonly><br/>
					<p>가입일자</p>
					<input type="text" class="form-control" name="prMbrJoinYmd" id="prMbrJoinYmd" readonly><br/>
					<p>약관동의 여부</p>
					<input type="text" class="form-control" name="trmsAgreCd" id="trmsAgreCd" readonly><br/>
					<p>활동정지 처분</p>
					<select name="useStopCnt" id="useStopCnt" class="form-select" aria-label="Default select example">
						<option value="" disabled>선택하세요.</option>
						<option value="1">1일</option>
						<option value="3">3일</option>
						<option value="5">5일</option>
						<option value="7">7일</option>
						<option value="0">해제</option>
					</select><br/>
					<p>활동정지 일자</p>
					<input type="text" class="form-control" name="useStopEndYmd" id="useStopEndYmd" readonly><br/>
				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-success" value="수정하기" id="updateBtn"/>
					<input type="button" class="btn btn-danger" value="취소하기" data-bs-dismiss="modal"/>
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
                <h2 class="py-3 text-center font-bold font-up blue-text">일반회원 목록</h2>
            </div>
            <!-- Grid column -->
        </div>
        <!-- Grid row -->
        <!-- Search -->
        <form class="input-group input-group-sm" id="searchForm" method="post" style="width: 440px;">
			<input type="hidden" name="page" id="page"> 
			<select class="form-control" name="searchType">
				<option value="name" <c:if test="${searchType eq 'name' }">selected</c:if>>이름</option>
				<option value="id" <c:if test="${searchType eq 'id' }">selected</c:if>>아이디</option>
			</select> 
			<input type="text" class="form-control float-right" name="searchWord" value="${searchWord }" placeholder="Search">
			<button type="submit" class="btn btn-primary">검색</button>
		</form>
        <!-- Search -->
        <!--Table-->
        <table class="table table-hover table-responsive mb-0">
            <!--Table head-->
            <thead>
                <tr>
                    <th scope="row" width="4%" align="center">번호</th>
                    <th class="th-lg" align="left">아이디</th>
                    <th class="th-lg" align="left">이름</th>
                    <th class="th-lg" align="left">닉네임</th>
                    <th class="th-lg" align="left">가입일자</th>
                    <th class="th-lg" align="left">이메일</th>
                </tr>
            </thead>
            <!--Table head-->
            <!--Table body-->
            <tbody id="tBody">
				<c:set value="${pagingVO.dataList }" var="memberList" />
				<c:choose>
					<c:when test="${empty memberList }">
						<tr>
							<td colspan="5" align="center">등록된 회원이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:set value="${pagingVO.totalRecord }" var="record"/>
						<c:forEach items="${memberList }" var="memberList">
							<tr data-id="${memberList.prMbrId }">
								<td align="center">
									${record }
									<c:set value="${record - 1 }" var="record"/>
								</td>
								<td align="left">${memberList.prMbrId }</td>
								<td align="left">${memberList.prMbrNm }</td>
								<td align="left">${memberList.prMbrNcnm }</td>
								<td align="left">${memberList.prMbrJoinYmd }</td>
								<td align="left">${memberList.prMbrEmail }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
                  <!--Table body-->
        </table>
        <!--Bottom Table UI-->
        <div class="d-flex justify-content-center">
            <!--Pagination -->
            <div class="card-footer clearfix" id="pagingArea">
				<a>${pagingVO.pagingHTML }</a>
			</div>
            <!--/Pagination -->
        </div>
        <!--Bottom Table UI-->
    </div>
</div>
<script>
$(function() {
	// 페이징을 처리할 때 사용 할 Element
	// pagingArea div 안에 ul과 li로 구성된 페이징 정보가 존재
	// 그 안에는 a태그로 구성된 페이지 정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $('#pagingArea');
	var searchForm = $('#searchForm');
	
	/* 일반회원 목록 */
	var tBody = $('#tBody');
	
	
	pagingArea.on('click', "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find('#page').val(pageNo);
		searchForm.submit();
	});
	
	/* 클릭시 멤버 상세보기 */
	tBody.on("click", "tr", function() {
		/* 일반회원 ID */
		var id = $(this).data("id");
		console.log(id);
		
		var data = {
			prMbrId : id
		}
		
		$.ajax({
			type : "post",
			url : "/admin/manage/memberDetailInfo",
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			success : function(res){	
				console.log("res : ", res);
				var prMbrAddress = res.prMbrBscAddr + res.prMbrDaddr + "(" + res.prMbrZip + ")";
				console.log("prMbrAddress : ", prMbrAddress);
				
				if(res.sexdstnCd == "M"){
					res.sexdstnCd = "남자";
				}else if(res.sexdstnCd == "F"){
					res.sexdstnCd = "여자";
				}
				
				if(res.trmsAgreCd == "Y"){
					res.trmsAgreCd = "여";
				}else if(res.trmsAgreCd == "N"){
					res.trmsAgreCd = "부";
				}
				
				if(res.useStopCnt == "0" || res.useStopEndYmd == null){
					res.useStopEndYmd = "";
					res.useStopCnt = "";
				}
				
				$("#prMbrNm").val(res.prMbrNm);
				$("#prMbrId").val(res.prMbrId);
				$("#prMbrNcnm").val(res.prMbrNcnm);
				$("#prMbrTelno").val(res.prMbrTelno);
				$("#prMbrEmail").val(res.prMbrEmail);
				$("#prMbrBirthdy").val(res.prMbrBirthdy);
				$("#sexdstnCd").val(res.sexdstnCd);
				$("#prMbrAddress").val(prMbrAddress);
				$("#prMbrJoinYmd").val(res.prMbrJoinYmd);
				$("#trmsAgreCd").val(res.trmsAgreCd);
				$("#useStopCnt").val(res.useStopCnt);
				$("#useStopEndYmd").val(res.useStopEndYmd);
				
				$("#staticBackdrop").modal("show");
			}
		});
		
	});
	/* 클릭이벤트 끝 */
	
});
</script>