<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
							<div class="p-2 p-md-5 text-white rounded bg-custom">
								<div class="col-md-12 px-0">
									<h1 class="display-5 fst-bold mb-2">멘토링 매치</h1>
									<br>
									<p class="lead my-3">면접의 A~Z까지 면접후기에서 확인해보세요!</p>
									<p class="lead mb-2">#전형 #진행방식 #면접질문 #이력서작성</p>
									<br> <a href="/mento/form"
										class="btn border-white btn-secondary">멘토 신청하기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<!-- 여기부터 -->
				<div class="card-body">
								<form action="/mento/insert" method="post" id="mentoringForm" enctype="multipart/form-data">
									<input type="hidden" name="prMbrId" value="${SessionInfo.prMbrId }"/>
									<c:if test="${status eq 'u'}">
										<input type="hidden" name="menNcnm" value="${mento.menNcnm}"/>
									</c:if>
								<div class="row">
								        <label for="men_ncnm" class="form-label">닉네임</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="menNcnm" name = "menNcnm" class="form-control" value="${SessionInfo.prMbrNcnm }" readonly="readonly">
											    </c:when>
											    <c:otherwise>
												    <input type="text" id ="menNcnm" name = "menNcnm" class="form-control" value="${SessionInfo.prMbrNcnm }" readonly="readonly">
											    </c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
									   <div class="col-8 mb-3">
								        <label for="menPstCn" class="form-label">간단소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="menPstCn" name = "menPstCn" class="form-control" value="${mento.menPstCn}">
											    </c:when>
											    <c:otherwise>
												    <input type="text" id="menPstCn" name="menPstCn" class="form-control" placeholder="자신을 나타내는 간단한 소개글입니다"/>
											    </c:otherwise>
										    </c:choose>
										</div>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="bankCd" class="form-label">은행이름</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="bankCd" name = "bankCd" class="form-control" value="${mento.bankCd}">
											    </c:when>
										    	<c:otherwise>
												    <input type="text" id ="bankCd" name = "bankCd" class="form-control" placeholder="은행을 입력해주세요">
										    	</c:otherwise>	
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="actno" class="form-label">계좌번호</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
												    <input type="text" id ="actno" name = "actno" class="form-control" value="${mento.actno}">
											    </c:when>
										    	<c:otherwise>
												    <input type="text" id ="actno" name = "actno" class="form-control" placeholder="계좌번호를 입력해주세요">
										    	</c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="entNm" class="form-label">기업명</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
										    	<c:when test="${status eq 'u'}">
												    <input type="text" id ="entNm" name = "entNm" class="form-control" value="${mento.entNm}">
										    	</c:when>
										    	<c:otherwise>
												    <input type="text" id ="entNm" name = "entNm" class="form-control" placeholder="기업명">
										    	</c:otherwise>
										    </c:choose>
										</div>
										<div class="col-auto">
										    <button type="button" class="btn btn-secondary mb-3">검색하기</button>
										</div>        
								</div><hr>
								
								
								<div class="mb-3">
								        <label for="menFile" class="form-label">기업로고</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input class="form-control" type="file" name=picture id="picture">
										</div>
								</div><hr>
								
								<div class="mb-3">
								        <label for="menFile" class="form-label">프로필 사진</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input class="form-control" type="file" name="menFile" id="menFile" multiple="multiple">
										</div>
								<c:if test="${status eq 'u'}">
								<c:set value="${mento.menFileList }" var="menFileList" />
									<c:if test="${not empty menFileList }">
										<div class="col-md-12">
											<div class="row">
											<c:forEach items="${menFileList }" var="mentoFile">
												<div class="col-md-2">
												<c:choose>
													<c:when test="${fn:split(mentoFile.menFileMime, '/')[0] eq 'image' }">
														<img src="/resources/upload/${mento.menNcnm}/${fn:split(mentoFile.menFileSavepath, '/')[1] }" style="width:20rem;" alt="img-blur-shadow">
													</c:when>
													<c:otherwise>
														<img src="${pageContext.request.contextPath}/resources/assets/img/icons/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
													</c:otherwise>
												</c:choose>
												<p class="mb-0 text-xs font-weight-bolder text-info text-uppercase">
													<button type="button" id="btn_${mentoFile.menFileSn }" class="btn btn-primary fileDelete">delete</button>
												</p>
											</div>
											</c:forEach>
											</div>
										</div>
									</c:if>
								</c:if>
								</div><hr>
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="trmsAgreCd" class="form-label">약관동의여부</label>
								        <c:choose>
								        	<c:when test="${status eq 'u' }">
										        <input type="checkbox" id="trmsAgreCd" name="trmsAgreCd" value="Y" checked="checked" class="form-checkbox" aria-label="Default checkbox example"/>
								        	</c:when>
								        	<c:otherwise>
										        <input type="checkbox" id="trmsAgreCd" name="trmsAgreCd" value="Y" class="form-checkbox" aria-label="Default checkbox example"/>
								        	</c:otherwise>
								        </c:choose>
								    </div>
								</div><hr>
								
								<div class="row">
								    <div class="col-8 mb-3">
								        <label for="applyCareerCd" class="form-label">신입/경력</label>
								        <select id="applyCareerCd" name ="applyCareerCd" class="form-select" aria-label="Default select example">
								        	<c:forEach items="${careerList}" var="careerList" varStatus="vs">
								        		<c:if test="${careerList.cmcd ne '01'}">
								        			<option value="${careerList.cmcdNm}">${careerList.cmcdNm}</option>
								        		</c:if>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
					
								<div class="row">
									<div class="col-8 mb-3">
								        <label for="applyTaskCd" class="form-label">직무</label>
								        <select id="applyTaskCd" name = "applyTaskCd" class="form-select" aria-label="Default select example">
								          	<c:forEach items="${dutyList}" var="dutyList" varStatus="vs">
								        		<option value="${dutyList.cmcdNm}">${dutyList.cmcdNm}</option>
								            </c:forEach>
								        </select>
								    </div>
								</div><hr>
								
								<div class="row">
								        <label for="tag" class="form-label">#태그</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
											    <c:when test="${status eq 'u'}">
											    	<input type="text" id="tag" name="tag" class="form-control" value="<c:forEach items='${mento.tagList }' var='tag'><c:out value='${tag.menTag } '></c:out></c:forEach>"/>
											    </c:when>
											    <c:otherwise>
												    <input type="text" id ="tag" name = "tag" class="form-control" placeholder="태그를 입력해주세요">
											    </c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="menPstCn" class="form-label">소개글</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <c:choose>
										    	<c:when test="${status eq 'u'}">
										    		<textarea rows="5" cols="150" id="menIndt" name="menIndt" style="white-space: pre;">${mento.menIndt }</textarea>
										    	</c:when>
										    	<c:otherwise>
												    <textarea rows="5" cols="150" id="menIndt" name="menIndt" style="white-space: pre;"></textarea>
										    	</c:otherwise>
										    </c:choose>
										</div>
								</div><hr>
								
								
								<div class="row">
									<div class="col-6">
									    <div class="input-group mb-3">
									        <div class="form-group clearfix">
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="signUpBtn" class="btn btn-secondary btn-inline">${name}</button>
									            </div>
									            <div class="icheck-primary d-inline">
									               <button type="submit" class="btn btn-secondary btn-inline" onclick="javascript:history.back()">뒤로가기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="autoBtn" class="btn btn-secondary btn-inline">자동완성</button>
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
