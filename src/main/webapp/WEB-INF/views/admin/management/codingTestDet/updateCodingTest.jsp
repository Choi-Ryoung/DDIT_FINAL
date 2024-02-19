<%@page import="kr.or.ddit.member.codingtest.controller.FileClassLoader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HIT</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	html{
		height: 100%;
	}
	body {
		background-color: #263747;
		color: white;
	}
	.challenge-nav{
		position: relative;
	    justify-content: space-between;
	    padding: 0 1rem;
	    height: 3.5rem;
	    box-shadow: inset 0 -0.0625rem #172334;
	}
	.challenge-nav li{
		font-size: 1.3em;
		margin-top: 30px;
		margin-left: 15px;
	}
	.guide-section{
	    position: relative;
		height: 100%;
		width: calc(40% - 12px);
		margin-left: 10px;
		float: left;
		font-family: 'Noto Sans KR', sans-serif;
	}
	h4, h3{
		font-family: 'Noto Sans KR', sans-serif;
	}
	.guide-section-description{
		/* min-height: 150px; */		
		/* padding-top: 2em; */
	}
	.run-section{
		position: relative;
		height: 100%;
		width: calc(60% - 12px);
		float: right;
		border-left: 2px solid #172334;
	}
	hr{
		border-top: 0.0625rem solid #D7E2EB;
		margin: 1.5rem 0;
		border-color: #172334;
	}
	.button-section{
		display: flex;
	    justify-content: right;
	    background-color: #263747;
	    height: 3.5625rem;
	    padding: 0.5rem 1rem;
	    border-top: 1px solid #172334;
	    width: 100%;
	}
	button{
		margin: 0 0.25rem;
	}
	.resultDiv{
		height: 270px;
		overflow: auto;
	}
	textarea {
		width: 100%;
		height: 6.25em;
		border: none;
		resize: none;
	}
	select{
		margin-left: 80%
	}
