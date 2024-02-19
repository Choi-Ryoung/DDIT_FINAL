<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>



<section class="content-header">
	<c:set value="등록" var="name" />
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name" />
	</c:if>
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>게시글 ${name }</h1>
			</div>
			<div class="col-sm-6">						
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">INIT</a></li>
					<li class="breadcrumb-item active">게시글 ${name }</li>
				</ol>
			</div>
		</div>
	</div>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="card card-dark">
				<div class="card-header">
					<h3 class="card-title">게시글 ${name }</h3>
					<div class="card-tools"></div>
				</div>
				<form action="/answer/insert.do" method="post" id="answerForm" enctype="multipart/form-data">
					<c:if test="${status eq 'u' }">
						<input type="hidden" name="ansNo"
							value="${answer.ansNo }" />
					</c:if>
					<div class="card-body">
						<div class="form-group">
							<label for="ansTitle">제목을 입력해주세요</label> <input type="text"
								id="ansTitle" name="ansTtl" class="form-control"
								placeholder="제목을 입력해주세요" value="${answer.ansTtl }">
						</div>
						<div class="form-group">
							<label for="ansContent">내용을 입력해주세요</label>
							<textarea id="ansContent" name="ansCn"
								class="form-control" rows="14">${answer.ansCn }</textarea>
						</div>
						<div class="form-group">
							 <div class="custom-file">
								<input type="file" class="custom-file-input" id="ansFile" name="ansFile" multiple="multiple">
								<label class="custom-file-label" for="ansFile">파일을 선택해주세요</label>
							</div> 
						</div>
					</div>
					<sec:csrfInput />
				</form>
				<c:if test="${status eq 'u' }">
					<div class="card-footer bg-white">
						<ul
							class="mailbox-attachments d-flex align-items-stretch clearfix">
							<c:if test="${not empty answer.answerFileList }">
								<c:forEach items="${answer.answerFileList }"
									var="answerFile">
									<li><span class="mailbox-attachment-icon"><i
											class="far fa-file-pdf"></i></span>
										<div class="mailbox-attachment-info">
											<a href="#" class="mailbox-attachment-name"> <i
												class="fas fa-paperclip"></i> ${answerFile.ansFileNm }
											</a> <span class="mailbox-attachment-size clearfix mt-1">
												<span>${answerFile.ansFileFancysize }</span> <span
												class="btn btn-default btn-sm float-right attachmentFileDel"
												id="span_${answerFile.ansFileSn }"> <i
													class="fas fa-times"></i>
											</span>
											</span>
										</div></li>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</c:if>
				<div class="card-footer bg-white">
					<div class="row">
						<div class="col-12">
							<input type="button" id="insertBtn" value="${name }"
								class="btn btn-dark float-right">
							<c:if test="${status ne 'u' }">
								<input type="button" id="listBtn" value="목록"
									class="btn btn-secondary float-right">
							</c:if>
							<c:if test="${status eq 'u' }">
								<input type="button" id="cancelBtn" value="취소"
									class="btn btn-secondary float-right">
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("ansContent", {
// 		filebrowserUploadUrl: '/imageUpload.do'
	});
	CKEDITOR.config.height = "500px";	// CKEDITOR 높이 설정
	
	var answerForm = $("#answerForm");	// 등록 폼 Element
	var insertBtn = $("#insertBtn");	// 등록 버튼 Element
	var listBtn = $("#listBtn");		// 목록 버튼 Element
	var cancelBtn = $("#cancelBtn");	// 취소 버튼 Element
	
	// 등록 버튼 클릭 시, 등록 진행
	insertBtn.on("click", function(){
		var title = $("#ansTitle").val();	// 제목 값
		var content = CKEDITOR.instances.ansContent.getData();	// 내용 값
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요!");
			$("#ansTitle").focus();
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			$("#ansContent").focus();
			return false;
		}
		
		 if($(this).val() == "수정"){
             answerForm.attr("action", "/answer/update.do");
         }
         console.log("title",title);
         console.log("content",content);
         answerForm.submit();
	});
	
	// 목록 버튼 클릭 시, 게시판 목록 화면으로 이동
	listBtn.on("click", function(){
		location.href = "/answer/list.do";
	});
	
	// 취소 버튼 클릭 시, 상세보기 화면으로 이동
	cancelBtn.on("click", function(){
		location.href = "/answer/detail.do?ansNo=${answer.ansNo}";
	});
	
	 $(".attachmentFileDel").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var answerFileNo = id.substring(idx + 1);
		var ptrn = "<input type='hidden' name='delAnswerNo' value='%V'/>";
		$("#answerForm").append(ptrn.replace("%V", answerFileNo));
		$(this).parents("li:first").hide(); 
	});
});
</script>
