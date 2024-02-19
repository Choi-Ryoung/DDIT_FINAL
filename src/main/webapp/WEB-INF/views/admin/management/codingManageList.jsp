<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="card">
    <div class="card-body">
        <!-- Grid row -->
        <div class="row">
            <!-- Grid column -->
            <div class="col-md-12">
                <h2 class="py-3 text-center font-bold font-up blue-text">코딩테스트 연습문제 목록</h2>
            </div>
            <!-- Grid column -->
        </div>
        <!-- Grid row -->
        <!-- Search -->
        <form class="input-group input-group-sm" id="searchForm" method="post" style="width: 440px;">
			<input type="hidden" name="page" id="page"> 
			<select class="form-control" name="searchType">
				<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
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
                    <th scope="row" width="8%" align="right">번호</th>
                    <th class="th-lg" width="" align="left">제목</th>
                    <th class="th-lg" width="8%" align="left">난이도</th>
                </tr>
            </thead>
            <!--Table head-->
            <!--Table body-->
            <tbody>
				<c:set value="${pagingVO.dataList }" var="codeList" />
				<c:choose>
					<c:when test="${empty codeList }">
						<tr>
							<td colspan="3" align="center">등록된 문제가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${codeList }" var="codeList">
							<tr>
								<th scope="row" align="right">${codeList.prctQuesNo }</th>
								<td align="left"><a href="/admin/manage/codingTestManageDetail?prctQuesNo=${codeList.prctQuesNo }">${codeList.prctQuesTtl }</a></td>
								<td align="left">
									Lv.${codeList.prctQuesDfflyCd }
							 	</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
                  <!--Table body-->
        </table>
        <div style="min-height: 50px;">
        	<button type="button" class="btn btn-primary" style="margin-top: 6px; margin-left: 90%;" id="registerBtn">문제 등록</button>
        </div>
        <!--Bottom Table UI-->
        <div class="d-flex justify-content-center">
            <!--Pagination -->
            <div class="clearfix" id="pagingArea">
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
	var registerBtn = $('#registerBtn');
	
	pagingArea.on('click', "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find('#page').val(pageNo);
		searchForm.submit();
	});
	
	registerBtn.on('click', function(){
		location.href = "/admin/manage/insertCodingTest";
	});
	
});
</script>