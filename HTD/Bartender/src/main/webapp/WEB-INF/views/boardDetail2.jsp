<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>
	$(document).ready(function(){
		loginCheck();
		setContent();
		loadReply();
		$('#loginBtn').click(function() {
			login();
		});

		window.onkeyup = function(e) {
			var key = e.keyCode ? e.keyCode : e.which;

			if (key == 27) {
				newForm();
				$(".modal").fadeOut(300);
			}
		}
		
		$('#signUpSubmit').click(function() {

			signUp();
		});
	});
	
	function signUp(){
		params={
				email : $('#emailSU').val()
				, user_nick : $('#nickSU').val()
				, user_id : $('#idSU').val()
				, user_pw : $('#pwSU').val()
			}
			
			if(params.email != "" && params.user_nick != "" && params.user_id != "" && params.user_pw != ""){
				if(params.user_pw.length >= 4){
					$.ajax({
						type:"GET",
						url:"signUp",
						data: params,
						success:function(res){
							if(res){
								closeModal();
								alert("회원가입 성공");
							} else {
								alert("이미 가입된 회원이거나 존재하는 아이디 입니다.");
							}
						},
						error:function(){
							alert("통신 실패");
						}
					});
				} else {
					alert("비밀번호는 4자 이상 입력해주십시오.");
				}
			} else {
				alert("비어있는 부분을 채워주십시오");
			}
	}

	function enterkey2() {
		if (window.event.keyCode == 13) {
		    signUp();
		}
	}
	
	function login() {
		params = {
			user_id : $('#IDSI').val(),
			user_pw : $('#PWSI').val()
		}

		if (params.user_id != "" && params.user_pw != "") {
			$
					.ajax({
						type : "GET",
						url : "signIn",
						data : params,
						success : function(res) {
							if (res.user_nick != null) {
								closeModal();
								$('#signBtns').empty();
								$('#signBtns')
										.append(
												'<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
														+ res.user_nick
														+ '  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li onclick= "modifyInfo()"><a class="dropdown-item">회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
								alert('로그인 되었습니다.');	
								location.href="board";
							} else {
								alert('아이디, 비밀번호를 다시 확인해주세요.');
							}
						},
						error : function() {
							closeModal();
							$("#error").fadeIn();
							setTimeout(function() {
								$("#error").fadeOut(400)
							}, 1000);
						}
					});
		} else {
			alert("비어있는 부분을 채워주십시오");
		}
	}
	
	function userCheck(user_id2){
		var user_id1 = "${user.user_id}";
		
		if(user_id1 == user_id2){
			return 1;
		} else {
			return 0;
		}
	}
	
	function modifyInfo(){
		location.href="modifyInfo"	
	}
	
	function logout() {
		$.ajax({
			type : "GET",
			url : "logout",
			success : function(res) {
				closeModal();
				setTimeout(function() {
					$("#sc2").fadeOut(400)
				}, 1000);
				alert('로그아웃 되었습니다.');
				location.href = "index";
			},
			error : function() {
				$("#fc2").fadeIn();
				setTimeout(function() {
					$("#fc2").fadeOut(400)
				}, 1000);
			}
		});
	}
	
	function closeModal() {
		$(".modal").fadeOut(300);
		$('#emailSU').val('');
		$('#nickSU').val('');
		$('#idSU').val('');
		$('#pwSU').val('');
		$('#idSI').val('');
		$('#pwSI').val('');
	}
	
	function loginCheck() {

		var user = "${user}";
		if (user != "") {
			$('#signBtns').empty();
			$('#signBtns')
					.append(
							'<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
									+ "${user.user_nick}"
									+ '  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a class="dropdown-item" >회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item" >로그아웃</a></li></ul></div>');
		}
	}

	function enterkey() {
		if (window.event.keyCode == 13) {
			// 엔터키가 눌렸을 때 실행할 내용
			login();
		}
	}

	function newForm() {
		$('#emailSU').val('');
		$('#nickSU').val('');
		$('#idSU').val('');
		$('#pwSU').val('');
		$('#idSI').val('');
		$('#pwSI').val('');
	}

	function openLogin() {
		$("#myModal").fadeIn();
	}

	function openSignUp() {
		$("#myModal2").fadeIn();
	}
		
	window.onkeyup = function(e) {
		var key = e.keyCode ? e.keyCode : e.which;

		if(key == 27) {
			$(".modal").fadeOut(300);
		}
	}
	
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
		return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}	
	
	function setContent(){
		var no = getParameterByName('no');
		var title = getParameterByName('title');
		var content = getParameterByName('content');
		var view = getParameterByName('view');
		var user_id = getParameterByName('user_id');
		var date = getParameterByName('date');
		var time = getParameterByName('time');
		var attach_id_s = getParameterByName('attach_id');
		
		var uc = userCheck(user_id);
		
		param = {
			attach_id: attach_id_s
		}
		
		$.ajax({
			type : "GET",
			data : param,
			url : "loadAttach",
			async: "true",
			success : function(res) {
				for(var i = 0; i < res.length; i++){
					$('#attaches').append('<div name=""><form action="download" method="GET"><input name="name" value="'+res[i].name+'" style="display:none"><input name="attach_id" value='+res[i].attach_id+' style="display:none">'+res[i].name+'<input style="margin-left:10px" type="submit" value="다운로드"></form><div>');	
				}
				
				if(uc != 0){
					$('#buttons2').append('<div class="form-group" style="text-align: right"><input type="submit" value="수정하기" onclick="modifyBoard(\''+no+'\',\''+attach_id_s+'\')" class="btn btn-primary" style="margin-top: 10px; background-color: black; margin-right:10px"><button onclick="deleteBoard(\''+no+'\',\''+attach_id_s+'\')" class="btn btn-primary"style="margin-top: 10px; background-color: red">삭제하기<i class="fa fa-check spaceLeft"></i></button></div>');
				}
			},
			error : function() {
				alert('첨부파일을 읽어오는데 실패하였습니다.');
			}
		});
		
		content = content.replaceAll("9br9", '<br>');
		
		$('#title').text(title);
		$('#content').html(content);
		$('#view').text(view);
		$('#user_id').text(user_id);
		$('#date').text(date+" "+time);
	}
	
	function modifyBoard(no, attach_id){
		location.href = "modifyBoard2?no="+no+"&attach_id="+attach_id;
	}
	
	function checkMP(){
		if('${user.user_no}'!=0){
			location.href="myPage"
		} else {
			alert('로그인 후 이용가능합니다.');
			openLogin();
		}
	}
	
	function deleteBoard(no, attach_id){
		
		param={
			no : no,
			attach_id : attach_id
		}
		
		$.ajax({
			type : "GET",
			url : "deleteBoard",
			data : param,
			success : function(res) {
				if(res==1){
					alert('삭제하였습니다.');
					location.href="myPage";
				} else {
					alert('삭제에 실패하였습니다.');
				}
			},
			error : function() {
				
			}
		});
	}
	
	function loginCheck() {

		var user = "${user}";
		if (user != "") {
			$('#signBtns').empty();
			$('#signBtns')
					.append(
							'<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
									+ "${user.user_nick}"
									+ ' 님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a onclick ="modifyInfo()" class="dropdown-item">회원정보 수정</a></li><li><a  onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
		}
	}
	
	var stat = "hide";
	
	function appendNreply(reply_no){
	    if (stat == "hide") {
	      $("#nreply"+reply_no).show();
	      stat = "show";
	    } else {
	      $("#nreply"+reply_no).hide();
	      stat = "hide";
	    }
	}
	
	function loadReply(){
		var no = getParameterByName('no');
		
		param = {
			no : no
		}
		
		$.ajax({
			type : "GET",
			url : "loadReply",
			data : param,
			async : true,
			success : function(res) {
				for(var i = 0; i < res.length; i++){
					if(res[i].user_no == "${user.user_no}"){
						if(res[i].nreply_no == 0){
							$('#reply').append('<div id="'+res[i].reply_no+'" style="margin-bottom:40px;"><div>ID : '+res[i].user_id+' 님&nbsp&nbsp작성시간: '+res[i].time+'<button class="btn btn-primary" style="background-color:red; margin-left:50px;" onclick="deleteReply(\''+res[i].reply_no+'\')">삭제하기</button></div><hr><div id="reply_content">'+res[i].content+'</div><input id="showNreply" type="button" onclick="appendNreply(\''+res[i].reply_no+'\')" class="btn btn-secondary" value="답글" style="margin-top:20px;"><div id="nreply'+res[i].reply_no+'" style="display:none; width:90%"><div id="writeReply" style="background-color:black; color:white; margin-top:5px; height:150px; padding:10px;"><div id="reply_user_id" style="margin-bottom:5px;">ID : ${user.user_id} 님</div><textarea type="text" id="replyContent'+res[i].reply_no+'" style="width:100%; height:50px;"></textarea><div type="button" onclick="saveReply(\''+res[i].reply_no+'\')" class="btn btn-secondary" style="float:right; margin-top:10px;">댓글저장</div></div></div></div>');
						} else {
							$('#'+res[i].nreply_no).append('<div style="margin-left:20px; margin-top:10px; width:90%;"><div id="'+res[i].reply_no+'" style="margin-bottom:5px;">ID : '+res[i].user_id+' 님&nbsp&nbsp작성시간: '+res[i].time+'<button class="btn btn-primary" style="background-color:red; margin-left:50px;" onclick="deleteReply(\''+res[i].reply_no+'\')">삭제하기</button></div><hr><div id="reply_content">'+res[i].content+'</div></div>');
						}
					} else {
						if(res[i].nreply_no == 0){
							$('#reply').append('<div id="'+res[i].reply_no+'" style="margin-bottom:40px;"><div>ID : '+res[i].user_id+' 님&nbsp&nbsp작성시간: '+res[i].time+'</div><hr><div id="reply_content">'+res[i].content+'</div><input id="showNreply" type="button" onclick="appendNreply(\''+res[i].reply_no+'\')" class="btn btn-secondary" value="답글" style="margin-top:20px;"><div id="nreply'+res[i].reply_no+'" style="display:none; width:90%"><div id="writeReply" style="background-color:black; color:white; margin-top:5px; height:150px; padding:10px;"><div id="reply_user_id" style="margin-bottom:5px;">ID : ${user.user_id} 님</div><textarea type="text" id="replyContent'+res[i].reply_no+'" style="width:100%; height:50px;"></textarea><div type="button" onclick="saveReply(\''+res[i].reply_no+'\')" class="btn btn-secondary" style="float:right; margin-top:10px;">댓글저장</div></div></div></div>');
						} else {
							$('#'+res[i].nreply_no).append('<div style="margin-left:20px; margin-top:10px; width:90%;"><div id="'+res[i].reply_no+'" style="margin-bottom:5px;">ID : '+res[i].user_id+' 님&nbsp&nbsp작성시간: '+res[i].time+'</div><hr><div id="reply_content">'+res[i].content+'</div></div>');
						}
					}
				}
			},
			error : function() {
				alert('댓글을 읽어오는데에 실패하였습니다.');
			}
		});
	}
	
	function saveReply(nreply_no){
		var user = "${user}";
		if (user == "") {
			alert('댓글을 작성하려면 로그인해야 합니다.');
			openLogin();
			return;
		}
		var no = getParameterByName('no');
		
		var user_id = "${user.user_id}";
		
		var user_no = "${user.user_no}";
		
		var param={}
		
		if(nreply_no == 0){
			
			var content=$('#replyContent0').val();
			
			param = {
				no : no,
				user_id : user_id,
				user_no : user_no,
				content : content
			}
			
			
		} else {
			
			var content=$('#replyContent'+nreply_no).val();
			
			param = {
				no : no,
				user_id : user_id,
				user_no : user_no,
				content : content,
				nreply_no : nreply_no
			}
		}
			
		$.ajax({
			type : "GET",
			url : "saveReply",
			data : param,
			success : function(res) {
				alert('저장되었습니다!');
				location.reload();
			},
			error : function() {
				alert('댓글을 읽어오는데에 실패하였습니다.');
			}
		});
	}
	
	function deleteReply(reply_no){
		var no = getParameterByName('no');
		param = {
			reply_no : reply_no,
			no : no
		}
		$.ajax({
			type : "GET",
			url : "deleteReply",
			data : param,
			success : function(res) {
				alert('댓글을 삭제하였습니다.');
				location.reload();
			},
			error : function() {
				alert('댓글을 삭제하는데에 실패하였습니다.');
			}
		});
	}
</script>

<style>
	.card {
	    margin-bottom: 20px;
	    border: none
	}
	
	#attach:hover{
		text-decoration:underline;
	}
	
	.box {
	    width: 500px;
		padding: 40px;
		position: absolute;
		top: 50%;
		left: 35%;
		background: #191919;
		text-align: center;
		transition: 0.25s;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	
	.box input[type="text"],
	.box input[type="password"] {
	    border: 0;
	    background: none;
	    display: block;
	    margin: 20px auto;
	    text-align: center;
	    border: 2px solid black;
	    padding: 10px 10px;
	    width: 250px;
	    outline: none;
	    color: white;
	    border-radius: 24px;
	    transition: 0.25s
	}
	
	.box h1 {
	    color: white;
	    text-transform: uppercase;
	    font-weight: 500
	}
	
	.box input[type="text"]:focus,
	.box input[type="password"]:focus {
	    width: 300px;
	    border-color: #f8f9fa
	}
	
	.box input[type="submit"] {
	    border: 0;
	    background: none;
	    display: block;
	    margin: 20px auto;
	    text-align: center;
	    border: 2px solid black;
	    padding: 14px 40px;
	    outline: none;
	    color: white;
	    border-radius: 24px;
	    transition: 0.25s;
	    cursor: pointer
	}
	
	.box input[type="submit"]:hover {
	   border-color: #f8f9fa
	}
	
	.forgot {
	    text-decoration: underline
	}
	
	ul.social-network {
	    list-style: none;
	    display: inline;
	    margin-left: 0 !important;
	    padding: 0
	}
	
	ul.social-network li {
	    display: inline;
	    margin: 0 5px
	}
	
	.social-network a.icoFacebook:hover {
	    background-color: #3B5998
	}
	
	.social-network a.icoTwitter:hover {
	    background-color: #33ccff
	}
	
	.social-network a.icoGoogle:hover {
	    background-color: #BD3518
	}
	
	.social-network a.icoFacebook:hover i,
	.social-network a.icoTwitter:hover i,
	.social-network a.icoGoogle:hover i {
	    color: #fff
	}
	
	a.socialIcon:hover,
	.socialHoverClass {
	    color: #44BCDD
	}
	
	.social-circle li a {
	    display: inline-block;
	    position: relative;
	    margin: 0 auto 0 auto;
	    border-radius: 50%;
	    text-align: center;
	    width: 50px;
	    height: 50px;
	    font-size: 20px
	}
	
	.social-circle li i {
	    margin: 0;
	    line-height: 50px;
	    text-align: center
	}
	
	.social-circle li a:hover i,
	.triggeredHover {
	    transform: rotate(360deg);
	    transition: all 0.2s
	}
	
	.social-circle i {
	    color: #fff;
	    transition: all 0.8s;
	    transition: all 0.8s
	}
	
	.pagination > a {
		text-decoration:none;
	}
    
    #page {
    	color:black;
    }
    
    .navbar {
	background-color:black;
	color:white;
	}

	body {
		background-image: url('/resources/assets/bg2.jpg');
	}
	
	#signBtns > button {
		color:white;
	}
	
	#signBtns > button:hover {
		color:darkgray;
	}
	
	.nav-item > a:hover{
		color:darkgray;
	}
	
	.container > .navbar-brand:hover{
		color:white;
	}
	
	.navbar {
	background-color:black;
	color:white;
	}
	
	.pagination>a {
		text-decoration: none;
	}
	
	#page {
		color: black;
	}
	
	body {
		background-image: url('/resources/assets/bg2.jpg');
	}
	
	#signBtns > button {
		color:white;
	}
	
	#signBtns > button:hover {
		color:darkgray;
	}
	
	.nav-item > a:hover{
		color:darkgray;
	}
	
	.container > .navbar-brand:hover{
		color:white;
	}
	
	a:link { color: white; text-decoration: none;}
	a:visited { color: white; text-decoration: none;}
