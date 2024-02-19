<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/dashboard/">
<c:if test="${not empty message }">
<script type="text/javascript">
alert("${message}");
<c:remove var="message" scope="request"/>
<c:remove var="message" scope="session"/>
</script>
</c:if>
  <div id="sh_container"> 
	<div id="sh_container_wrapper">
			<div id="sh_content">
				<div id="greeting" class="pagecommon">
				
					<div class="row">
						<div class="col-md-12">
							<div class="card card-outline card-danger mt-4">
								<div class="col-md-12 px-0">
									<img src="${ctxp}/resources/img/main/menu_banner/나의통계.jpg"
										width="1100px" height="300px">
								</div>
							</div>
							<br>
						</div>
						<nav>
							<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
								<button class="nav-link " data-bs-toggle="tab"
									data-bs-target="#nav-home" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="true"
									onclick="location.href='${ctxp}/member/mypage/myInfo'">회원
									정보</button>
								<button class="nav-link " data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false"
									onclick="location.href='${ctxp}/member/mentoUpdate'">멘토링
									정보</button>
								<button class="nav-link " data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false"
									onclick="location.href='${ctxp}/member/mypage/applyList'">지원
									내역</button>
								<button class="nav-link " data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false"
									onclick="location.href='${ctxp}/member/mypage/selectPrpsList'">이직/취업
									제안</button>
								<button class="nav-link active" data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false">나의
									통계</button>
								<button class="nav-link" data-bs-toggle="tab"
									data-bs-target="#nav-profile" type="button" role="tab"
									aria-controls="nav-profile" aria-selected="false"
									onclick="location.href='${ctxp}/member/mypage/resumeList'">이력서
									관리</button>
							</div>
						</nav>
						<div class="row mb-3">
                			<span class="text-black fs-5">사이트 방문 횟수</span>
               				<canvas id="daily-chart" width="1300" height="300"></canvas>
               			</div><hr>
						<div class="row mb-3">
                			<span class="text-black fs-5">직무별 채용공고 지원수</span>
               				<canvas id="duty-chart" width="1300" height="300"></canvas>
               			</div><hr>
               		<%-- 	<div class="row">
                			<span class="text-black fs-5">직무별 지원 횟수</span>
               				<canvas id="apply-chart" width="1300" height="300"></canvas>
               			</div> --%>
               			<div class="row  mt-3 mb-3">
                			<span class="text-black fs-5">이직 제안 받은 횟수</span>
               				<canvas id="proposal-chart" width="1300" height="300"></canvas>
               			</div><hr>
					</div>
				</div>
			</div>
		</div>
	</div>


<script>
new Chart(document.getElementById("daily-chart"), {
    type: 'bar',
    data: {
      labels: ["02/10", "02/11", "02/12", "02/13", "02/14", "02/15", "02/16"],
      datasets: [{ 
          data: [1,0,6,0,1,1,4],
          label: "방문 횟수",
          backgroundColor: "cornflowerblue", // 막대의 내부 색깔
          fill: false
        },
      ]
    },
    options: {
    	responsive: false,
      title: {
        display: true,
        text: '방문 횟수'
      }
    }
  });

  new Chart(document.getElementById("duty-chart"), {
    type: 'bar',
    data: {
      labels: ["프론트엔드 개발자", "서버/백엔드 개발자", "웹 풀스택 개발자", "안드로이드 개발자", "IOS 개발자", "웹 디자이너", "웹 퍼블리셔", "빅데이터엔지니어", "게임 서버 개발자", "DBA","기타"],
      datasets: [{ 
          data: [10,0,0,0,3,15,1,0,0,0,5],
          label: "공고 지원수",
          backgroundColor: "cornflowerblue", // 막대의 내부 색깔
          fill: false
        },
      ]
    },
    options: {
    	responsive: false,
      title: {
        display: true,
        text: '공고 지원수'
      }
    }
  });
  
 /*  new Chart(document.getElementById("apply-chart"), {
	    type: 'line',
	    data: {
	      labels: ["프론트엔드 개발자", "서버/백엔드 개발자", "웹 풀스택 개발자", "안드로이드 개발자", "IOS 개발자", "웹 디자이너", "웹 퍼블리셔", "빅데이터엔지니어", "게임 서버 개발자", "DBA","기타"],
	      datasets: [{ 
	          data: [10,0,0,0,3,15,1,0,0,0,5],
	          label: "지원 횟수",
	          backgroundColor: "cornflowerblue", // 막대의 내부 색깔
	          fill: false
	        },
	      ]
	    },
	    options: {
	    	responsive: false,
	      title: {
	        display: true,
	        text: '월별 지원 현황'
	      }
	    }
	  }); */
  
  new Chart(document.getElementById("proposal-chart"), {
	    type: 'line',
	    data: {
	      labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월","11월","12월"],
	      datasets: [{ 
	          data: [3,20,17,4,3,1,1,0,0,0,5,1],
	          label: "제안 횟수",
	          backgroundColor: "cornflowerblue", // 막대의 내부 색깔
	          fill: false
	        },
	      ]
	    },
	    options: {
	    	responsive: false,
	      title: {
	        display: true,
	        text: '제안 횟수'
	      }
	    }
	  });
  
  
</script>

	         
		
