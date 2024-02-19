<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
i{
	cursor: pointer;
}
</style>

<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>자유게시판 상세보기</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">HIT HOME</a></li>
					<li class="breadcrumb-item active">자유게시판 상세보기</li>
				</ol>
			</div>
		</div>
	</div>
</section>
<section class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-dark">
					<div class="card-header">
						<h3 class="card-title">${freeboard.comntPstTtl }</h3>
						<div class="card-tools">
							${freeboard.comntWrtrNm } ${freeboard.comntWrtDt } ${freeboard.comntInqCnt }
						</div>
<%-- 						${communityFileList.comntFileSn } --%>
					</div>
					<div class="card-body">
						${freeboard.comntPstCn }
					</div>
					<div class="card-body">
						<c:choose>
							<c:when test="${empty tagList }">
								<font class="free-bebge">태그가 존재하지 않습니다!</font>		
							</c:when>
							<c:otherwise>
								<c:forEach items="${tagList }" var="tag">
									<font class="free-bebge">#${tag.comntTag }</font>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					<c:if test="${not empty freeboard.communityFileList && not empty freeboard.communityFileList[0].comntFileNm }">
						<form id="quickForm" novalidate="novalidate">
							<div class="card-footer bg-white" id="cmtFileDiv">
								<c:forEach items="${freeboard.communityFileList}" var="file">
									<div class="list-group">
										<a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
											<div class="rounded-circle flex-shrink-0">
												<i class="bi-file-check-fill"></i> ${file.comntFileNm}
											</div> 
											<c:url value="/freeboard/download.do" var="downloadURL">
												<c:param name="fileNo" value="${file.comntFileSn}" />
											</c:url>
											<div class="d-flex gap-2 w-100 justify-content-between">
												<div>${file.comntFileFancysize}</div>
												<small class="opacity-50 text-nowrap">
													<i class="bi-cloud-download-fill" id="downIcon" data-url="${downloadURL }"></i>
												</small>
											</div>
										</a>
									</div>
								</c:forEach>
							</div>
						</form>
					</c:if>
					<div class="card-footer">
							<form action="${pageContext.request.contextPath}/freeboard/delete.do" method="post" id="delForm">
							<%-- 	<input type="hidden" name="comntPstNo" value="${freeboard.comntPstNo}" /> 
								<a class="btn btn-secondary float-right" href="${ctxp}/freeboard/update.do?comntPstNo=${freeboard.comntPstNo}">수정</a>
								<button type="button" class="btn btn-secondary float-right" id="deleteBtn">삭제</button> --%>
								<button type="button" class="btn btn-secondary" id="listBtn" onclick="location.href='/freeboard/list.do'">목록</button>
							</form>
						</div>
				</div>
			</div>
			
			<div class="col-md-12 pt-5">
				<div class="card">
					<div class="card-header">
						<h5 class="card-title">댓글 목록</h5>
					</div>
					<div class="card-body" id="cmtBody">
						<c:if test="${not empty freeboardComments}">
							<c:forEach items="${freeboardComments}" var="comment">
								<div class="card" data-cmtn-no="${comment.comntCmtnNo }" data-pst-no="${comment.comntPstNo }">
									<div class="card-header pt-2">
										<div class="d-flex justify-content-between align-items-center">
							                <div class="btn-group">
							                  ${comment.comntCmtnWrtrId}
							                </div>
							                <small class="text-body-secondary">
							                	<i class="bi-pencil-fill" id="cmtUdt"></i>
							                	<i class="bi-trash-fill" id="cmtDel"></i>
							                </small>
							              </div>
									</div>
									<div class="card-body"> 
										${comment.comntCmtnCn}
									</div>	
								</div>
								<br/>
							</c:forEach>
						</c:if>
					</div>
					<form action="/freeboard/deleteComment" id="freeForm" method="post">
						<input type="hidden" name="comntCmtnNo" id="cmtCmtnNo" value="" />
						<input type="hidden" name="comntPstNo" id="cmtPstNo" value="${freeboard.comntPstNo }"/>
						<input type="hidden" name="comntCmtnCn" id="cmtCmtnCn" value=""/>
					</form>
					<%-- <div class="card-footer">
						<form action="/freeboard/addComment" method="POST">
							<input type="hidden" name="comntPstNo" value="${freeboard.comntPstNo}" />
							<textarea style="width:100%; height: 80px;" cols="70" rows="2" name="comntCmtnCn" placeholder="댓글 내용을 입력해주세요."></textarea>
							<input type="submit" class="btn btn-primary" value="등록" /> 
						</form>
					</div> --%>
				</div>
			</div>
		</div>
	</div>
