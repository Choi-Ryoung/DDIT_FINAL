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
				<div>
					<div class="bd-example">
						<nav>
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${ctxp}/notice/list.do'">공지사항</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/freeboard/list.do'">자유게시판</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/faq/list'">FAQ</button>
								<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/answer/list.do'">1:1 문의</button>
							</div>
						</nav>
				     </div>
				</div>
					<div class="mt-4">
						<img src="${ctxp}/resources/img/main/menu_banner/자유게시판.jpg" width="1200px" height="300px">
					</div>
				<hr>
				<div class="row">
					<div class="col-md-12">
						<div class="card card-dark">
							<div class="card-header">
								<h3 class="card-title">게시글 ${name }</h3>
								<div class="card-tools"></div>
							</div>
							<form action="/notice/insert.do" method="post" id="noticeForm" enctype="multipart/form-data">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="ntPstNo"
										value="${notice.ntPstNo }" />
								</c:if>
								<div class="card-body">
									<div class="form-group">
										 <input type="text" id="ntTitle" name="ntPstTtl" class="form-control" placeholder="제목을 입력해주세요" value="${notice.ntPstTtl }">
									</div>
									<br>
									<div class="form-group">
										<textarea id="ntContent" name="ntPstCn" class="form-control" rows="14">${notice.ntPstCn }</textarea>
									</div>
									<div class="form-group">
										<div class="custom-file">
											<input type="file" class="custom-file-input" id="ntFile" name="ntFile" multiple="multiple">
											<label class="custom-file-label" for="ntFile">파일을 선택해주세요</label>
										</div>
									</div>
								</div>
								<sec:csrfInput />
							</form>
							<c:if test="${status eq 'u' }">
								<div class="card-footer bg-white">
									<ul
										class="mailbox-attachments d-flex align-items-stretch clearfix">
										<c:if test="${not empty notice.noticeFileList }">
											<c:forEach items="${notice.noticeFileList }" var="noticeFile">
												<li>
													<span class="mailbox-attachment-icon">
														
													</span>
													<div class="mailbox-attachment-info">
														<a href="#" class="mailbox-attachment-name"> 
															<i class="bi-file-fill"></i> ${noticeFile.ntFileNm }
														</a> 
														<span class="mailbox-attachment-size clearfix mt-1">
															<span>${noticeFile.ntFileFancysize }</span> 
															<span class="btn btn-default btn-sm float-right attachmentFileDel" id="span_${noticeFile.ntFileSn }"> 
																<i class="bi-file-x-fill"></i>
															</span>
														</span>
													</div>
												</li>
											</c:forEach>
										</c:if>
									</ul>
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
$(function(){
	CKEDITOR.replace("ntContent", {
// 		filebrowserUploadUrl: '/imageUpload.do'
	});
	CKEDITOR.config.height = "500px";	// CKEDITOR 높이 설정
	
	var noticeForm = $("#noticeForm");	// 등록 폼 Element
	var insertBtn = $("#insertBtn");	// 등록 버튼 Element
	var listBtn = $("#listBtn");		// 목록 버튼 Element
	var cancelBtn = $("#cancelBtn");	// 취소 버튼 Element
	
	// 등록 버튼 클릭 시, 등록 진행
	insertBtn.on("click", function(){
		var title = $("#ntTitle").val();	// 제목 값
		var content = CKEDITOR.instances.ntContent.getData();	// 내용 값
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요!");
			$("#ntTitle").focus();
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			$("#ntContent").focus();
			return false;
		}
		
		 if($(this).val() == "수정"){
             noticeForm.attr("action", "/notice/update.do");
         }
         console.log("title",title);
         console.log("content",content);
         noticeForm.submit();
	});
	
	// 목록 버튼 클릭 시, 게시판 목록 화면으로 이동
	listBtn.on("click", function(){
		location.href = "/notice/list.do";
	});
	
	// 취소 버튼 클릭 시, 상세보기 화면으로 이동
	cancelBtn.on("click", function(){
		location.href = "/notice/detail.do?ntPstNo=${notice.ntPstNo}";
	});
	
	 $(".attachmentFileDel").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var noticeFileNo = id.substring(idx + 1);
		var ptrn = "<input type='hidden' name='delNoticeNo' value='%V'/>";
		$("#noticeForm").append(ptrn.replace("%V", noticeFileNo));
		$(this).parents("li:first").hide(); 
	});
});
</script>