</style>

<html>
    <head>
    	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <meta charset="euc-kr" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Bartender</title>
        <!-- Favicon-->
        <link rel="icon" type="/resources/image/x-icon" href="/resources/assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/resources/css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="index"style ="font-family: 'Permanent Marker', cursive;">Hometender</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" href='index'>홈</a></li>
					<li class="nav-item"><a class="nav-link" href='about'>소개</a></li>
					<li class="nav-item"><a class="nav-link" href='ca'>칵테일</a></li>
					<li class="nav-item"><a class="nav-link" href='board'>게시판</a></li>
					<li class="nav-item"><a class="nav-link" href='#' onclick="checkMP()">마이페이지</a></li>
				</ul>
				<div id="signBtns">
					<button class="btn" onclick="openLogin()"
						id="login" style="margin-right: 10px; border:none">로그인</button>
					<button class="btn" onclick="openSignUp()"
						id="signUp" style="border:none">회원가입</button>
				</div>
			</div>
		</div>
	</nav>
        <!-- Header-->
        <!-- Section-->
       <section class="container" style="margin-top:5%;margin-bottom:5%;width:80%;">
			<table class="table" style="color:white">
		        <colgroup>
		            <col width="15%">
		            <col width="35%">
		            <col width="15%">
		            <col width="*">
		        </colgroup>
		         
		        <tbody style="background-color:black;">
		            <tr>
		                <th>제목</th>
		                <td id="title"></td>
		                <th>조회수</th>
		                <td id="view"></td>
		            </tr>
		            <tr>
		                <th>작성자</th>
		                <td id="user_id"></td>
		                <th>작성시간</th>
		                <td id="date"></td>             
		            </tr>
		            <tr>
		                <th>첨부파일</th>
		                <td id="attaches"></td>
		            </tr>
		        </tbody>
		    </table>     
    	<div id="content" class="card" style="padding: 20px 20px 20px 20px"></div> 
    	<div id="buttons2"></div>
    	<div id="replies" style="color:white;">
    	 	댓글
    	 	<hr>
    	 	<div id="reply" style="background-color:black; color:white; margin-top:10px; padding:10px;">
    	 	</div>
    	</div>
    	<div id="writeReply" style="background-color:black; color:white; margin-top:30px; height:150px; padding:10px;">
    		<div id="reply_user_id" style="margin-bottom:5px;">ID : ${user.user_id} 님</div>
    		<textarea type="text" id="replyContent0" style="width:100%; height:50px;"></textarea>
    		<div type="button" onclick="saveReply(0)" class="btn btn-secondary" style="float:right; margin-top:10px;">댓글저장</div>
    	</div>
        </section>
        
        <!-- Footer-->
        <footer class="py-5">
            <div class="container"><p class="m-0 text-center text-white">개발자 연락처<br>E-mail : thdwjdgus079@naver.com<br>PN : 010-6368-0793</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/resources/js/scripts.js"></script>
    </body>
