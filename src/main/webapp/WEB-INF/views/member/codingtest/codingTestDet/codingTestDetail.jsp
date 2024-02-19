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
</style>
<body onload="init()">
	<div>
		<ul class="challenge-nav">
			<li>${codingTestVO.prctQuesTtl }</li>
		</ul>
	</div>
	<div>
		<form action="/member/updateSolutionYn" method="post" id="prctQuesNoForm">
			<input type="hidden" name="prctQuesNo" value="${codingTestVO.prctQuesNo }"/>
			<div>
				<div class="guide-section">
					<div>
						<div class="guide-section-description">
							<h4>문제 설명</h4>
							<p style="color: #B2C0CC">${codingTestVO.prctQuesCn }</p>
						</div>
						<hr/>
						<div class="guide-section-description">
						<h4>제한 사항</h4>
							<ul>
								<li style="color: #B2C0CC">${codingTestVO.lmtMttr }</li>
							</ul>
						</div>
						<hr/>
						<div class="guide-section-description">
							<h4>입출력 예시</h4>
							<ul>
								<li style="color: #B2C0CC" id="ex">${codingTestVO.ex }</li>
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
				<button type="button" class="w3-button w3-white w3-round" id="listBtn">목록</button>
				<button type="button" class="w3-button w3-green w3-round" id="runBtn">Run</button>
				<button type="button" class="w3-button w3-blue w3-round" id="submitBtn">제출하기</button>
			</div>
		</form>
	</div>
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
		
		$(function(){
			var writtenCode = $('#writtenCode');
			var runBtn = $('#runBtn');
			
		    runBtn.on('click', function(){
				var code = editor.getModel().getValue();
				console.log(code);
				
				var data = {
					code : code
				}
				
				$.ajax({
					type : "post",
					url : "/member/compileCode",
					data : JSON.stringify(data),
					contentType : "application/json;charset=utf-8",
					success : function(res){
						$('#compileRes').css("color", "#78909C");
						if(res.includes('오류: 기본 클래스 dynamic.Compiler을(를) 찾거나 로드할 수 없습니다.')) {
							$('#compileRes').css("color", "red");
						}
						$('#compileRes').html(res);
						writtenCode.val(code);
					}
				});
				
		    });
		    
		    var submitBtn = $('#submitBtn');
		    submitBtn.on('click', function(){
		    	var prctQuesNoForm = $('#prctQuesNoForm');
			    var compileRes = $('#compileRes').text();	// 내가 푼 문제의 답
			    var ex = $('#ex').text();					// 문제 정답 예시
		    	console.log("compileRes : " + compileRes);
		    	console.log("ex : " + ex);
		    	
		    	if(compileRes == ex){
		    		prctQuesNoForm.submit();
		    	}else{
		    		alert("정답이 일치하지 않습니다.");
		    	}
		    });
		    
		    var listBtn = $('#listBtn');
		    listBtn.on('click', function(){
		    	location.href = "/member/codingTestList";
		    });
		});
	</script>
</body>
</html>

