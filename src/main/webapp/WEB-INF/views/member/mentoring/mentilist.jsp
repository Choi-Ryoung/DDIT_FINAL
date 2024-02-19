<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="${ctxp}/resources/css/member/mentilist.css" rel="stylesheet">
<!-- sh_wrapper [s] -->
<div id="sh_wrapper" class="sub">
    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <div id="sh_content">
           		<div class="col-md-12">
					<input type="hidden" name="prMbrId" id="mentiId" value="${mentiVO.prMbrId }"/>
					<input type="hidden" name="prMbrNcnm" id="mentiNcnm" value="${mentiVO.prMbrNcnm }"/>
					<input type="hidden" name="menNcnm" id="mentoNcnm" value="${mentiVO.menNcnm }"/>
				</div>
				<div>
					<input type="hidden" name="roomNo" id="roomNo" value="${roomVO.roomNo }"/>
				</div>
                <!-- 서브페이지 [s] -->
				<div class="container">
				  <ul class="responsive-table">
				    <li class="table-header">
				      <div class="col col-2" style="font-weight:bold; font-size:1.2rem; color:black;">멘티</div>
				      <div class="col col-3" style="font-weight:bold; font-size:1.2rem; color:black;">채팅방 이동</div>
				    </li>
				    <c:set value="${mentiList }" var="mentiList" />
				    <c:choose>
				    	<c:when test="${not empty mentiList }">
				    		<c:forEach items="${mentiList }" var="menti">
				    			<li class="table-row" id="mtList">
							      <div class="col col-2" data-label="멘티" style="font-weight:bold; font-size:1.2rem;">${menti.prMbrNcnm }</div>
							      <div class="col col-3" data-label="채팅방 이동">
							      	<button class="btn btn-warn" id="chatBtn">대화</button>
							      </div>
							    </li>
				    		</c:forEach>
				    	</c:when>
				    	<c:otherwise>
				    		<li class="table-row" id="mtList">
						      <div class="col col-2" style="font-weight:bold; font-size:1.2rem;">
						      	등록된 회원 정보가 없습니다.
						      </div>
						    </li>
				    	</c:otherwise>
				    </c:choose>
				   </ul>
				</div>
			</div>
            <!-- sh_content [s] -->            
        </div>
        <!-- sh_container_wrapper [e] -->
    </div>
    <!-- sh_container [e] -->
</div>

<script type="text/javascript">
$(function(){
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	/* var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	}); */
	
	var roomNo = "${roomVO.roomNo}";
	var chatBtn = $("#chatBtn");
	var menNcnm = "${mentoInfo.menNcnm}";
	var prNcnm = "${SessionInfo.prMbrNcnm}";
	var mentiNcnm = $("#mentiNcnm").val()
	var list = $(".table-row");
	console.log("멘티 닉네임 확인 : ", mentiNcnm);
	console.log("li 확인 : ", list);
	console.log("닉네임 확인 : ", menNcnm);
	console.log("멘토 닉네임 확인 : ", prNcnm);
	console.log("roomNo : ", roomNo);
	
	chatBtn.on("click", function(){
		location.href = "/mento/chat?roomNo="+roomNo;
	})
	
});
</script>



