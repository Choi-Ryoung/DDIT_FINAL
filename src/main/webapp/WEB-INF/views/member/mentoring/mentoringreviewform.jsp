<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
body{
margin-top:20px;
 --bs-font-sans-serif:margin:0; padding:0;font-size:17px;line-height:1.6;font-family:'Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400;
}

</style>

<body>
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
            <div id="sh_content">
                <!-- 서브페이지 [s] -->
                <div id="greeting" class="pagecommon">
					  	
							<div class="card-body">
								<form action="/mento/reviewinsert" method="post" id="mentoringReviewForm">
								<input type="hidden" name="menNcnm" value="${mentoInfo.menNcnm }"/>
								<div class="row">
								        <label for="eduCn" class="form-label">교육내용</label>
										<div class="mb-3">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <input type="text" id ="eduCn" name="eduCn" class="form-control" placeholder="ex) 포트폴리오 작성, 이력서 작성">
										</div>
								</div><hr>
								
								<div class="row">
								        <label for="menPstCn" class="form-label">내용작성</label>
										<div class="col-auto">
										    <label for="inputPassword2" class="visually-hidden"></label>
										    <textarea rows="3" cols="150" id="menrvPstCn" name="menrvPstCn" style="white-space: pre;" placeholder="내용을 입력해주세요"></textarea>
										</div>
								</div><hr>
								
								<div class="row">
									<div class="col-6">
									    <div class="input-group mb-3">
									        <div class="form-group clearfix">
									            <div class="icheck-primary d-inline">
									                 <button type="button" id="reviewInsertBtn" class="btn btn-secondary btn-inline">등록하기</button>
									            </div>
									            <div class="icheck-primary d-inline">
									               <button type="submit" class="btn btn-secondary btn-inline" onclick="javascript:history.back()">뒤로가기</button>
									            </div>
									        </div>
									    </div>
									</div>				
								</div>
								
							</form>
						</div>	
					</div>    
                </div>
           	</div>
         </div>
</body>
<script type="text/javascript">

var mentoringReviewForm = $("#mentoringReviewForm");
var reviewInsertBtn = $("#reviewInsertBtn");

$(function(){
	
	reviewInsertBtn.on("click", function(){
		var eduCn = $("#eduCn").val();
		var menrvPstCn = $("#menrvPstCn").val();
		
		var data = {
			eduCn : eduCn,
			menrvPstCn : menrvPstCn
		}
		
		$.ajax({
			url : "/mento/reviewinsert",
			type : "POST",
			data : JSON.stringify(data),
			contentType:'application/json;charset=UTF-8',
			success : function(res) {
				console.log("넘겨받은 자료 : ", res);
				if(res === 1) {
					alert("등록 되었습니다!");
					location.href = "/mento/reviewlist";
				} else {
					alert("실패");
					location.href = "/mento/reviewlist";
				}
			}
			
			
		})
		
	});
	
});

function mentoFind() {
	location.href="/mento/find?menNcnm=${menNcnm}";
}

function mentoReview() {
	location.href="/mento/reviewlist";
}
</script>