<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set value="등록" var="name" />
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name" />
</c:if>

<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				
				<div class="mt-4">
					<img src="${ctxp}/resources/img/main/menu_banner/자유게시판.jpg" width="1200px" height="300px">
				</div>
				<br>
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<form action="/freeboard/insert.do" method="post" id="freeboardForm"
								enctype="multipart/form-data">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="comntPstNo"
										value="${freeboard.comntPstNo }" />
								</c:if>
								<div class="card-body">
									<div class="form-group">
										<input type="text" id="comntTitle" name="comntPstTtl" class="form-control" placeholder="제목을 입력해주세요" value="${freeboard.comntPstTtl }">
									</div>
									<div class="form-group">
										<textarea id="comntContent" name="comntPstCn" class="form-control" rows="14">${freeboard.comntPstCn }</textarea>
										<br>
										<div class="form-group">
											<input type="text" id="tags" name="tags" class="form-control" placeholder="태그를 입력해주세요" value="${freeboard.tags}">
										</div>
									</div>
									<br>
									<div class="form-group pt-2">
										<div class="custom-file">
											<input type="file" class="custom-file-input" id="comntFile"
												name="comntFile" multiple="multiple"> <label
												class="custom-file-label" for="comntFile">파일을 선택해주세요</label>
										</div>
									</div>
								</div>
								<sec:csrfInput />
							</form>
							<c:if test="${status eq 'u' }">
								<div class="card-footer bg-white">
									<c:if test="${not empty freeboard.communityFileList }">
										<c:forEach items="${freeboard.communityFileList }" var="communityFile">
											<div class="list-group">
												<div class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
													<div class="rounded-circle flex-shrink-0">
														<i class="bi-file-check-fill"></i> ${communityFile.comntFileNm }
													</div> 
													<div class="d-flex gap-2 w-100 justify-content-between attachmentFileDel" id="span_${communityFile.comntFileSn }">
														<div>${communityFile.comntFileFancysize }</div>
														<small class="opacity-50 text-nowrap">
															<i class="bi-trash-fill"></i>
														</small>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:if>
								</div>
							</c:if>
							<div class="card-footer bg-white">
								<div class="row">
									<div class="col-12">
										<input type="button" id="insertBtn" value="${name }" class="btn btn-success float-right">
										<c:if test="${status ne 'u' }">
											<input type="button" id="listBtn" value="목록" class="btn btn-secondary float-right">
										</c:if>
										<c:if test="${status eq 'u' }">
											<input type="button" id="cancelBtn" value="취소" class="btn btn-danger float-right">
										</c:if>
										<input type="button" id="autoBtn" value="자동완성" class="btn btn-info float-right"> 
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		CKEDITOR.replace("comntContent", {
		// 		filebrowserUploadUrl: '/imageUpload.do'
		});
		CKEDITOR.config.height = "500px"; // CKEDITOR 높이 설정

		var freeboardForm = $("#freeboardForm"); // 등록 폼 Element
		var insertBtn = $("#insertBtn"); // 등록 버튼 Element
		var listBtn = $("#listBtn"); // 목록 버튼 Element
		var cancelBtn = $("#cancelBtn"); // 취소 버튼 Element
		var autoBtn = $("#autoBtn");

		// 등록 버튼 클릭 시, 등록 진행
		insertBtn.on("click", function() {
			var title = $("#comntTitle").val(); // 제목 값
			var content = CKEDITOR.instances.comntContent.getData(); // 내용 값

			if (title == null || title == "") {
				alert("제목을 입력해주세요!");
				$("#comntTitle").focus();
				return false;
			}

			if (content == null || content == "") {
				alert("내용을 입력해주세요!");
				$("#comntContent").focus();
				return false;
			}

			if ($(this).val() == "수정") {
				freeboardForm.attr("action", "/freeboard/update.do");
			}
			console.log("title", title);
			console.log("content", content);
			freeboardForm.submit();
		});

		// 목록 버튼 클릭 시, 게시판 목록 화면으로 이동
		listBtn.on("click", function() {
			location.href = "/freeboard/list.do";
		});

		// 취소 버튼 클릭 시, 상세보기 화면으로 이동
		cancelBtn
				.on(
						"click",
						function() {
							location.href = "/freeboard/detail.do?comntPstNo=${freeboard.comntPstNo}";
						});

		$(".attachmentFileDel").on("click",function() {
							var id = $(this).prop("id");
							var idx = id.indexOf("_");
							var communityFileNo = id.substring(idx + 1);
							var ptrn = "<input type='hidden' name='delFreeBoardNo' value='%V'/>";
							$("#freeboardForm").append(ptrn.replace("%V", communityFileNo));
							$(this).parents(".list-group").hide();
						});
		
		/* autoBtn.on("click", function(){
			
			$("#comntTitle").val("레드캡에 면접 보러 갈건데 이 기업 괜찮나요?");
			var text = "이 기업에 대한 정보가 많이 없어서 면접을 어떻게 진행해야 할지를 모르겠습니다.";
			text += "<br>";
			text += "혹시 레드캡 기업에 대한 정보 가지고 계신분 있으시면 댓글 부탁드립니다.";
			text += "<br>";
			text += "레드캡에 면접 보신 분 계시다면 어떤 방식으로 면접 진행 되는지도 알고 싶습니다.";
			text += "<br>";
			text += "답변 부탁 드릴게요!";
			CKEDITOR.instances.comntContent.setData(text); // 내용 값
			$("#tags").val("기업질문 레드캡 면접질문");
		}) */
		autoBtn.on("click", function(){
		    var text = "<div style='font-size: 28px;'>";
		    text += "레드캡에 면접 보러 갈건데 이 기업 괜찮나요?";
		    text += "<br>";
		    text += "이 기업에 대한 정보가 많이 없어서 면접을 어떻게 진행해야 할지를 모르겠습니다.";
		    text += "<br>";
		    text += "레드캡 기업에 대한 정보 가지고 계신분 있으시면 댓글 부탁드립니다.";
		    text += "<br>";
		    text += "레드캡에 면접 보신 분 계시다면 어떤 방식으로 면접 진행 되는지도 알고 싶습니다.";
		    text += "<br>";
		    text += "답변 부탁 드릴게요!";
		    text += "</div>";
		    
		    // CKEditor의 내용을 HTML로 삽입합니다.
		    CKEDITOR.instances.comntContent.insertHtml(text);
		    
		    // 나머지 필요한 값들을 설정합니다.
		    $("#comntTitle").val("레드캡에 면접 보러 갈건데 이 기업 괜찮나요?").css("font-size", "20px");
		    $("#tags").val("기업질문 레드캡 면접질문");
		});
		
	});
</script>
