<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>

$(document).ready(function(){
	
	loginCheck();
	
	window.onkeyup = function(e) {
		var key = e.keyCode ? e.keyCode : e.which;

		if(key == 27) {
			newForm();
			$(".modal").fadeOut(300);
		}
	}
	
	$('#loginBtn').click(function(){
		login();
	});
	
	$('#signUpSubmit').click(function(){
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

function modifyInfo(){
	location.href="modifyInfo"	
}

function openLogin(){
	$("#myModal").fadeIn();
}

function checkMP(){
	if('${user.user_no}'!=0){
		location.href="myPage"
	} else {
		alert('로그인 후 이용가능합니다.');
		openLogin();
	}
}

function closeModal(){
	newForm();
	$(".modal").fadeOut(300);
}

function newForm(){
	$('#emailSU').val('');
	$('#nickSU').val('');
	$('#idSU').val('');
	$('#pwSU').val('');
	$('#idSI').val('');
	$('#pwSI').val('');
}

function openSignUp(){
	$("#myModal2").fadeIn();
}

function login(){
	params={
		user_id : $('#IDSI').val()
		, user_pw : $('#PWSI').val()
	}
	
	if(params.user_id != "" && params.user_pw != ""){
		$.ajax({
			type:"GET",
			url:"signIn",
			data: params,
			success:function(res){
				if(res.user_nick != null){
					closeModal();
					$('#signBtns').empty();
					$('#signBtns').append('<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
							+"${user.user_nick}"+'  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a class="dropdown-item" href="modifyInfo">회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
					alert('로그인 되었습니다.');
					location.href = "about";
				} else {
					closeModal();
					$("#fc").fadeIn();
					setTimeout(function(){$("#fc").fadeOut(400)},1000);
				}
			},
			error:function(){
				closeModal();
				$("#error").fadeIn();
				setTimeout(function(){$("#error").fadeOut(400)},1000);
			}
		});
	} else {
		alert("비어있는 부분을 채워주십시오");
	}
}

function enterkey() {
	if (window.event.keyCode == 13) {
	     login();
	}
}

function loginCheck(){
	
	if("${user}" != ""){
		$('#signBtns').empty();
		$('#signBtns').append('<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
				+"${user.user_nick}"+'  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a class="dropdown-item" href="modifyInfo" style="color:black;">회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
	}
}

function logout(){
	$.ajax({
		type:"GET",
		url:"logout",
		success:function(res){
			closeModal();
			$('#signBtns').empty();
			alert('로그아웃 되었습니다.');
			location.href="about";
		},
		error:function(){
			$("#fc2").fadeIn();
			setTimeout(function(){$("#fc2").fadeOut(400)},1000);
		}
	});
}
</script>

<style>

@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap');

.card {
	margin-bottom: 20px;
	border: none;
	font-family: 'Noto Serif KR', serif;
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

.box input[type="text"], .box input[type="password"] {
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

.box input[type="text"]:focus, .box input[type="password"]:focus {
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

.social-network a.icoFacebook:hover i, .social-network a.icoTwitter:hover i,
	.social-network a.icoGoogle:hover i {
	color: #fff
}

a.socialIcon:hover, .socialHoverClass {
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

.social-circle li a:hover i, .triggeredHover {
	transform: rotate(360deg);
	transition: all 0.2s
}

.social-circle i {
	color: #fff;
	transition: all 0.8s;
	transition: all 0.8s
}

a:link { color: white; text-decoration: none;}
a:visited { color: white; text-decoration: none;}

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
</style>

<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="euc-kr" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Hometender</title>
<!-- Favicon-->
<link rel="icon" type="/resources/image/x-icon"
	href="/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="index" style ="font-family: 'Permanent Marker', cursive;">Hometender</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" href='index'>홈</a></li>
					<li class="nav-item"><a class="nav-link"href='about'><b>소개</b></a></li>
					<li class="nav-item"><a class="nav-link" href='ca'>칵테일</a></li>
					<li class="nav-item"><a class="nav-link" href='board'>게시판</a></li>
					<li class="nav-item"><a class="nav-link" href='#' onclick="checkMP()">마이페이지</a></li>
				</ul>
				<div id="signBtns">
					<button class="btn" onclick="openLogin()"
						id="login" style="margin-right: 10px">로그인</button>
					<button class="btn" onclick="openSignUp()"
						id="signUp">회원가입</button>
				</div>
			</div>
		</div>
	</nav>
	<!-- Header-->
	<header class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder"style ="font-family: 'Permanent Marker', cursive;">About</h1>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="col md-12">
			<div class="card"
				style="width: 70%; margin: 0 auto; margin-top: -50px; background-color: black; color:white; height: 400px; padding:20px;">
				저희 Hometender 사이트 방문을 환영합니다.<br><br>
				
				요즘처럼 밖에 돌아다니기 위험하지만 술은 즐기고 싶을 때!<br>
				소주, 맥주 말고 다른 술을 접하고 싶을 때!<br>
				칵테일을 집에서 만들어보고 싶지만 종류도 많고, 무슨 재료가 필요한지 잘 모르겠을 때!<br>
				저희가 알려드리겠습니다!<br><br>
				
				이 사이트는 칵테일에 입문하시는 분들을 위해<br>
				본인이 가지고 있는 재료를 저장할 수 있는 '냉장고' 기능을 이용하여<br> 
				만들 수 있는 칵테일 레시피를 보여주는 것을 주 기능으로 하고 있습니다.<br>
				
				또, 게시판을 이용하여 자신만의 레시피를 다른 사람들에게 공유할 수도 있고,<br> 
				다른 사람들의 레시피를 통해 새로운 레시피의 발견과 발전 더 나아가 칵테일이라는 분야의 대중성을 목표로 하고있습니다.<br><br>
				 
				많은 이용 부탁드립니다.
			</div>
			<form class="btn" action="whence" method="GET" style="float:right; margin-right:220px;">
				<input type="submit" value="출처 다운로드">
			</form>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5">
		<div class="container">
			<p class="m-0 text-center text-white">개발자 연락처<br>E-mail : thdwjdgus079@naver.com<br>PN : 010-6368-0793</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/resources/js/scripts.js"></script>
</body>
</html>

<div class="modal" id="sc">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class=box style="color: white">로그인되었습니다.</div>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="fc">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class=box style="color: white">
					<b style="color: red">로그인 실패</b><br> <br> 아이디, 비밀번호를
					확인해주세요.
				</div>
			</div>
		</div>
	</div>
</div>

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
