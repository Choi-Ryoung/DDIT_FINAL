<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<c:set var="ctxp" value="${pageContext.request.contextPath }"/>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <!-- 반응형 [s] -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="imagetoolbar" content="no">
    <!-- 반응형 [e] -->
    <meta name="naver-site-verification" content=""/><!-- 네이버 소유확인 -->
    <meta name="description" content=""><!-- 사이트 설명문구 -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="Sample">
    <meta property="og:description" content=""><!-- 사이트 설명문구 -->
    <meta property="og:image" content="${ctxp}/resources/img/common/logo.png">
    <meta property="og:url" content="">
	<title>Sample</title>
    <script src="${ctxp}/resources/js/jquery-ui.js"></script>
    <script src="${ctxp}/resources/js/jquery-1.8.3.min.js"></script>
    <script src="${ctxp}/resources/js/jquery.easing.min.js"></script>
    <script src="${ctxp}/resources/js/topmenu_script.js"></script>
    <script src="${ctxp}/resources/js/swiper.min.js"></script>
    <link rel="stylesheet" href="${ctxp}/resources/css/swiper.min.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_common.css">
    <link rel="stylesheet" href="${ctxp}/resources/css/sh_main.css">
</head>
<style>
@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300);

@prim: #53e3a6;

*{
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  
  font-weight: 300;
}

body{
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
  font-weight: 300;
  
  ::-webkit-input-placeholder { /* WebKit browsers */
    font-family: 'Source Sans Pro', sans-serif;
      color:    white;
    font-weight: 300;
  }
  :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
    font-family: 'Source Sans Pro', sans-serif;
     color:    white;
     opacity:  1;
    font-weight: 300;
  }
  ::-moz-placeholder { /* Mozilla Firefox 19+ */
    font-family: 'Source Sans Pro', sans-serif;
     color:    white;
     opacity:  1;
    font-weight: 300;
  }
  :-ms-input-placeholder { /* Internet Explorer 10+ */
    font-family: 'Source Sans Pro', sans-serif;
     color:    white;
    font-weight: 300;
  }
}

