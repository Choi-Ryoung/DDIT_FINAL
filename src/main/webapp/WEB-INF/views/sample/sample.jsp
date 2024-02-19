<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!-- sh_wrapper [s] -->
<div id="sh_wrapper" class="sub">
    <!-- sh_container [s] -->
    <div id="sh_container"> 
        <!-- sh_container_wrapper [s] -->
        <div id="sh_container_wrapper">
            <!-- sh_sub_banner [s] -->
            <div id="sh_sub_banner">
                <div id="sh_content_tit">
                    <h3>Sample</h3>
                    <p><a href="/"><i class="fa fa-home"></i><span class="sound_only">홈으로</span></a> 
                    <i class="fa fa-angle-right"></i> 기업정보 <i class="fa fa-angle-right"></i> 면접후기</p>
                </div>
            </div>
            <div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
					<div>
						<div class="bd-example">
					        <nav>
					          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
					            <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">기업리뷰</button>
					            <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">면접후기</button>
					          </div>
					        </nav>
					     </div>
					</div>
					
					<div class="mb-3">
					  <label for="exampleFormControlInput1" class="form-label">Email address</label>
					  <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">
					</div>
					
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">Example textarea</label>
					  <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
					</div>					
					
					
					 
				</div>               
					
			</div>
            <!-- sh_content [s] -->            
        </div>
        <!-- sh_container_wrapper [e] -->
    </div>
    <!-- sh_container [e] -->
</div>
    

<script type="text/javascript">
$(function(){
	// 페이징을 처리할때 사용할 Element
	// pagingArea div안에 ul과 li로 구성된 페이징 정보가 존재
	// 그안에는 a태그로 구성된 페이지정보가 들어있음
	// a태그 안에 들어있는 page번호를 가져와서 페이징 처리를 진행
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	var newBtn = $("#newBtn");		// 등록 버튼
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a태그의 이벤트를 block
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
});
</script>



