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
    	
    	img{
    		/* border-radius: 50%; */
    		margin-left: 40%;
			/* border: 1px solid black; */
    	}
    </style>
    
<!-- Modal -->
<form action="/admin/manage/updateEntMemberInfo.do" method="post" id="entMemberInfoForm">
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">기업회원 상세정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p align="center">기업 로고</p>
					<img src="" alt="기업 로고.jpg" width="100px" height="100px" id="logoImg" name="logoImg"><br/>
					<p>아이디</p>
					<input type="text" class="form-control" name="entMbrId" id="entMbrId" readonly><br/>
					<p>사업자등록번호</p>
					<input type="text" class="form-control" name="brno" id="brno"><br/>
					<p>기업명</p>
					<input type="text" class="form-control" name="entNm" id="entNm"><br/>
					<p>기업 구분</p>
					<select name="entSe" id="entSe" class="form-select" aria-label="Default select example">
						<option value="" disabled>선택하세요.</option>
						<option value="major company">대기업</option>
						<option value="mid company">중견기업</option>
						<option value="small company">소기업</option>
					</select><br/>
					<p>E-Mail</p>
					<input type="text" class="form-control" name="entMbrEmail" id="entMbrEmail"><br/>
					<p>대표 전화번호</p>
					<input type="text" class="form-control" name="entRprsTelno" id="entRprsTelno"><br/>
					<p>담당자 전화번호</p>
					<input type="text" class="form-control" name="entPicTelno" id="entPicTelno"><br/>
					<p>주소</p>
					<input type="text" class="form-control" name="entMbrAddress" id="entMbrAddress" readonly><br/>
					<p>직원 수</p>
					<input type="text" class="form-control" name="empCnt" id="empCnt"><br/>
					<p>대표자명</p>
					<input type="text" class="form-control" name="rprsvNm" id="rprsvNm"><br/>
					<p>약관동의 여부</p>
					<input type="text" class="form-control" name="trmsAgreCd" id="trmsAgreCd" readonly><br/>
					<p>홈페이지 주소</p>
					<input type="text" class="form-control" name="hmpgAddr" id="hmpgAddr"><br/>
					<div class="form-group">
						<label for="exampleFormControlTextarea1">사업 내용</label>
						<textarea class="form-control" id="bizCn" name="bizCn" rows="3"></textarea>
					</div>
					<p>가입일자</p>
					<input type="text" class="form-control" name="entJoinYmd" id="entJoinYmd" readonly><br/>
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
					<input type="button" class="btn btn-secondary" value="취소하기" data-bs-dismiss="modal"/>
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
            <div class="col-md-8">
                <h2 class="py-3 text-center font-bold font-up blue-text">기업회원 목록</h2>
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
                    <th class="th-lg" align="left">기업명</th>
                    <th class="th-lg" align="left">대표번호</th>
                    <th class="th-lg" align="left">가입일자</th>
                    <th class="th-lg" align="left">이메일</th>
                </tr>
            </thead>
            <!--Table head-->
            <!--Table body-->
            <tbody id="tBody">
				<c:set value="${pagingVO.dataList }" var="entMemberList" />
				<c:choose>
					<c:when test="${empty entMemberList }">
						<tr>
							<td colspan="5" align="center">등록된 회원이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:set value="${pagingVO.totalRecord }" var="record"/>
						<c:forEach items="${entMemberList }" var="entMemberList">
							<tr data-id="${entMemberList.entMbrId }">
								<td align="center">
									${record }
									<c:set value="${record - 1 }" var="record"/>
								</td>
								<td align="left">${entMemberList.entMbrId }</td>
								<td align="left">${entMemberList.entNm }</td>
								<td align="left">${entMemberList.entRprsTelno }</td>
								<td align="left">${entMemberList.entJoinYmd }</td>
								<td align="left">${entMemberList.entMbrEmail }</td>
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
				entMbrId : id
		}
		
		$.ajax({
			type : "post",
			url : "/admin/manage/entMemberDetailInfo",
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			success : function(res){	
				console.log("res : ", res);
				var entMbrAddress = res.entBscAddr + res.entDaddr + "(" + res.entZip + ")";
				console.log("entMbrAddress : ", entMbrAddress);
				
				if(res.trmsAgreCd == "Y"){
					res.trmsAgreCd = "여";
				}else if(res.trmsAgreCd == "N"){
					res.trmsAgreCd = "부";
				}
				
				if(res.useStopCnt == "0" || res.useStopEndYmd == null){
					res.useStopEndYmd = "";
					res.useStopCnt = "";
				}
				
				$("#logoImg").attr("src", res.logoImg);
				$("#entMbrId").val(res.entMbrId);
				$("#brno").val(res.brno);
				$("#entNm").val(res.entNm);
				$("#entSe").val(res.entSe);
				$("#entMbrEmail").val(res.entMbrEmail);
				$("#entRprsTelno").val(res.entRprsTelno);
				$("#entPicTelno").val(res.entPicTelno);
				$("#entMbrAddress").val(entMbrAddress);
				$("#empCnt").val(res.empCnt);
				$("#rprsvNm").val(res.rprsvNm);
				$("#useStopCnt").val(res.useStopCnt);
				$("#useStopEndYmd").val(res.useStopEndYmd);
				$("#trmsAgreCd").val(res.trmsAgreCd);
				$("#hmpgAddr").val(res.hmpgAddr);
				$("#bizCn").val(res.bizCn);
				$("#entJoinYmd").val(res.entJoinYmd);
				
				$("#staticBackdrop").modal("show");
			}
		});
		
	});
	/* 클릭이벤트 끝 */
	
});
</script>