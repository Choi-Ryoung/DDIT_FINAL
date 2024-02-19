<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<input type="hidden" name="menNcnm" id="menNcnm" value="${mento.menNcnm }">
<script>


$(function(){
	var menNcnm = $("#menNcnm").val();
	console.log("menNcnm : " + menNcnm);

	Swal.fire({
		  title: menNcnm + "님은 현재 승인 대기중입니다.",
		  text: "승인이 완료된 후 열람할 수 있습니다.",
		  icon: "error",
		  showConfirmButton: false,
		  footer: "<a href='/mento/list' class='btn btn-outline-primary'>목록으로</a>"
		});
	
})

</script>