</html>

<div class="modal" id="error">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class=box style="color: white">
					<b style="color: red">에러 발생</b><br> <br> 에러가 발생하였습니다.
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="myModal" onkeyup="enterkey()">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class="box">
					<button id="closeBtn" onclick="closeModal()"
						class="btn btn-outline-dark"
						style="color: white; margin-left: 90%; border: 0">x</button>
					<h1>로그인</h1>
					<p class="text-muted">아이디와 비밀번호를 입력해주세요!</p>
					<input type="text" id="IDSI" name="" placeholder="아이디">
					<input type="password" id="PWSI" name="" placeholder="비밀번호">
					<input type="submit" id="loginBtn" name="" value="로그인">
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="myModal2" onkeyup="enterkey2()">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class="box">
					<button id="closeBtn2" onclick="closeModal()"
						class="btn btn-outline-dark"
						style="color: white; margin-left: 90%; border: 0">x</button>
					<h1>회원가입</h1>
					<p class="text-muted">아래 정보를 기입해주세요</p>
					<input type="text" name="" placeholder="이메일" id="emailSU">
					<input type="text" name="" placeholder="이름" id="nickSU">
					<input type="text" name="" placeholder="아이디" id="idSU">
					<input type="password" name="" placeholder="비밀번호" id="pwSU">
					<input type="submit" id="signUpSubmit" name="" value="회원가입 신청">
				</div>
			</div>
		</div>
	</div>
</div>
