<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/> 
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css"> -->

<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>



<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-outline card-danger mt-4">
							<div class="col-md-12 px-0">
								<img src="${ctxp}/resources/img/main/menu_banner/기업정보관리.jpg"
									width="1100px" height="300px">
							</div>
						</div>
						<br>
					</div>
					<nav>
						<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
							<button class="nav-link " data-bs-toggle="tab"
								data-bs-target="#nav-home" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="true"
								onclick="location.href='${ctxp}/ent/entpage/entAccount'">기업계정
								정보</button>
							<button class="nav-link active" data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab"
								aria-controls="nav-profile" aria-selected="false"
								onclick="location.href='${ctxp}/ent/entpage/entManage'">기업정보
								관리</button>
						</div>
					</nav>
				</div>
			</div>
			<div class="card-body">
				<form action="/ent/entpage/entManageUpdate.do" method="post"
					id="entmanageForm" enctype="multipart/form-data">
					<input type="hidden" id="entMbrId" value="${entmember.entMbrId }" />
					<div class="text-start">
						<img
							class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3"
							id="entLogoImg" src="${entmember.logoImg }" alt="profile" style="width: 150px; margin-left: 100px;" />
					</div>

					<div class="input-group mb-3">
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="entFile" id="imgFile"> 
							<label class="custom-file-label" for="imgFile">기업로고를 선택해주세요</label>
						</div>
					</div>

					<div class="row">
						<label for="rprsvNm" class="form-label">대표자명</label>
						<div class="col-auto">
							<input type="text" id="rprsvNm" name="rprsvNm"
								value="${entmember.rprsvNm }" class="form-control">
						</div>
					</div>
					<hr>

					<div class="row">
						<label for="empCnt" class="form-label">사원수</label>
						<div class="col-auto">
							<input type="text" id="empCnt" name="empCnt"
								value="${entmember.empCnt }" class="form-control">
						</div>

					</div>
					<hr>
					<div class="row">
						<label for="hmpgAddr" class="form-label">홈페이지</label>
						<div class="col-auto">
							<input type="text" id="hmpgAddr" name="hmpgAddr"
								value="${entmember.hmpgAddr }" class="form-control">
						</div>
					</div>
					<hr>

					<div class="row">
						<label for="bizCn" class="form-label">사용내용및 소개글</label>
						<div class="col-auto">
							<textarea id="bizCn" name="bizCn" id="bizCn"
								cols="50">${entmember.bizCn }</textarea>
						</div>
					</div>
					<hr>

					<div class="row">
						<div class="col-6">
							<div class="input-group mb-3">
								<div class="form-group clearfix">
									<div class="icheck-primary d-inline">
										<button type="button" class="btn btn-warning" id="updateBtn">수정하기</button>
									</div>
									<div class="icheck-primary d-inline">
										<button type="button" class="btn btn-danger"
											onclick="goBack();">뒤로가기</button>
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


<script>
		$(document).ready(function(){
			var imgFile = $("#imgFile");
			
			
			//파일선택시 체인지 이벤트
			
			//파일로 가져올떄는 내가 알고있는 일반 방식으로 안됨  
			
			var fileData = null;
			$("#imgFile").on("change", function(e){
				//체인지 이벤트시 0번쨰(1개뿐이라 첫번쨰꺼로 가져오기위함)의 파일을 가져옴
				fileData = e.target.files[0];
			});
			
			//파일은 다른것들처럼 val()로 가져올수가 없으므로 밑에 형식대로
			$("#updateBtn").click(function(){
				console.log($("#entFile").val());
				
				var formData = new FormData();
				formData.append("entMbrId",$("#entMbrId").val());
				formData.append("empCnt",$("#empCnt").val());
				formData.append("rprsvNm",$("#rprsvNm").val());
				//파일로가져오기위함
				formData.append("entFile",fileData);
				formData.append("hmpgAddr",$("#hmpgAddr").val());
				formData.append("bizCn",$("#bizCn").val());
				
			    $.ajax({
			        type: "POST",
			        url: "/ent/entpage/entManageUpdate.do",
			        data: formData,
			        contentType : false,
			        processData: false,
			        success: function(result){
			            console.log("result: " + result);
			            if(result == "OK"){
			                alert("기업정보 수정이 완료 되었습니다.");
			                window.location.href = "/ent/entpage/entManage";
			            } else {
			                alert("수정실패요 다시확인요~");
			            }
			        },
			        error: function(request, status, error){
			            // 오류 처리
			        }
			    });
			});
			
			imgFile.on("change", function(event){
				
	    		var file = event.target.files[0];
	    		
// 	    		if(isImageFile(file)){
	    			var reader = new FileReader();
	    			reader.onload = function(e){
	    				$("#entLogoImg").attr("src", e.target.result);
	    			}
	    			reader.readAsDataURL(file);
	    			console.log("file : " + file);
	    			//file 전역
	    			
// 	    		}else{	// 이미지 파일이 아닐때
// 	    			alert("이미지 파일을 선택해주세요!");
// 	    		}
	    	});

		});
	   //뒤로가기 
	     function goBack() {
	         window.history.go(-1);
	     }
     
     </script>