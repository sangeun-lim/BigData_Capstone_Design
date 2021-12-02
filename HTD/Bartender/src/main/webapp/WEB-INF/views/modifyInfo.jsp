<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	function cancel(){
		location.href="index"	
	}
	
	function modifyInfo(){
		
		var id = $('#user_id').text();
		var pw = $('#user_pw').val();
		
		param = {
			user_id : id,
			user_pw : pw,
			email : $('#email').val()
		}
		
		$.ajax({
			type:"GET",
			url:"modifyInformation",
			data: param,
			success:function(res){
				if(res==true) {
					alert('회원정보를 수정하였습니다.');
					alert('다시 로그인 해주세요!');
					logout();
					cancel();
				} else {
					alert('회원정보 수정에 실패하였습니다.');
				}
			},
			error:function(){
				$("#error").fadeIn();
				setTimeout(function(){$("#error").fadeOut(400)},1000);
			}
		});
	}
	
	function logout(){
		
		$.ajax({
			type:"GET",
			url:"logout",
			success:function(res){
				alert('로그아웃되었습니다.');
				location.href="index";
			},
			error:function(){
			}
		});
	}
</script>

<style>
.card {
	margin-bottom: 20px;
	border: none
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

header, footer {
	background-color: black;
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" href="index">Hometender</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" href='index'>홈</a></li>
					<li class="nav-item"><a class="nav-link active" href='about'>소개</a></li>
					<li class="nav-item"><a class="nav-link" href='ca'>칵테일</a></li>
					<li class="nav-item"><a class="nav-link" href='board'>게시판</a></li>
					<li class="nav-item"><a class="nav-link" href='myPage'>마이페이지</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Header-->
	<header class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">회원 정보 수정</h1>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="col md-12">
			<div class="card" style="width: 70%; margin: 0 auto; height: 500px; padding:20px;">
				<div class="form-group" style="margin-bottom:15px;">
					<label for="inputName">아이디</label>
					<br><div style="font-size:30px;" id="user_id">${user.user_id}</div>
				</div>
				<div class="form-group" style="margin-bottom:15px;">
					<label for="inputName">이름</label>
					<br><div style="font-size:30px;">${user.user_nick}</div>
				</div>
				<div class="form-group" style="margin-bottom:15px;">
					<label for="inputName">이메일 주소</label>
					<input type="text"
						class="form-control" id="email"
						value="${user.email}">
				</div>
				<div class="form-group" style="margin-bottom:15px;">
					<label for="inputPassword">변경할 비밀번호</label> <input type="password"
						class="form-control" id="user_pw"
						placeholder="비밀번호를 입력해주세요">
				</div>
				<div class="form-group text-center">
					<button id="join-submit" onclick="modifyInfo()" class="btn btn-primary" style="margin-top:10px;background-color:black">
						수정하기<i class="fa fa-check spaceLeft"></i>
					</button>
					<button id="join-submit" onclick="cancel()" class="btn btn-primary" style="margin-top:10px;background-color:red">
						취소하기<i class="fa fa-check spaceLeft"></i>
					</button>
				</div>
			</div>
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
