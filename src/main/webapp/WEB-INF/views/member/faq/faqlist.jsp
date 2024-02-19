<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  .accordion {
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
  }
  .accordion-item {
    background-color: #f9f9f9;
    border-bottom: 1px solid #ccc;
    padding: 10px;
    cursor: pointer;
  }
  .accordion-content {
    display: none;
    padding: 10px;
  }
</style>


<div id="sh_container">
	<div id="sh_container_wrapper">
		<div id="sh_content">
			<div id="greeting" class="pagecommon">
				<!-- 아래로 콘텐츠 추가  -->
				<div class="bd-example">
					<nav>
						<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
							<button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onClick="location.href='${ctxp}/notice/list.do'">공지사항</button>
							<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/freeboard/list.do'">자유게시판</button>
							<button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/faq/list'">FAQ</button>
							<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onClick="location.href='${ctxp}/answer/list.do'">1:1 문의</button>
						</div>
					</nav>
			     </div>
				<div class="mt-4">
					<img src="${ctxp}/resources/img/main/menu_banner/자유게시판.jpg" width="1200px" height="300px">
				</div>
				<br>
				<div class="accordion">
					<c:forEach items="${faqList}" var="faq">
						<div class="accordion-item">
							<h2>${faq.faqPstTtl}</h2>
						</div>
						<div class="accordion-content">
							<p>작성자&nbsp;:&nbsp;${faq.faqWrtrNm}</p>
							<p>작성일&nbsp;:&nbsp;${faq.faqWrtDt}</p>
							<p>${faq.faqPstCn}</p>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('.accordion-item').click(function(){
			$(this).next('.accordion-content').slideToggle();
		});
		$('#addBtn').click(function(){
			location.href = "/faq/form";
		});
	});
</script>

