<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>
	$(document).ready(function(){
		
		loginCheck();
		setContent();

	});
	
	function cancel(){
		location.href = "myPage";
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
	
	function deleteAttach(name, attach_id){
		
		param ={
			name : name,
			attach_id : attach_id
		}
		
		if (confirm("첨부파일이 삭제됩니다. 진행할까요?")) {
	        $.ajax({
	        	type : "GET",
				data : param,
				url : "deleteAttach",
				async: "true",
				success : function(res) {
					if(res==1){
						alert('삭제하였습니다.');
						location.reload();
					} else {
						alert('첨부파일 삭제에 실패하였습니다.');						
					}
				},
				error : function() {
					alert('첨부파일을 삭제에 실패하였습니다.');
				}
	        });
	    } else {
			
	    }
	}
	
	function setContent(){
		var no = getParameterByName('no');
		var attach_id = getParameterByName('attach_id');
		
		param={
			no : no
		};

		$.ajax({
			type : "POST",
			data : param,
			url : "loadBoard",
			async: "true",
			success : function(res) {
				$('#title').val(res.title);
				var content = res.content.replaceAll("9br9", '\n');
				$('#content').val(content);
			},
			error : function() {
				alert('게시글을 읽어오는데 실패하였습니다.');
			}
		});
	
		param = {
			attach_id: attach_id
		}	
			
		$.ajax({
			type : "GET",
			data : param,
			url : "loadAttach",
			async: "true",
			success : function(res) {
				for(var i = 0; i < res.length; i++){
					$('#attaches').append('<div name=""><form action="download" method="GET"><input name="name" value="'+res[i].name+'" style="display:none"><input name="attach_id" value='+res[i].attach_id+' style="display:none">'+res[i].name+'<input style="margin-left:10px" type="submit" value="다운로드"><span type="button" onclick="deleteAttach(\''+res[i].name+'\', \''+res[i].attach_id+'\')" style="margin-left:10px;color:red">x</div></span><div>');
				}
				$('section').append('<div class="form-group" style="text-align: right"><input type="button" value="저장하기" onclick="modifySave()" class="btn btn-primary"style="margin-top: 10px; background-color: black; margin-right:10px"><button onclick="cancel()" class="btn btn-primary"style="margin-top: 10px; background-color: red">취소하기<i class="fa fa-check spaceLeft"></i></button></div>');
			},
			error : function() {
				alert('첨부파일을 읽어오는데 실패하였습니다.');
			}
		});
		
	}
	
	function modifySave(){
		var no = getParameterByName('no');
		var title = $('#title').val();
		var content = $('#content').val();
		
		param = {
			no : no,
			title : title,
			content : content
		}
		
		$.ajax({
			type : "GET",
			data : param,
			url : "modifySave",
			async: "true",
			success : function(res) {
				if(res==1){
					alert('게시물을 수정하였습니다.');	
					location.href="myPage";
				} else {
					alert('게시물 수정에 실패하였습니다.');
					location.href="myPage";
				}
			},
			error : function() {
				alert('게시물을 수정하는데에 실패하였습니다.');
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
	    margin-top: 100px
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
					<li class="nav-item"><a class="nav-link active" href='myPage'>마이페이지</a></li>
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
		            <col width="85%">
		        </colgroup>
		         
		        <tbody style="background-color:black;">
		            <tr>
		                <th>제목</th>
		                <td><input id="title" type="text"></td>
		            </tr>
		            <tr>
		                <th>첨부파일</th>
		                <td id="attaches"></td>
		            </tr>
		        </tbody>
		    </table>     
    	<div class="card" style="padding: 20px 20px 20px 20px"><textarea id="content" style="height:200px"></textarea></div>  
        </section>
        
        <!-- Footer-->
        <footer class="py-5">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2021</p></div>
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
