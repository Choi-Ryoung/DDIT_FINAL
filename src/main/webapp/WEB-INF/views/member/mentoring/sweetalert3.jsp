<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<input type="hidden" name="menNcnm" id="menNcnm" value="${mento.menNcnm }">
<input type="hidden" name="rjctRsn" id="rjctRsn" value="${mento.rjctRsn }">
<script>


$(function(){
	var menNcnm = $("#menNcnm").val();
	console.log("menNcnm : " + menNcnm);
	var rjctRsn = $("#rjctRsn").val();
	console.log("rjctRsn : " + rjctRsn);

	Swal.fire({
		  title: menNcnm + "님은 현재 반려 상태입니다.",
		  text: rjctRsn,
		  icon: "error",
		  showConfirmButton: false,
		  footer: "<a href='/mento/list' class='btn btn-outline-primary'>목록으로</a>"
		});
	
})

</script>