.wrapper{
  background: #50a3a2;
background: -webkit-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
background: -moz-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
background: -o-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
background: linear-gradient(to bottom right, #50a3a2 0%, #53e3a6 100%);
  
  position: absolute;
  top: 50%;
  left: 0;
  width: 100%;
  height: 400px;
  margin-top: -200px;
  overflow: hidden;
  
  &.form-success{
    .container{
      h1{
        transform: translateY(85px);
      }
    }
  }
}

.container{
  max-width: 600px;
  margin: 0 auto;
  padding: 80px 0;
  height: 400px;
  text-align: center;
  
  h1{
    font-size: 40px;
    transition-duration: 1s;
    transition-timing-function: ease-in-put;
    font-weight: 200;
  }
}

form{
  padding: 20px 0;
  position: relative;
  z-index: 2;
  
  input{
    display: block;
    appearance: none;
    outline: 0;
    border: 1px solid fade(white, 40%);
    background-color: fade(white, 20%);
    width: 250px;
    
    border-radius: 3px;
    padding: 10px 15px;
    margin: 0 auto 10px auto;
    display: block;
    text-align: center;
    font-size: 18px;
    
    color: white;
    
    transition-duration: 0.25s;
    font-weight: 300;
    
    &:hover{
      background-color: fade(white, 40%);
    }
    
    &:focus{
      background-color: white;
      width: 300px;
      
      color: @prim;
    }
  }
  
  button{
    appearance: none;
    outline: 0;
    background-color: white;
    border: 0;
    padding: 10px 15px;
    color: @prim;
    border-radius: 3px;
    width: 250px;
    cursor: pointer;
    font-size: 18px;
    transition-duration: 0.25s;
    
    &:hover{
      background-color: rgb(245, 247, 249);
    }
  }
}

.bg-bubbles{
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  
  z-index: 1;
  
  li{
    position: absolute;
    list-style: none;
    display: block;
    width: 40px;
    height: 40px;
    background-color: fade(white, 15%);
    bottom: -160px;
    
    -webkit-animation: square 25s infinite;
    animation:         square 25s infinite;
    
    -webkit-transition-timing-function: linear;
    transition-timing-function: linear;
    
    &:nth-child(1){
      left: 10%;
    }
    
    &:nth-child(2){
      left: 20%;
      
      width: 80px;
      height: 80px;
      
      animation-delay: 2s;
      animation-duration: 17s;
    }
    
    &:nth-child(3){
      left: 25%;
      animation-delay: 4s;
    }
    
    &:nth-child(4){
      left: 40%;
      width: 60px;
      height: 60px;
      
      animation-duration: 22s;
      
      background-color: fade(white, 25%);
    }
    
    &:nth-child(5){
      left: 70%;
    }
    
    &:nth-child(6){
      left: 80%;
      width: 120px;
      height: 120px;
      
      animation-delay: 3s;
      background-color: fade(white, 20%);
    }
    
    &:nth-child(7){
      left: 32%;
      width: 160px;
      height: 160px;
      
      animation-delay: 7s;
    }
    
    &:nth-child(8){
      left: 55%;
      width: 20px;
      height: 20px;
      
      animation-delay: 15s;
      animation-duration: 40s;
    }
    
    &:nth-child(9){
      left: 25%;
      width: 10px;
      height: 10px;
      
      animation-delay: 2s;
      animation-duration: 40s;
      background-color: fade(white, 30%);
    }
    
    &:nth-child(10){
      left: 90%;
      width: 160px;
      height: 160px;
      
      animation-delay: 11s;
    }
  }
}

@-webkit-keyframes square {
  0%   { transform: translateY(0); }
  100% { transform: translateY(-700px) rotate(600deg); }
}
@keyframes square {
  0%   { transform: translateY(0); }
  100% { transform: translateY(-700px) rotate(600deg); }
}
</style>
<script>
$("#login-button").click(function(event){
    event.preventDefault();
  
  $('form').fadeOut(500);
  $('.wrapper').addClass('form-success');
});

</script>
<body>

<!-- sh_wrapper [s] -->
<div id="sh_wrapper" class="sub">
    <!-- sh_hd [s] -->
    <div id="sh_hd">
        <div class="top_nav_bg"></div>
    	<div id="sh_hd_wrapper">
            <!-- sh_nav_wrap [s] -->
            <div id="sh_nav_wrap">	
                <h1 id="sh_top_logo"><a href="index.html"><img src="${ctxp}/resources/img/common/logo.png" alt="Sample" /></a></h1>
                <!-- sh_nav [s] -->
                <ul id="sh_nav">
                    <li class="menu-item active">
                        <a href="sub1.html">회사소개</a>
                        <ul class="sh_nav_s">
                            <li><a href="sub1.html">회사소개</a></li>
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="">사업안내</a>
                        <ul class="sh_nav_s">
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="">서비스 분야</a>
                        <ul class="sh_nav_s">
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="">마케팅 최적화</a>
                        <ul class="sh_nav_s">
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="">고객센터</a>
                        <ul class="sh_nav_s">
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                            <li><a href="">소메뉴</a></li>
                        </ul>
                    </li>
                </ul>
                <div id="menuLine"></div>
                <!-- sh_nav [e] -->
                
                <!-- pfWrap [s] -->
                <div id="pfBtn">
                    <img src="${ctxp}/resources/img/common/btn.png" alt="전체메뉴 버튼" />
                </div>
                <div id="pfWrap">
                    <div class="pf_cate">
                        <ul>
                            <li><a href="sub1.html"><span class="nav_num">01</span>회사소개</a></li>
                            <li><a href=""><span class="nav_num">02</span>사업안내</a></li>
                            <li><a href=""><span class="nav_num">03</span>서비스 분야</a></li>
                            <li><a href=""><span class="nav_num">04</span>마케팅 최적화</a></li>
                            <li><a href=""><span class="nav_num">05</span>고객센터</a></li>
                        </ul>
                        <a class="ct_link" href=''>Contact Us</a>
                    </div>
                </div>
                <!-- pfWrap [e] -->
            </div>
            <!-- sh_nav_wrap [e] -->

            <!-- 반응형메뉴 [s] -->
            <div id="topmenuM">
                <h1 id="m_logo"><a href="index.html"><img src="${ctxp}/resources/img/common/logo.png" alt="Sample" /></a></h1>
                <!-- 메뉴 버튼 -->
                <div id="m_navBtn"><span></span></div>
                <!-- 오픈 메뉴 -->
                <div id="navWrap">
                    <div class="inner">
                        <ul class="m_lnb">
                            <li>
                                <button class="m_bmenu" type="button">대분류</button>
                                <ul class="m_smenu">
                                    <li><a href="sub1.html">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                </ul>
                            </li>
                            <li>
                                <button class="m_bmenu" type="button">대분류</button>
                                <ul class="m_smenu">
                                    <li><a href="">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                </ul>
                            </li>
                            <li>
                                <button class="m_bmenu" type="button">대분류</button>
                                <ul class="m_smenu">
                                    <li><a href="">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                    <li><a href="">소분류</a></li>
                                </ul>
                            </li>
                        </ul>   
                        <p class="mo_hd_copy">ⓒ Sample</p>         
                    </div>
                </div>
            </div>
            <!-- 반응형메뉴 [e] --> 
		</div>            
    </div>
    <!-- sh_hd [e] -->
    
    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <!-- sh_sub_banner [s] -->
            <div id="sh_sub_banner">
                <div id="sh_content_tit">
                    <h3>회사소개</h3>
                    <p><a href="/"><i class="fa fa-home"></i><span class="sound_only">홈으로</span></a> 
                    <i class="fa fa-angle-right"></i> 회사소개 <i class="fa fa-angle-right"></i> 회사소개</p>
                </div>
            </div>
            <!-- sh_sub_banner [e] -->
            <!-- sh_aside [s] -->
            <div id="sh_aside">
    	        <div id="sh_snb">
                    <ul>
                        <li><a class="on" href="">회사소개</a></li>
                        <li><a href="">소분류</a></li>
                        <li><a href="">소분류</a></li>
                    </ul>            
				</div>
            </div>
            <!-- sh_aside [e] -->
            
            <!-- sh_content [s] -->
            <div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
                    <div class="tit_area">
                        빠르게 발전하고있는 Smart IT 세상<br />
                        <p><b>IT상장기업 샤이닝</b>이 여러분과 함께 만들어 갑니다.</p>
                    </div>
                    <div class="img"></div>
                    <div class="cont">
                        <p class="st">먼저 고객 여러분의 변함없는 관심과 사랑에 깊이 감사드립니다.</p>
                        <div class="pl">저희 샤이닝은수익창출만을 위한 경영이념보다는 함께 공유하고 함께 커갈수 있는
                        친구같은 파트너로서 사람을 위한 기술로 보다 윤택하고 신선하게 변화시키기 위해 모든 역량을 집중하고 있습니다.</div><br />  
                        <div class="pl">나태하지 않고, 현실에 안주하지 않는 자세로 끊임 없는 도전과 혁신으로 현 분야의 최고의 기업이 되기위해
                        함께 생각하고 함께 이뤄내는 샤이닝이 되고자 합니다.
                        언제나 지켜봐주시는 분들에게 실망되지 않는 기업이 되겠습니다.<br />              
                        감사합니다.</div>
                        <p class="sign">샤이닝 <span>임직원 일동</span></p>
                    </div>
                </div>
                <!-- 서브페이지 [e] -->
            </div>
            <!-- sh_content [s] -->            
        </div>
        <!-- sh_container_wrapper [e] -->
    </div>
    <!-- sh_container [e] -->
    
    <div id="sh_ft_btns">
        <div class="btns">
            <a class="tel" href="tel:15446062"><i class="fa fa-phone"></i>1544-6062</a>
        </div>
    </div>
    <a id="fix_tel" href="tel:15446062"><i class="fa fa-phone"></i></a>
    
    <!-- sh_ft [s] -->
    <div id="sh_ft">
        <div class="info">
            <span>Sample</span>
            경기도 부천시 부흥로 258 일산빌딩 5층 샤이닝<br />
            사업자 번호 : 130-37-46318(등록2007년) 통신판매업종신고 : 제2010-경기부천-924호 상호 : 샤이닝 대표 : 오성민<br />
            고객센터:1544-0634 팩스:0505-200-6060 이메일:hdweb@hdweb.co.kr
        </div>
        <div class="copy">
            <div class="copy_wrap">
                <span>ⓒ <b>Sample</b>  All rights reserved.</span>     
            </div>        
        </div>
    </div>
    <!-- sh_ft [e] -->
</div>
<!-- sh_wrapper [e] -->
    
    
</body>
</html>


