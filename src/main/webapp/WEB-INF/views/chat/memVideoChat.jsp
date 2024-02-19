<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script>
	<style>
		#options{
			visibility: hidden;
		}
		
		#remote_video{
			height: 800px;
    		position: absolute;
		}
		
		#local_video{
			z-index: 1;
		    position: absolute;
		    margin-top: 546px;
		    margin-left: 617px;
		    width: 450px;
		}
		.col-md-7{
		    margin-left: 90px;
		}
	</style>
	
<h2>면접</h2>
<hr>
<div class="row">
	<div class="col-md-7">
		<video id="local_video" autoplay></video>
		<video id="remote_video" autoplay></video>
	</div>
	<div class="col-md-4">
		<div class="col align-items-center text-center">
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col" colspan="5" class="fs-5">면접 유의사항</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>카메라와 마이크를 켜주세요.</td>
					</tr>
					<tr>
						<td>옷은 단정히 입어주세요.</td>
					</tr>
					<tr>
						<td>말을 할때는 목소리를 크게 내주세요.</td>
					</tr>
					<tr>
						<td>상대방의 목소리가 들리지 않는다면 손으로 X 표시를 해주세요.</td>
					</tr>
					<tr>
						<td>시선은 화면과 카메라에 고정.</td>
					</tr>
					<tr>
						<td>면접 종료는 창을 닫거나 상대방이 조작 할 수 있습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col align-items-center text-center">
			<hr>
			<textarea id="interviewEvalue" name="interviewEvalue" class="form-control" rows="2" placeholder="메모장이 필요하다면 여기를 이용하세요!"></textarea>
			<hr>
		</div>
	</div>
</div>

	<script>
		// 여기부터
		const localVideo = document.getElementById('local_video');
		const RemoteVideo = document.getElementById('remote_video');

	    var peer = new Peer('client1', {
	      host: '192.168.36.103',
	      /* host: '192.168.36.105', 내꺼 */
	      /* host: '192.168.36.103',  낙훈형꺼*/
	      port: 8001,
	      path: '/'
	    });
	    
	    const conn = peer.connect('client4');
	    
	    conn.on('open',()=>{
			console.log('client2에 접속했습니다.');
		});
		
	    navigator.mediaDevices.getUserMedia({video : true, audio : true}).then(function (stream) {
			localVideo.srcObject = stream;
			let call = peer.call('client4', stream);
			if (call != null) {
				call.on('stream', function(stream) {
					console.log("1234");
					console.log("stream : ", stream);
					RemoteVideo.srcObject = stream;
				});
			}
		}).catch(function (error) {
			console.log(error);
	    });
</script>