</style>
<body onload="init()">
	<form method="post" id="prctQuesNoForm">
		<c:if test="${status ne 'insert' }">
			<input type="hidden" name="prctQuesNo" value="${pqVO.prctQuesNo }"/>
		</c:if>
		<div>
			<ul class="challenge-nav">
				<li>
					<input type="text" name="prctQuesTtl" id="prctQuesTtl" placeholder="문제 제목을 입력해주세요." value="${pqVO.prctQuesTtl }">
					<select id="prctQuesDfflyCd" name="prctQuesDfflyCd">
						<option value="">난이도</option>
						<option value="1" <c:if test="${pqVO.prctQuesDfflyCd eq '1' }">selected</c:if>>Lv.1</option>
						<option value="2" <c:if test="${pqVO.prctQuesDfflyCd eq '2' }">selected</c:if>>Lv.2</option>
						<option value="3" <c:if test="${pqVO.prctQuesDfflyCd eq '3' }">selected</c:if>>Lv.3</option>
					</select>
				</li>
			</ul>
		</div>
		<div>
			<div>
				<div class="guide-section">
					<div>
						<div class="guide-section-description">
							<h4>문제 설명</h4>
							<textarea placeholder="문제 내용을 입력해 주세요." id="prctQuesCn" name="prctQuesCn">${pqVO.prctQuesCn }</textarea>
						</div>
						<hr/>
						<div class="guide-section-description">
						<h4>제한 사항</h4>
							<textarea placeholder="제한사항을 입력해 주세요." id="lmtMttr" name="lmtMttr">${pqVO.lmtMttr }</textarea>
						</div>
						<hr/>
						<div class="guide-section-description">
							<h4>입출력 예시</h4>
							<textarea placeholder="출력 예시를 입력해 주세요." id="ex" name="ex" >${pqVO.ex }</textarea>
							<h4>답안</h4>
							<textarea placeholder="답안을 입력해 주세요." id="ans" name="ans" >${pqVO.ans }</textarea>
						</div>
						<hr/>
						<div class="guide-section-description"></div>
					</div>
				</div>
				<div class="run-section">
			        <div id="monaco" style="width: 100%; height: 400px;"></div>
			        <hr/>
			        <h3 style="margin-left:10px;">실행 결과</h3>
			        <hr/>
			        <div class="resultDiv">
			        	<div style="color: #78909C; margin-left:10px; min-height: 250px;" id="compileRes">실행 결과가 여기에 표시됩니다.</div>
			        </div>
				</div>
			</div>
			<div class="button-section">
				<c:if test="${status eq 'insert' }">
					<button type="button" class="w3-button w3-green w3-round" id="registerBtn">등록</button>
				</c:if>
				<button type="button" class="w3-button w3-blue w3-round" id="listBtn">목록</button>
				<c:if test="${status eq 'update' }">
					<button type="button" class="w3-button w3-green w3-round" id="modifyBtn">수정</button>
					<button type="button" class="w3-button w3-red w3-round" id="deleteBtn">삭제</button>
				</c:if>
			</div>
		</div>
	</form>
	<script src="${ctxp }/resources/monacoEditorLib/min/vs/loader.js"></script>
	<script type="text/javascript">
		let editor;	
	
		let init = function(){
			require.config({ paths: { vs: '/resources/monacoEditorLib/min/vs' } });
		
			require(['vs/editor/editor.main'], function () {
					editor = monaco.editor.create(document.getElementById('monaco'), {
					value: ['public class Compiler { \n public static void main(String[] args) {\n \n }\n}'].join('\n'),
					language: 'java',
					theme: 'vs-dark',
					minimap: { enabled: false },
					fontSize: 25
				});
			});
			
			const monaco_test = new monaco.editor.create(document.getElementById('monaco'), setEditor([[${value}]], [[${language}]]));
		    $('#monaco').height((monaco_test.getModel().getLineCount() * 19) + 10); // 19 = 줄 높이, 10 = 세로 스크롤 높이
		}
		
		var prctQuesNoForm = $('#prctQuesNoForm');
		var modifyBtn = $('#modifyBtn');
		var deleteBtn = $('#deleteBtn');
		var listBtn = $('#listBtn');
		var registerBtn = $('#registerBtn');
		
		$(function(){
			modifyBtn.on('click', function(){
				var prctQuesTtl = $('#prctQuesTtl').val();
				var prctQuesCn = $('#prctQuesCn').val();
				var lmtMttr = $('#lmtMttr').val();
				var ex = $('#ex').val();
				var ans = $('#ans').val();
				var prctQuesDfflyCd = $('#prctQuesDfflyCd').val();
				
				
				if(prctQuesTtl == "" || prctQuesTtl == null){
					alert("문제 제목을 입력해주세요.");
					$('#prctQuesTtl').focus();
					return;
				}
				
				if(prctQuesCn == "" || prctQuesCn == null){
					alert("문제 설명을 입력해주세요.");
					$('#prctQuesCn').focus();
					return;
				}
				
				if(lmtMttr == "" || lmtMttr == null){
					alert("제한 사항을 입력해주세요.");
					$('#lmtMttr').focus();
					return;
				}
				
				if(ex == "" || ex == null){
					alert("입출력 예시를 입력해주세요.");
					$('#ex').focus();
					return;
				}
				
				if(ans == "" || ans == null){
					alert("답을 입력해주세요.");
					$('#ans').focus();
					return;
				}
				
				if(prctQuesDfflyCd == "" || prctQuesDfflyCd == null){
					alert("난이도를 설정해주세요.");
					$('#prctQuesDfflyCd').focus();
					return;
				}
				
				prctQuesNoForm.attr("action", "/admin/manage/updateCodingTest.do");
				prctQuesNoForm.submit();
			});
			
			deleteBtn.on('click', function(){
				if(confirm("삭제하시겠습니까?")){
					prctQuesNoForm.attr("action", "/admin/manage/deleteCodingTest.do");
					prctQuesNoForm.submit();
				}
			});
			
			listBtn.on('click', function(){
				location.href = "/admin/manage/codingTestList";
			});
			
			registerBtn.on('click', function(){
				var prctQuesTtl = $('#prctQuesTtl').val();
				var prctQuesCn = $('#prctQuesCn').val();
				var lmtMttr = $('#lmtMttr').val();
				var ex = $('#ex').val();
				var ans = $('#ans').val();
				var prctQuesDfflyCd = $('#prctQuesDfflyCd').val();
				
				
				if(prctQuesTtl == "" || prctQuesTtl == null){
					alert("문제 제목을 입력해주세요.");
					$('#prctQuesTtl').focus();
					return;
				}
				
				if(prctQuesCn == "" || prctQuesCn == null){
					alert("문제 설명을 입력해주세요.");
					$('#prctQuesCn').focus();
					return;
				}
				
				if(lmtMttr == "" || lmtMttr == null){
					alert("제한 사항을 입력해주세요.");
					$('#lmtMttr').focus();
					return;
				}
				
				if(ex == "" || ex == null){
					alert("입출력 예시를 입력해주세요.");
					$('#ex').focus();
					return;
				}
				
				if(ans == "" || ans == null){
					alert("답을 입력해주세요.");
					$('#ans').focus();
					return;
				}
				
				if(prctQuesDfflyCd == "" || prctQuesDfflyCd == null){
					alert("난이도를 설정해주세요.");
					$('#prctQuesDfflyCd').focus();
					return;
				}
				
				prctQuesNoForm.attr("action", "/admin/manage/insertCodingTest.do");
				prctQuesNoForm.submit();
			});
			
		});
	</script>
</body>
</html>

