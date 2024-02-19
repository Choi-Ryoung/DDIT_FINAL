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
		min-height: 150px;
		padding-top: 2em;
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
	#options{
		visibility: hidden;
	}
</style>
<body onload="init()">
	<div>
		<ul class="challenge-nav">
			<li>${entPq.entPqTtl }</li>
		</ul>
	</div>
	<div>
		<div>
			<div class="guide-section">
				<div>
					<div class="guide-section-description">
						<h4>문제 설명</h4>
						<p style="color: #B2C0CC">${entPq.entPqCn }</p>
					</div>
					<hr/>
					<div class="guide-section-description">
					<h4>제한 사항</h4>
						<ul>
							<li style="color: #B2C0CC">${entPq.entLmtMttr }</li>
						</ul>
					</div>
					<hr/>
					<div class="guide-section-description">
						<h4>입출력 예시</h4>
						<ul>
							<li style="color: #B2C0CC" id="ex">${entPq.ex }</li>
						</ul>
					</div>
					<hr/>
					<div class="guide-section-description"></div>
				</div>
			</div>
			<div class="run-section">
		        <div id="monaco" style="width: 100%; height: 400px;"><input type="hidden" id="writtenCode" name="prctQuesAns"></div>
		        <hr/>
		        <h3 style="margin-left:10px;">실행 결과</h3>
		        <hr/>
		        <div class="resultDiv">
		        	<div style="color: #78909C; margin-left:10px; min-height: 250px;" id="compileRes">실행 결과가 여기에 표시됩니다.</div>
		        </div>
			</div>
		</div>
		<div class="button-section">
			<c:if test="${prevIdx ne -1 }">
				<button type="button" class="w3-button w3-orange w3-round" id="beforeBtn">이전 문제</button>
			</c:if>
			<c:if test="${nextIdx ne -1 }">
				<button type="button" class="w3-button w3-orange w3-round" id="nextBtn">다음 문제</button>
			</c:if>
			<button type="button" class="w3-button w3-blue w3-round" id="submitBtn">제출하기</button>
		</div>
	</div>
	
	<form action="/apply/nextCodingTest" method="post" id="codingForm">
		<input type="hidden" name="entPqNo" id="entPqNo" value="${entPq.entPqNo }"/>
		<input type="hidden" name="entMbrId" value="${entMbrId }"/>
		<input type="hidden" name="empmnPbancNo" value="${empmnPbancNo }"/>
		<input type="hidden" name="idx" value="${idx }"/>
		<input type="hidden" name="answer" value="" id="answer"/>
		<input type="hidden" name="entPqNoList" value="" id="entPqNoList"/>
		<input type="hidden" name="curTime" value="${curTime }" id="curTime"/>
	</form>
	
	<script src="${ctxp }/resources/monacoEditorLib/min/vs/loader.js"></script>
	<script type="text/javascript">
		let editor;	
	
		let value = "";
		if("${idx}" != null || "${idx}" != ""){
			value = window.localStorage.getItem("answer${idx}");
			if(window.localStorage.getItem("answer${idx}") == "" || window.localStorage.getItem("answer${idx}") == null){
				value = 'public class Compiler { \n public static void main(String[] args) {\n \n }\n}';
			}
		}else{
			value = 'public class Compiler { \n public static void main(String[] args) {\n \n }\n}';
		}
		
		let init = function(){
			require.config({ paths: { vs: '/resources/monacoEditorLib/min/vs' } });
		
			require(['vs/editor/editor.main'], function () {
					editor = monaco.editor.create(document.getElementById('monaco'), {
					value: [value].join('\n'),
					language: 'java',
					theme: 'vs-dark',
					minimap: { enabled: false },
					fontSize: 25
				});
			});
			
			const monaco_test = new monaco.editor.create(document.getElementById('monaco'), setEditor([[${value}]], [[${language}]]));
		    $('#monaco').height((monaco_test.getModel().getLineCount() * 19) + 10); // 19 = 줄 높이, 10 = 세로 스크롤 높이
		}
		
		$(function(){
			var nextBtn = $("#nextBtn");
			var beforeBtn = $("#beforeBtn");
			var submitBtn = $("#submitBtn");
			var answerData = [];
			var entPqNoData = [];
			var timerData = [];
			
			nextBtn.on("click", function(){
				console.log("${idx}");
				if(confirm("다음 문제로 이동하시겠습니까?")){
					answerData.push(editor.getModel().getValue());
					entPqNoData.push($('#entPqNo').val());
					timerData.push($('#Timer').val());
					
					if("${idx}" == 0){
						$('#curTime').val($('#Timer').val());
					}
					
					window.localStorage.setItem("answer${idx}", answerData);
					window.localStorage.setItem("entPqNo${idx}", entPqNoData);
					window.localStorage.setItem("timerData${idx}", timerData);
					
					$("#codingForm").submit();
				}
			});
			
			beforeBtn.on("click", function(){
				if(confirm("이전 문제로 이동하시겠습니까?")){
					$("#codingForm").attr("action", "/apply/prevCodingTest");
					$("#codingForm").submit();
				}
			});
			
			submitBtn.on("click", function(){
				if(confirm("제출 하시겠습니까?")){
					$("#codingForm").attr("action", "/apply/submitCodingTest");
					answerData.push(editor.getModel().getValue());
					entPqNoData.push($('#entPqNo').val());
					window.localStorage.setItem("answer${4}", answerData);
					window.localStorage.setItem("entPqNo${idx}", entPqNoData);
					
					var codingSource = "";
					
					codingSource += window.localStorage.getItem("answer${0}");
					codingSource += "___";
					codingSource += window.localStorage.getItem("answer${1}");
					codingSource += "___";
					codingSource += window.localStorage.getItem("answer${2}");
					codingSource += "___";
					codingSource += window.localStorage.getItem("answer${3}");
					codingSource += "___";
					codingSource += window.localStorage.getItem("answer${4}");
					
					console.log(codingSource);
					
					$('#answer').val(codingSource);
					
					localStorage.removeItem("answer${0}");
					localStorage.removeItem("answer${1}");
					localStorage.removeItem("answer${2}");
					localStorage.removeItem("answer${3}");
					localStorage.removeItem("answer${4}");
					
					let entPqNoSource = "";
					
					entPqNoSource += window.localStorage.getItem("entPqNo${0}");
					entPqNoSource += "___";
					entPqNoSource += window.localStorage.getItem("entPqNo${1}");
					entPqNoSource += "___";
					entPqNoSource += window.localStorage.getItem("entPqNo${2}");
					entPqNoSource += "___";
					entPqNoSource += window.localStorage.getItem("entPqNo${3}");
					entPqNoSource += "___";
					entPqNoSource += window.localStorage.getItem("entPqNo${4}");

					$('#entPqNoList').val(entPqNoSource);
					
					localStorage.removeItem("entPqNo${0}");
					localStorage.removeItem("entPqNo${1}");
					localStorage.removeItem("entPqNo${2}");
					localStorage.removeItem("entPqNo${3}");
					localStorage.removeItem("entPqNo${4}");
					
					localStorage.removeItem("timerData${0}");
					localStorage.removeItem("timerData${1}");
					localStorage.removeItem("timerData${2}");
					localStorage.removeItem("timerData${3}");
					localStorage.removeItem("timerData${4}");
					
					$("#codingForm").submit();
				}
			});
			
// 			const value = window.localStorage.getItem("answer${idx}");

// 			// Hover on each property to see its docs!
// 			const myEditor = monaco.editor.create(document.getElementById("monaco"), {
// 				value,
// 				language: "java",
// 				theme: 'vs-dark',
// 				minimap: { enabled: false },
// 				fontSize: 25
// 			});
		});
</script>
</body>
</html>

