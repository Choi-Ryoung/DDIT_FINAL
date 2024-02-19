<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<h1>차트다</h1>

<div style="display: flex; justify-content: center;">
    <canvas id="chart1" width="450" height="350"></canvas>
    	<div style="margin-left: 100px;"></div> <!-- 간격조정용 -->
    <canvas id="chart2" width="450" height="350"></canvas>
</div>

<div style="display: flex; justify-content: center; margin-top:100px; ">
  <canvas id="chart3" width="450" height="450"></canvas>
   	<div style="margin-left: 100px;"></div> <!-- 간격조정용 -->
  <canvas id="chart4" width="450" height="450"></canvas>
</div>

<div style="display: flex; justify-content: center; margin-top:100px;">
  <canvas id="chart5" width="450" height="450"></canvas>
   	<div style="margin-left: 100px;"></div> <!-- 간격조정용 -->
  <canvas id="chart6" width="450" height="450"></canvas>
</div>

<div style="display: flex; justify-content: center; margin-top:100px; margin-bottom:100px;">
  <canvas id="chart7" width="450" height="450"></canvas>
   	<div style="margin-left: 100px;"></div> <!-- 간격조정용 -->
  <canvas id="chart8" width="450" height="450"></canvas>
</div>



<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

<script>
	//남녀성비차트
    new Chart(document.getElementById("chart1"), {
        type: 'pie',
        data: {
            labels: ["남자", "여자"],
            datasets: [{
                data: [7400, 2600],
                label: "회원 남녀 성비",
                backgroundColor: ["lightblue", "pink"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '회원 남녀 성비'
            }
        }
    });
	
	//연령대별 차트
	    new Chart(document.getElementById("chart2"), {
        type: 'bar',
        data: {
            labels: ["10대","20대","30대","40대","50대이상"],
            datasets: [{
                data: [356, 1254, 1878, 954, 565],
                label: "일반회원 연령대",
                backgroundColor: ["#6E6E6E"/* , "#00FF00","#008080","#C0C0C0","#800000" */] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '일반회원 연령대'
            }
        }
    });
	
		//기업의 구인 선호경력 차트
	    new Chart(document.getElementById("chart3"), {
        type: 'bar',
        data: {
            labels: ["신입","3년이상","5년이상","10년이상"],
            datasets: [{
                data: [154, 350, 254, 34],
                label: "기업의 채용희망 경력",
                backgroundColor: ["#1E90FF"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '기업의 채용희망 경력'
            }
        }
    });
		
		//직무별 채용공고
	    new Chart(document.getElementById("chart4"), {
        type: 'line',
        data: {
        	labels: ["서버/백엔드", "프론트엔드", "웹 풀스택", "안드로이드", "ios", "게임 클라이언트", "DBA", "개발PM", "정보보안 담당자", "웹퍼블리셔", "블록체인", "빅데이터"],
            datasets: [{
            	data: [578,666,897,765,507,611,433,621,853,380,433,450],
                label: "직무별 채용공고",
                backgroundColor: ["#FE2E2E"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '직무별 채용공고'
            }
        }
    });
		
		//언어별 태그등록
	    new Chart(document.getElementById("chart5"), {
        type: 'doughnut',
        data: {
        	labels: ["Java", "C++", "JavaScript", "Mysql", "React", "Python", "C#"],
            datasets: [{
            	data: [578,666,897,765,507,611,433],
                label: "회원의 가능언어등록통계",
                backgroundColor: ["#F6CECE","#F5F6CE","#CEF6CE","#CEF6E3","#CEECF5","#CECEF6","#ECCEF5"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '회원의 가능언어등록통계'
            }
        }
    });
		
		//채용공고 등록지역
	    new Chart(document.getElementById("chart6"), {
        type: 'bar',
        data: {
        	labels: ["서울", "경기", "인천", "경북", "경남", "전남", "전북", "충청", "대전", "세종", "강원"],
            datasets: [{
            	data: [354,284,250,35,21,12,19,35,124,142,1],
                label: "공고별 모집지역",
                backgroundColor: ["#0404B4"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '공고별 모집지역'
            }
        }
    });
		
		//월별 기업 채용건수
	    new Chart(document.getElementById("chart7"), {
        type: 'line',
        data: {
        	labels: ["3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월", "1월", "2월"],
            datasets: [{
            	data: [178,166,97,65,87,61,33,61,53,30,43,150],
                label: "월별 기업 채용건수",
                backgroundColor: ["#C2CFC4"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
            responsive: false,
            title: {
                display: true,
                text: '회원 남녀 성비'
            }
        }
    });
		
		//기업회원 규모비율
	    new Chart(document.getElementById("chart8"), {
        type: 'bar',
        data: {
        	labels: [ "대기업", "중견기업", "중소기업", "스타트업"],
            datasets: [{
            	data: [58,166,197,265],
                label: "기업회원 규모비율",
                backgroundColor: ["#8181F7"] // 각 항목의 색상을 배열로 지정
            }]
        },
        options: {
        	indexAxis:'y',
            responsive: false,
            title: {
                display: true,
                text: '기업회원 규모비율'
            }
        }
    });
</script>
