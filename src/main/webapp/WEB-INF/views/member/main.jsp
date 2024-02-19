<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />


<style>
	#empAnc{
		width: 290px;
		height: 200px;
	}
	
	.br-top
	{
		border-top : 4px solid cornflowerblue;
	}
</style>

	     <!-- sh_container [s] -->
	    <div id="sh_container">
	        <!-- sh_container_wrapper [s] -->
	        <div id="sh_container_wrapper">
	            <!-- sh_main_banner [s] -->
	            <div id="sh_main_banner">
	                <div class="swiper-container sh_main_swiper">
	                    <ul class="sh_main_img swiper-wrapper">
	                        <li class="box1 swiper-slide"></li>
	                        <li class="box2 swiper-slide"></li>
	                        <li class="box3 swiper-slide"></li>
	                    </ul>
	                </div>
	
	                <div class="sh_txt_box">
	                    <div class="swiper-pager"></div>
	                </div>    
	
	                <script>
	                $(document).ready(function(){
	                	$.ajax({
	                	    url: '/resumeChk.do', // 요청을 보낼 URL
	                	    method: 'GET', // HTTP 메서드 (GET, POST, PUT, DELETE 등)
	                	    data:null,
	                	    success: function(response) { // 요청이 성공했을 때 실행되는 콜백 함수
	                	       if(response.session == '1' && response.result == '0')
	                	    	{
	                	    	   swal({
	                	    			title: "이력서가 없습니다.\n",
	                	    			text : "이력서를 등록하러 이동하시겠습니까?",
	                	    			type: "warning",
	                	    			showCancelButton: true,
	                	    			confirmButtonColor: "#DD6B55",
	                	    			confirmButtonText: "예",
	                	    			cancelButtonText: "아니요",
	                	    			closeOnConfirm: false,
	                	    			closeOnCancel : true
	                	    		}, function (isConfirm) {
	                	    			if (isConfirm) {
	                	    				location.href="${ctxp}/member/mypage/resumeList";
	                	    				return;
	                	    			}else{
	                	    				return;
	                	    			}
	                	    		});
	                	    	  
	                	    	}
	                	       else
	                	    	{
	                	    	  return; 
	                	    	}
	                	    },
	                	});
	                	
	                	
	                	
	                    $('.sh_txt_box .move_txt01').delay(200).animate({"margin-top":"0","opacity":"1"},600);
	                    $('.sh_txt_box .move_txt02').delay(600).animate({"opacity":"1"},600);
	                    $('.sh_txt_box .swiper-pager').delay(600).animate({"opacity":"1"},600);
	                    $('.sh_txt_box .scroll').delay(1000).animate({"opacity":"1"},600);
	                });
	                var swiper = new Swiper(".sh_main_swiper", {
	                    effect: "fade",
	                    loop: true,
	                    speed: 1000,
	                    autoplay: {
	                      delay: 3500,
	                      disableOnInteraction: false,
	                    },
	                    pagination: {
	                      el: ".swiper-pager",
	                      bulletActiveClass: 'on',
	                      clickable: true,
	                    },
	                });
	                </script>
	            </div>
	            <!-- sh_main_banner [e] -->
	            
	            <!-- sh_section [s] -->
	            <div id="sh_section">
	                <!-- atc02 [s] -->
	                <c:set value="${pagingVO.dataList }" var="employmentList" />
	                <div id="atc02">
	                	<div>
	                		<span class="fs-2 text-black">채용 공고</span>
	                	</div>
	                    <ul style="margin-left: 30px;">
	                    	<c:forEach items="${employmentList }" var="employment">
	                        <li class="anc border rounded m-2" style="width:270px; height:270px;">
		                        <a href="/employment/detail?empmnPbancNo=${employment.empmnPbancNo }">
		                            <div>
		                            	<img src="${employment.logoImg }" alt="채용공고.jpg" id="empAnc" class=" br-top img-fluid card-img-top border-bottom" style="width:100%;"><br>
		                            		<p class="text-black mx-3 fs-7 mt-2">${employment.empmnPbancWrtrNm }</p>
		                            		<p class="text-black mx-3 mx-4 fs-6">${employment.empmnPbancTtl }</p>
		                            </div>
		                        </a>
	                        </li>
	                        </c:forEach>
	                    </ul>
	                </div>
	                <!-- atc02 [e] -->
	                
	                <div id="atc03">
	                  <div class="index01">
	                    <a class="tit" href="/notice/list.do">공지사항<span></span></a>
	                    <c:set value="${twoNoticeList }" var="twoNoticeList" />
	                    <ul class="sh_lt2">
	                    	<c:forEach items="${twoNoticeList }" var="twoNoticeList">
	                        <li>
	                            <a href="/notice/list.do">
	                                <div class="sh_date">
	                                    <span class="day">${fn:substring(twoNoticeList.ntWrtDt, 8, 10)}</span><br/>
	                                    <span class="day_02">${fn:substring(twoNoticeList.ntWrtDt, 0, 4)}. ${fn:substring(twoNoticeList.ntWrtDt, 5, 7)}</span>
	                                </div>    
	                                <div class="txt_wrap">
	                                    <span class="sh_notice">${twoNoticeList.ntPstTtl }</span><br/>
	                                    <span class="sh_contents">${twoNoticeList.ntPstCn }</span>
	                                </div>
	                            </a>
	                        </li>
	                        </c:forEach>
	                    </ul>
	                  </div>
	                  <div class="index02">
	                    <a class="tit" href="/faq/list">FAQ<span></span></a>
	                    <c:set value="${twoFaqList }" var="twoFaqList" />
	                    <ul class="sh_lt2">
	                    	<c:forEach items="${twoFaqList }" var="twoFaqList">
	                        <li>
	                            <a href="/faq/list">
	                                <div class="sh_date">
	                                    <span class="day">${fn:substring(twoFaqList.faqWrtDt, 8, 10)}</span><br/>
	                                    <span class="day_02">${fn:substring(twoFaqList.faqWrtDt, 0, 4)}. ${fn:substring(twoFaqList.faqWrtDt, 5, 7)}</span>
	                                </div>    
	                                <div class="txt_wrap">
	                                    <span class="sh_notice">${twoFaqList.faqPstTtl }</span><br/>
	                                    <span class="sh_contents">${twoFaqList.faqPstCn }</span>
	                                </div>
	                            </a>
	                        </li>
	                        </c:forEach>
	                    </ul>
	                  </div> 
	                </div>
	                <!-- atc03 [e] -->
	                
	            </div>
	            <!-- sh_section [e] -->
	        </div>
	        <!-- sh_container_wrapper [e] -->
	    </div>
	    <!-- sh_container [e] -->
	    