<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="${ctxp}/resources/css/member/paymentdetail.css" rel="stylesheet"/>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

<div class="container d-flex justify-content-center mt-100">
  
  <!-- Button to Open the Modal -->
  <form>
 	<table class="table table-hover">
		<tr>
			<th>주문번호</th>
			<th>주문자 아이디</th>
			<th>주문자명</th>
			<th>상품명</th>
			<th>금액</th>
			<th>#</th>
		</tr>
		<c:set value="${settleList }" var="settleList" />
		<c:choose>
			<c:when test="${empty settleList }">
				<tr>
					<td colspan="6">결제내역이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${settleList }" var="settle">
					<tr class="trvalue">
						<td><span data-no="${settle.settlementNo }">${settle.settlementNo }</span></td>
						<td id="payId">${settle.prMbrId }</td>
						<td id="payNm">${settle.settlementNm }</td>
						<td id="payItem">${settle.settlementItem }</td>
						<td id="payCo">${settle.settlementCo }</td>
						<td>
							<button type="button" class="btn openmodal" onclick="javascript:location.href='/mento/paydetail'">상세보기</button>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
  </form>
</div>
<script>
var prMbrId = "${SessionInfo.prMbrId}";
var payId = document.querySelector("#payId").innerText;
console.log("아이디 확인1 : ", prMbrId);	// 로그인 아이디
console.log("아이디 확인2 : ", payId);		// 결제 아이디
console.log("아이디 확인3 : ", trvalue);	// 결제내역
$(function(){
	var findno = $("tr").find("span").data("no");
	var findid = $("#payId").val();
	var findname = $("#payNm").text();
	var finditem = $("#payItem").text();
	var findcost = $("#payCo").text();
	console.log("findno : ", findno);
	console.log("findid : " + findid);
	console.log("findname : " +  findname);
	console.log("finditem : " + finditem);
	console.log("findcost : " + findcost);
	// 로그인한 아이디와 결제 아이디가 다를 경우 결제내역 숨기기
	var trvalue = $(".trvalue");
	
	trvalue.each(function(index, element) {
		var payId = $(element).find("#payId").text();
		console.log("아이디 확인2 : ", payId);	// 결제 아이디
		
		// 로그인한 아이디와 결제 아이디가 다를 경우 결제내역 숨기기
		if(prMbrId != payId) {
			trvalue.("td").hide();
		}
	});
})
</script>