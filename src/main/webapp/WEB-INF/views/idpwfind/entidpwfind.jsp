<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>

<style>
   .h2 {
        margin-top: 10%;
        text-align: center;
   }

   #sh_ft {
        top: 200px;
   }

   .nav-tabs-container {
        width: 50%; /* 넓이 조정 */
        margin: 0 auto; /* 수평 가운데 정렬 */
   }
   
 

    .form-container {
  		display: none;
        flex-direction: column;
        align-items: center;
    }
    .form-container.active {
        display: flex; /* active 클래스가 적용되면 폼을 보이게 함 */
   }

   .form-container .form-floating {
        width: 300px; /* 폼 요소의 넓이 조정 */
   }

</style>
<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">

				<!-- 	<p class="h2">기업회원 아이디/비밀번호 찾기</p> -->
			<div class="row">
				<div class="col-md-12">
					<div class="card card-outline card-danger mt-4">
						<div class="col-md-12 px-0">
							<img src="${ctxp}/resources/img/main/menu_banner/기업회원 아이디비번찾기.jpg"
								width="1100px" height="300px">
						</div>
					</div>
					<br>
				</div>
				<br>
				<br>
				<nav class="nav-tabs-container">
					<div class="container">
						<div class="col-md-8 mx-auto">
							<!-- 수정된 부분: col-md-8과 mx-auto 클래스로 버튼들을 중앙에 정렬 -->
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button id="nav-id-find" class="nav-link active"
									data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
									role="tab" aria-controls="nav-profile" aria-selected="true">아이디
									찾기</button>
								<button id="nav-pw-find" class="nav-link" data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false">비밀번호
									찾기</button>
							</div>
						</div>
					</div>
				</nav>
				<br>
				<br>
				<div class="form-container-wrapper">
					<div>
						<form action="${ctxp }/member/findEntId.do" method="POST"
							id="idfind" class="form-container">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="brno" name="brno"
									placeholder="사업자등록번호"> <label for="floatingInput">사업자등록번호</label>
							</div>
							<div class="form-floating">
								<input type="email" class="form-control" id="entMbrEmail"
									name="entMbrEmail" placeholder="이메일"> <label
									for="floatingPassword">이메일</label>
							</div>
							<br>
							<br>
							<button type="button" id="idFindBtn" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#staticBackdrop">아이디
								찾기</button>
							<!-- 오달수요~ -->
							<div class="modal fade" id="staticBackdrop"
								data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
								aria-labelledby="staticBackdropLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="staticBackdropLabel">아이디</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<input type="text" class="form-control" name="entMbrId"
												id="entMbrId" readonly="readonly">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>

						</form>
					</div>

					<div>
						<form action="${ctxp }/member/findEntPw.do" method="POST"
							id="pwfind" class="form-container">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="entMbrId2"
									name="entMbrId2" placeholder="아이디"> <label
									for="floatingInput">아이디</label>
							</div>
							<div class="form-floating">
								<input type="email" class="form-control" id="entMbrEmail2"
									name="entMbrEmail2" placeholder="이메일"> <label
									for="floatingPassword">이메일</label>
							</div>
							<br>
							<br>
							<button type="button" id="pwFindBtn" class="btn btn-primary">비밀번호
								찾기</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


<script>
	$(function(){
		var findForm = $("#findForm");
		var idFindBtn = $("#idFindBtn");
		var pwFindBtn = $("#pwFindBtn");
				
		idFindBtn.on("click",function(){
			var brno = $("#brno").val();
			var entMbrEmail = $("#entMbrEmail").val();
			
			var data = {
					brno : brno,
					entMbrEmail : entMbrEmail
			}
			$.ajax({
				type: "post",
				url : "/member/findEntId.do",
				data : JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				success : function(res)
				{
					$('#entMbrId').val(res);
					
					   // 모달 열기
	                $('#staticBackdrop').modal('show');
					   
				}
			});
		});
		pwFindBtn.on("click",function(){
			var entMbrId = $("#entMbrId2").val();
			var entMbrEmail = $("#entMbrEmail2").val();
			
			
			var data = {
					entMbrId : entMbrId,
					entMbrEmail : entMbrEmail
			}
			$.ajax({
				type: "post",
				url : "/member/findEntPw.do",
				data : JSON.stringify(data),
				dataType: "text",
				contentType : "application/json;charset=utf-8",
				success: function(res)
				{
					if(res == "FAILED"){
						alert("잘못된 회원정보입니다!");
					}else{
						alert("임시 비밀번호가 이메일로 전송되었습니다.")
					}
				}
				
			});
		});
	});
	
	
	
	
	
    document.addEventListener('DOMContentLoaded', function () {
        var idFindForm = document.getElementById('idfind');
        var pwFindForm = document.getElementById('pwfind');

        // 초기 로딩시 첫 번째 폼을 보이도록 함
        idFindForm.classList.add('active');

        // 아이디 찾기 탭 클릭 시
        document.getElementById('nav-id-find').addEventListener('click', function () {
            idFindForm.classList.add('active');
            pwFindForm.classList.remove('active');
        });

        // 비밀번호 찾기 탭 클릭 시
        document.getElementById('nav-pw-find').addEventListener('click', function () {
            pwFindForm.classList.add('active');
            idFindForm.classList.remove('active');
        });
    });
</script>
