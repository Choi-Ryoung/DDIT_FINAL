<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


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
				<br>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-dark">
								<div class="card-header">
									<h3 class="card-title">${notice.ntPstTtl }</h3>
									<div class="card-tools">${notice.ntWrtrNm }
										${notice.ntWrtDt } ${notice.ntInqCnt }</div>
										${noticeFileList.ntFileSn }
								</div>
								<form id="quickForm" novalidate="novalidate">
									<div class="card-body">${notice.ntPstCn }</div>
									<div class="card-footer bg-white">
										<ul
											class="mailbox-attachments d-flex align-items-stretch clearfix">
											<c:if test="${not empty notice.noticeFileList && not empty notice.noticeFileList[0].ntFileNm}">
												<c:forEach items="${notice.noticeFileList}" var="file">
													<li><span class="mailbox-attachment-icon"> <i
															class="far fa-file-pdf"></i>
													</span>
														<div class="mailbox-attachment-info">
															<a href="#" class="mailbox-attachment-name"> <i
																class="fas fa-paperclip"></i> ${file.ntFileNm}
															</a> <span class="mailbox-attachment-size clearfix mt-1">
																<span>${file.ntFileFancysize}</span> <c:url
																	value="/notice/download.do" var="downloadURL">
																	<c:param name="fileNo" value="${file.ntFileSn}" />
																</c:url> <a href="${downloadURL}"> <span
																	class="btn btn-default btn-sm float-right"> <i
																		class="bi-cloud-download-fill"></i>
																</span>
															</a>
															</span>
														</div></li>
												</c:forEach>
											</c:if>
										</ul>
									</div>
									<div class="card-footer">
										<!--  <button type="button" class="btn btn-secondary" id="listBtn">목록</button>    -->
										<!-- 이부분 모르겠음 -->
										<sec:authentication property="principal.member" var="member" />
										<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
											<c:if test="${not empty notice}">
												<!-- notice가 비어있지 않은 경우에 수행할 코드 -->
												<h1>${notice.ntPstTtl}</h1>
												<p>${notice.ntPstCn}</p>
												<!-- 필요한 정보를 출력하거나 처리하는 코드를 작성 -->
											</c:if>
										</sec:authorize>
									</div>
								</form>
							</div>
						</div>
						<form action="${pageContext.request.contextPath}/notice/delete.do" method="post" id="delForm">
							<input type="hidden" name="ntPstNo" value="${notice.ntPstNo}" />
							<br>
							<a class="btn btn-warning" href="${ctxp}/notice/update.do?ntPstNo=${notice.ntPstNo}">수정</a>&nbsp;
							<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>&nbsp;
							<button type="button" class="btn btn-secondary" id="listBtn" onclick="location.href='/notice/list.do'">목록</button>
							<sec:csrfInput />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		var quickForm = $("#quickForm");
		var delForm = $("#delForm"); // 수정 및 삭제를 처리할 Form Element
		var listBtn = $("#listBtn"); // 목록 버튼 Element
		var updateBtn = $("#updateBtn"); // 수정 버튼 Element
		var deleteBtn = $("#deleteBtn"); // 삭제 버튼 Element

		// 목록 버튼 클릭 시, 목록 페이지 이동
		listBtn.on("click", function() {
			location.href = "/notice/list.do";
		});

		// 수정 버튼 클릭 시, 수정 페이지 이동
		updateBtn.on("click", function() {
			location.href = "/notice/update.do";

			quickForm.attr("action",
					"/notice/update.do?ntPstNo=${ntPstNo}");
			quickForm.attr("method", "get");
			quickForm.submit();
		});

		deleteBtn.on("click", function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				// form 내에서 직접 submit을 호출하여 삭제 동작 수행
				delForm.submit();
			}
		});
	});
</script>
