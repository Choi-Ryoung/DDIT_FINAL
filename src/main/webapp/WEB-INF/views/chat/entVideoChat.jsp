<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script>
	
	<h1>Client2</h1>
	
	<video id="local_video" autoplay></video>
	<video id="remote_video" autoplay></video>
	<video id="video" autoplay></video>
	
	<script>
		/* const peer = new Peer('client2', {
			host: 'localhost',
			port: 8001,
			path: '/'
		});
		
		peer.on('connection', conn => {
		    console.log('다른 클라이언트가 접속했습니다.')
		    conn.on('data', data => {
		        console.log("클라이언트1에서 송신한 메시지 : ", data);
		        conn.send('안녕하세요! 클라이언트2입니다!');
		    });
		}); */
		// 여기부터
		const video = document.getElementById('video');
		const localVideo = document.getElementById('local_video');
		const RemoteVideo = document.getElementById('remote_video');

	    var peer = new Peer('client2', {
	      host: '192.168.36.105',
	      /* host: '192.168.36.105',  내꺼*/
	      /* host: '192.168.36.103',  낙훈형꺼*/
	      port: 8001,
	      path: '/'
	    });
	    
	    peer.on('connection', conn => {
		    console.log('다른 클라이언트가 접속했습니다.')
		});
	    
	    peer.on('call', function(call) {
	    	navigator.mediaDevices.getUserMedia({video : true, audio : true}).then(function (stream) {
				localVideo.srcObject = stream;
				call.answer(stream);
				
				call.on('stream', function(stream) {
					RemoteVideo.srcObject = stream;
				});
				
				
			}).catch(function (error) {
				console.log(error);
			});
		});
	    
	    var peer2 = new Peer('client3', {
		      host: '192.168.36.105',
		      port: 8001,
		      path: '/'
		    });
	    
	    peer2.on('connection', conn => {
		    console.log('다른 클라이언트가 접속했습니다.')
		});
	    
	    peer2.on('call', function(call) {
	    	navigator.mediaDevices.getUserMedia({video : true, audio : true}).then(function (stream) {
				call.answer(stream);
				
				call.on('stream', function(stream) {
					video.srcObject = stream;
				});
				
				
			}).catch(function (error) {
				console.log(error);
			});
		});
	</script>
