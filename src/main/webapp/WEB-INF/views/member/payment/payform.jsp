<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="${ctxp}/resources/css/member/payment.css" rel="stylesheet">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
/* 메뉴 배경 색상 */
.bg-custom {
	background-color: cornflowerblue;
	/* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
}
</style>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div>
					<div class="bd-example"></div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<img src="${ctxp}/resources/img/main/menu_banner/멘토링.jpg" width="1200px" height="300px">
						</div>
					</div>
				</div>
				<hr>
				<!-- 여기부터 -->
				<div class="card-body">
					<form action="/mento/pay" method="post" id="payForm">
						<input type="hidden" id="menNcnm" name="menNcnm"
							value="${menNcnm}" /> <input type="hidden" id="prMbrNcnm"
							name="prMbrNcnm" value="${SessionInfo.prMbrNcnm}" />
						
						<div class="row">
							<label for="settlementNm" class="form-label">결제자명</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label> <input
									type="text" id="settlementNm" name="settlementNm"
									class="form-control" value="${SessionInfo.prMbrNm }"
									readonly="readonly">
							</div>
						</div>
						<hr>	
						
						<div class="row">
							<label for="settlementItem" class="form-label">상품명</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label> <input
									type="text" id="settlementItem" name="settlementItem"
									class="form-control" value="한시간만 알려주셈(60분)" readonly="readonly">
							</div>
						</div>
						<hr>

						<div class="row">
							<input type="hidden" name="prMbrId"value="${SessionInfo.prMbrId }" />
							<label for="settlementCo" class="form-label">결제금액</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label>
								<!-- value 값이 30000이면 pattern 속성을 사용하여 원화 표시를 추가합니다. -->
								<%-- <fmt:formatNumber value="30000" pattern="#,##0원"
									var="formattedValue" /> --%>
								<input type="text" id="settlementCo" name="settlementCo" class="form-control" value="30000" readonly="readonly">
								<!-- <input type="text" id="settlementCo" name="settlementCo" class="form-control" value="30000" readonly="readonly"> -->
							</div>
						</div>
						<hr>
						

						<div class="row">
							<label for="settlementHp" class="form-label">결제자번호</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label> <input
									type="text" id="settlementHp" name="settlementHp"
									class="form-control" value="${SessionInfo.prMbrTelno }">
							</div>
						</div>
						<hr>

						<div class="row">
							<label for="settlementMail" class="form-label">결제자이메일</label>
							<div class="col-auto">
								<label for="inputPassword2" class="visually-hidden"></label> <input
									type="text" id="settlementMail" name="settlementMail"
									class="form-control" value="${SessionInfo.prMbrEmail }">
							</div>
						</div>
						<hr>

						<%-- <div class="row">
								    <div class="col-8 mb-3">
								        <label for="settlementTpCd" class="form-label">결제방식</label>
								        <select id="settlementTpCd" name ="settlementTpCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${paymentList}" var="paymentList" varStatus="vs">
								        		<c:if test="${paymentList.cmcd ne '01'}">
								        			<option value="${paymentList.cmcdNm}">${paymentList.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr> --%>

						<div class="row">
							<div class="col-8 mb-3">
								<label for="settlementTpCd" class="form-label">결제방식</label> <br>
								<div class="btn-group" role="group" aria-label="결제방식 선택">
									<c:set var="cnt" value="1" />
									<c:forEach items="${paymentList}" var="paymentList"
										varStatus="vs">
										<c:if test="${paymentList.cmcd ne '01'}">
											<input type="radio" class="btn-check payType"
												name="settlementTpCd" id="payment${cnt}"
												value="${paymentList.cmcdNm}">
											<label class="btn btn-outline-primary" for="payment${cnt}">${paymentList.cmcdNm}</label>
											<c:set var="cnt" value="${cnt + 1}" />
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
						<hr>

						<!-- <div class="d-grid gap-2 col-6 mx-auto">
							<button class="btn bd-primary" type="button"
								onclick="requestPay()">결제하기</button>
						</div> -->

						<div class="row">
							<div class="col-6">
								<div class="input-group mb-3">
									<div class="form-group clearfix">
										<div class="icheck-primary d-inline">
											<button type="button" onclick="mentoList()"
												class="btn btn-outline-primary btn-inline">목록으로</button>
										</div>
									</div>
								</div>
							</div>
						</div>

					</form>
				</div>


				<!-- 여기까지 -->
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

var payForm = $("#payForm");
var IMP = window.IMP; 
IMP.init("imp58663018"); 

var today = new Date();   
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = hours +  minutes + seconds + milliseconds;

function requestPay() {
	let a = "${menNcnm}";
	console.log("Test" + a);
	var settlementItem = $("#settlementItem").val();
	var settlementTpCd = $(".payType").val();
	console.log("asdsd : ", settlementTpCd);
	var settlementMail = $("#settlementMail").val();
	var settlementNm = $("#settlementNm").val();
	var settlementHp = $("#settlementHp").val();
	var settlementCo = $("#settlementCo").val();
	var menNcnm = $("#menNcnm").val();
	console.log("menNcnm : " + menNcnm);
	var prMbrNcnm = $("#prMbrNcnm").val();
	console.log("prMbrNcnm" + prMbrNcnm);
	/* if(settlementCo != "30000") {
		console.log("결제금액 : " + settlementCo);
		alert("ㄴㄴ");
		return false;	
			
		} */
    IMP.request_pay({
        //pg : 'html5_inicis',
        pg : 'kakaopay',
        /* pay_method : settlementTpCd, */
        merchant_uid: 'IMP' + makeMerchantUid, 
        name : settlementItem,
        amount : settlementCo,
        buyer_email : settlementMail,
        buyer_name : settlementNm,
        buyer_tel : settlementHp
        //buyer_addr : '서울특별시 강남구 삼성동',
        //buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) {
        	// 컨트롤러에 데이터를 전달하여 DB에 입력하는 로직
			// 결제내역을 사용자에게 보여주기 위해 필요함.
			
			var data = {
				/* settlementTpCd : settlementTpCd, */
				settlementItem : settlementItem,
				settlementTpCd : settlementTpCd,
				settlementCo : settlementCo,
				settlementMail : settlementMail,
				settlementNm : settlementNm,
				settlementHp : settlementHp,
				menNcnm : menNcnm,
				prMbrNcnm : prMbrNcnm
        	}
			
 			console.log("settlementTpCd : ", settlementTpCd);
        	
			$.ajax({
				url: "/mento/pay",
				type: "POST",
				data: JSON.stringify(data),
				contentType:'application/json;charset=UTF-8',
				success: function (res) {
					console.log("결제성공 : ", res);
					console.log("asdsd : ", settlementTpCd);
					
					if(res.result == "success"){
						Swal.fire({
							  title: "결제가 완료되었습니다!",
							  icon: "success",
							  showConfirmButton: false,
							  footer: "<a class='btn btn-outline-primary' href='/mento/find?menNcnm=" + menNcnm + "'>이동</a>" 
							});
						//location.href = "/mento/find?menNcnm=" + menNcnm;						
					} else if(res.result == "fail"){
						alert(res.msg);
						return;
					}
					
					/*
					if(!result.settlementCo === 30000) {
			            console.log(result);
			            alert("응 안돼 돌아가");
			            location.href = "/mento/pay";
					} else {
						location.href = "/mento/find?menNcnm=" + menNcnm;
						alert("성공!");
			        }
					*/
				}
			});
        }
    });
}


function mentoList() {
	alert("결제가 취소되었습니다.");
	location.href="/mento/list";
}
$(function(){
var payType = $(".payType");
var paymentBtn = $("#paymentBtn");

payType.on("change", function(){
	console.log($(this).val());
	console.log($(this).attr("id"));
	console.log(payType.val());
});

payType.on("click", function(){
//	console.log($(this).val());
	if($(this).val() == "계좌이체") {
		//alert("계좌이체");
		console.log($(this).val());
	} else if($(this).val() == "카카오페이") {
		//alert("카카오페이");
		console.log($(this).val());
		requestPay();
	}
});

paymentBtn.on("click", function(){
	if(payType.val() == "계좌이체") {
		alert("계좌이체");
	} else {
		console.log(payType.val())
		requestPay();
	}
});

});
</script>