</section>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		// 상세보기 컨텐츠 영역
		var quickForm = $("#quickForm");
		var delForm = $("#delForm"); // 수정 및 삭제를 처리할 Form Element
		var listBtn = $("#listBtn"); // 목록 버튼 Element
		var updateBtn = $("#updateBtn"); // 수정 버튼 Element
		var deleteBtn = $("#deleteBtn"); // 삭제 버튼 Element
		// 상세보기 컨텐츠 영역 End
		
		// 상세보기 컨텐츠 댓글 영역
		var cmtBody = $("#cmtBody");	// 댓글 영역이 포함되어 있는 body
		// 상세보기 컨텐츠 댓글 영역 End
	
		// 목록 버튼 클릭 시, 목록 페이지 이동
		listBtn.on("click", function() {
			location.href = "/ent/freeboardlist";
		});

		// 수정 버튼 클릭 시, 수정 페이지 이동
		updateBtn.on("click", function() {
			quickForm.attr("action",
					"/ent/freeboardupdate?comntPstNo=${comntPstNo}");
			quickForm.attr("method", "get");
			quickForm.submit();
		});

		deleteBtn.on("click", function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				// form 내에서 직접 submit을 호출하여 삭제 동작 수행
				delForm.submit();
			}
		});
		
		// 댓글 시작
		// 댓글 수정 아이콘 클릭시
		cmtBody.on("click", "#cmtUdt", function(){
			console.log("수정 버튼을 눌렀습니다!");
			var cmtnNo = $(this).parents(".card").data("cmtn-no");
			$("#freeForm").find("#cmtCmtnNo").val(cmtnNo);
			
			var body = $(this).parents(".card").find(".card-body");
			
			
			var html = "<textarea cols='70' rows='2' style='width:100%;' id='cmtInCn'>"+body[0].innerText+"</textarea>";
			html += "<button class='btn btn-sm btn-primary' id='cmtInUdtBtn'>수정</button><button class='btn btn-sm btn-danger' id='cmtInCancelBtn'>취소</button>";
			body[0].innerHTML = html;
		});
		
		cmtBody.on("click", "#cmtInUdtBtn", function(){
			var cn = $(this).parents(".card-body").find("#cmtInCn").val();
			$("#cmtCmtnCn").val(cn);
			$("#freeForm").attr("action", "/freeboard/modifyComment");
			$("#freeForm").submit();
		});
		
		cmtBody.on("click", "#cmtInCancelBtn", function(){
			var cn = $(this).parents(".card-body").find("#cmtInCn").text();
			var body = $(this).parents(".card-body");
			body[0].innerHTML = cn;
		});
		
		// 댓글 삭제 아이콘 클릭시
		cmtBody.on("click", "#cmtDel", function(){
			console.log("삭제 버튼을 눌렀습니다!");
			var cmtnNo = $(this).parents(".card").data("cmtn-no");
			var pstNo = $(this).parents(".card").data("pst-no");
			
			if(confirm("정말로 삭제하시겠습니까?")){
				 $("#cmtCmtnNo").val(cmtnNo);
				 $("#freeForm").submit();
			}
		});
		
		$("#cmtFileDiv").on("click", "#downIcon", function(){
			location.href = $(this).data("url");
		});
		
	});
</script>








