<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctxp}/resources/css/member/chat.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctxp}/resources/sockjs.min.js"></script>

<style>

.padding{
	background-image: url("${ctxp}/resources/img/common/채팅배경.jpeg");
}

.container{
	max-width: 500px;
}

#closeBtn {
    margin-top: 8px;
}

#message {
	width: 36%;
    margin-bottom: 10px;
}


#chat {
	overflow-y:auto;
	max-height: 500px;
	height: 500px;
	font-size: 16px;
	width: 100%;
	padding: 3px;
	background-image: url("${ctxp}/resources/img/common/채팅배경3.jpg");
}

.message-box {
	border: 1px solid yellow;
	border-radius: 10px;
	background-color: yellow;
	display: inline-block;
	max-width: 200px;
	padding: 5px;
	margin: 3px;
	text-align: left;
}

#clear{
	margin-bottom: 8px;
}
</style>

<form id="chatForm">
	<input type="hidden" name="prMbrNcnm" id="prMbrNcnm" value="${SessionInfo.prMbrNcnm }"/>
	<input type="hidden" name="prmbrncnm" id="roomNcnm" value="${roomVO.prMbrNcnm }"/>
<!-- <div class="page-content page-container" id="page-content"> -->
    <div class="padding" >
        <div class="container">
<!-- <div class="col-md-6"> -->
            <div class="card card-bordered">
              <div class="card-header">
                <h4 class="card-title"><strong>${mentoInfo.menNcnm}</strong></h4>
                <button type="button" class="btn btn-outline-secondary" onclick="closeSocket()">나가기</button>
              </div>

			
              <div id="chat">
              
                  <!-- <img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="..."> -->
					<%-- <c:set value="${chatList }" var="chatList"/>
					<c:forEach items="${chatList }" var="chat">
						<c:choose>
							<c:when test="${SessionInfo.prMbrNcnm eq roomVO.prMbrNcnm}">
						        <div style="text-align:right;">
						            <div class="message-box">
						                <c:out value="${chat.msg}"/>
						            </div>
						        </div>
						    </c:when>
							<c:otherwise>
								<div style='text-align:left;'>
										<c:out value="${mentoInfo.menNcnm}"/><br>
									<div class='message-box'>
										<c:out value="${chat.msg }"/>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach> --%>
					<c:set value="${chatList}" var="chatList"/>
						<c:forEach items="${chatList}" var="chat">
						    <c:choose>
						        <c:when test="${SessionInfo.prMbrNcnm eq chat.prMbrNcnm}">
						            <div style="text-align:right;">
						                <div class="message-box">
						                    <c:out value="${chat.msg}"/>
						                </div>
						            </div>
						        </c:when>
						        <c:otherwise>
						            <div style="text-align:left;">
						                <c:out value="${chat.prMbrNcnm}"/><br>
						                <div class="message-box">
						                    <c:out value="${chat.msg}"/>
						                </div>
						            </div>
						        </c:otherwise>
						    </c:choose>
						</c:forEach>

              <!-- <div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;"><div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;"><div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div></div> -->
              </div>

              <div class="publisher bt-1 border-light">
                <img class="avatar avatar-xs" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
                <input class="publisher-input" type="text" id="message" placeholder="Write something">
                <span class="publisher-btn file-group">
                  <!-- <i class="fa fa-paperclip file-browser"></i> -->
                  
                </span>
                <!-- <a class="publisher-btn" href="#" data-abc="true"><i class="fa fa-smile"></i></a> -->
                <button id="send" class="btn btn-outline-primary" onkeypress="enter(event)">전송</button>
              </div>

             </div>
          </div>
          </div>
          <!-- </div> -->
         <!--  </div> -->
          </form>
<script>
var prMbrNcnm = "${SessionInfo.prMbrNcnm}";
var roomNcnm = "${roomVO.prMbrNcnm }";
var prMbrId = "${SessionInfo.prMbrId}";
var date = new Date();
var chat = $("#chat").val();
var hours = ('0' + date.getHours()).slice(-2);
var minutes = ('0' + date.getMinutes()).slice(-2);
var apm = ""; 

if(hours > 12) {
	apm = "오후 " + (hours - 12) + ":" + minutes;
} else {
	apm = "오전 " + hours + ":" + minutes;
}

console.log(prMbrNcnm);
console.log(roomNcnm);
console.log(prMbrId);
console.log(apm);

console.log(minutes);
console.log(hours);
console.log(date);
   $(document).ready(function () {
       var sock = new SockJS("/echo");
       sock.onopen = function () {
           console.log("연결완료");

       }
       sock.onmessage = function (e) {
           console.log("receive : " + e.data);
           // 메시지가 사용자로부터 온 것인지, 다른 사람으로부터 온 것인지 확인
           var messageContent = e.data;
           var chat = $("#chat");
           chat.append(messageContent);
           chat.scrollTop(chat[0].scrollHeight);
       }

       $("#chatForm").submit(function (event) {
           event.preventDefault();
           var chat = $("#chat");
           var msg = $("#message").val();
           console.log("send : " + msg);
           if(msg == null || msg == ''){
				return;        	   
           } else {
	           sock.send(msg);
           }
           $("#message").val('').focus();
           chat.scrollTop(chat[0].scrollHeight);
       });

function enter(event) {
	event.preventDefault();
	var chat = $("#chat");
	var msg = $("#message").val();
	console.log("send : " + msg);
	if(msg == null || msg == ''){
		return;        	   
	} else {
		sock.send(msg);
	}
	$("#message").val('').focus();
	chat.scrollTop(chat[0].scrollHeight);
}


   $("#clear").on("click", function(e){
   	$("#chat").empty();
      });

     });
   
function closeSocket() {
	if(confirm("정말로 나가시겠습니까?")) {
        location.href = "/mento/find?menNcnm=${mentoInfo.menNcnm}";
        var close = "<div style='text-align:center;'>연결 종료</div><br>"
		$("#chat").append(close);
	}
	
	/* var close = sock.close();
	var close = true; */
}
/* closeConnection = function () {
	if(confirm("정말로 나가시겠습니까?")) {
           var close = sock.close();
           var close = true;
           if(close) {
           	location.href = "/mento/find?menNcnm=${menNcnm}";
           }
		$("#chat").append("연결 종료");
	}
          
      } */
</script>
          