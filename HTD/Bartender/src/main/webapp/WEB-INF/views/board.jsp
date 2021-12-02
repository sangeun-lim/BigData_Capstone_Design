<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>
	
	$(document).ready(function() {
						
		if('${failMessage}'!=''){
			alert('${failMessage}');
		}
		checkMessage();
		loginCheck();

		loadBoardList();
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

		$('#signUpSubmit').click(function(){
			signUp();
		});
	});

	function checkMessage(){
		if('${msg}'!=''){
			alert('${msg}');
		}
	}
	
	function checkMP(){
		if('${user.user_no}'!=0){
			location.href="myPage"
		} else {
			alert('로그인 후 이용가능합니다.');
			openLogin();
		}
	}
	
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
	
	function enterkey3() {
		if (window.event.keyCode == 13) {
		    loadBoardList(1, 0);
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

	function goWrite(){
		
		var user_no_s = '${user.user_no}';
		
		if(user_no_s == ''){
			alert('게시글 작성을 위해 로그인 해주세요!');
			openLogin();
		}else{
			location.href = "writeBoard";	
		}
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

	function enterkey() {
		if (window.event.keyCode == 13) {
			// 엔터키가 눌렸을 때 실행할 내용
			login();
		}
	}
	
	function paging(ref) {
		if (ref == 0 && $('#page1').text() != 1) {
			$('#page1').text(parseInt($('#page1').text()) - 5);
			$('#page2').text(parseInt($('#page2').text()) - 5);
			$('#page3').text(parseInt($('#page3').text()) - 5);
			$('#page4').text(parseInt($('#page4').text()) - 5);
			$('#page5').text(parseInt($('#page5').text()) - 5);
		}

		if (ref == 1) {
			$('#page1').text(parseInt($('#page1').text()) + 5);
			$('#page2').text(parseInt($('#page2').text()) + 5);
			$('#page3').text(parseInt($('#page3').text()) + 5);
			$('#page4').text(parseInt($('#page4').text()) + 5);
			$('#page5').text(parseInt($('#page5').text()) + 5);
		}
		
		for(var i = 1; i <= 5; i++){
			$('#page'+i).css('font-weight', '');
		}
	}

	function loginCheck() {

		var user = "${user}";
		if (user != "") {
			$('#signBtns').empty();
			$('#signBtns')
					.append(
							'<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
									+ "${user.user_nick}"
									+ '  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a onclick="modifyInfo()" class="dropdown-item" >회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item" >로그아웃</a></li></ul></div>');
		}
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
	
	function modifyInfo(){
		location.href="modifyInfo"	
	}
	
	function loadBoard(BN){
		
		param={
			no : BN
		};

		$.ajax({
			type : "POST",
			data : param,
			url : "loadBoard",
			async: "true",
			success : function(res) {
				location.href="boardDetail?no="+param.no+"&title="+res.title+"&content="+res.content+"&view="+res.view+"&user_id="+res.user_id+"&date="+res.date+"&time="+res.time+"&attach_id="+res.attach_id;
			},
			error : function() {
				alert('게시글을 읽어오는데 실패하였습니다.');
			}
		});
	}
	
	function loadBoardList(page, num){
		
		if(num == null){
			if(page==null){
				var p = 1;
			} else {
				var p = $("#page"+page).text();
			}
			
			param={page : p};
			
			$.ajax({
				type : "GET",
				data : param,
				url : "loadBoardList",
				success : function(res) {
					$('#boardList').empty();
					
					for(var i = 0; i < res.length; i++){
						$('#boardList').append('<tr style="cursor:pointer" onclick="loadBoard('+res[i].no+')"><th>'+res[i].title+'</th><th>'+res[i].user_id+'</th><th>'+res[i].date+'</th><th>'+res[i].view+'</th></tr>');
					}
					
					if(page == null){
						$('#page1').css('font-weight', 'bold');
					} else {
						for(var i = 1; i <= 5; i++){
							if(i == page){
								$('#page'+i).css('font-weight', 'bold');
							} else {
								$('#page'+i).css('font-weight', '');
							}
						}
					}
				},
				error : function() {
					alert('게시판 리스트를 불러오는데 실패했습니다.');
				}
			});
		} else {
			if($('#searchWord').val() == null){
				$('.pagination').empty();
				
				$('.pagination').append('<li class="page-item"><a class="page-link" style="background-color:black; color:white;"id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="loadBoardList(1)" style="background-color:black; color:white;">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="loadBoardList(2)"style="background-color:black; color:white;">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="loadBoardList(3)"style="background-color:black; color:white;">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="loadBoardList(4)"style="background-color:black; color:white;">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="loadBoardList(5)"style="background-color:black; color:white;">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)"style="background-color:black; color:white;">Next</a></li>');
				
				var p = 1;
				
				param={page : p};
				
				$.ajax({
					type : "GET",
					data : param,
					url : "loadBoardList",
					success : function(res) {
						$('#boardList').empty();
						
						for(var i = 0; i < res.length; i++){
							$('#boardList').append('<tr style="cursor:pointer" onclick="loadBoard('+res[i].no+')"><th>'+res[i].title+'</th><th>'+res[i].user_id+'</th><th>'+res[i].date+'</th><th>'+res[i].view+'</th></tr>');
						}
						
						if(page == null){
							$('#page1').css('font-weight', 'bold');
						} else {
							for(var i = 1; i <= 5; i++){
								if(i == page){
									$('#page'+i).css('font-weight', 'bold');
								} else {
									$('#page'+i).css('font-weight', '');
								}
							}
						}
					},
					error : function() {
						alert('게시판 리스트를 불러오는데 실패했습니다.');
					}
				});
			} else {
				if(num == 0){
					$('.pagination').empty();
				
					$('.pagination').append('<li class="page-item"><a class="page-link" style="background-color:black; color:white;"id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="loadBoardList(1, 1)" style="background-color:black; color:white;">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="loadBoardList(2, 1)"style="background-color:black; color:white;">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="loadBoardList(3, 1)"style="background-color:black; color:white;">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="loadBoardList(4, 1)"style="background-color:black; color:white;">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="loadBoardList(5, 1)"style="background-color:black; color:white;">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)"style="background-color:black; color:white;">Next</a></li>');
				}
				
				if(page==null){
					var p = 1;
				} else {
					var p = $("#page"+page).text();
				}
				
				var word = $('#searchWord').val();
				
				param={
					page : p
					, word : word 
				};
				
				$.ajax({
					type : "GET",
					data : param,
					url : "loadBoardList",
					success : function(res) {
						$('#boardList').empty();
						
						for(var i = 0; i < res.length; i++){
							$('#boardList').append('<tr style="cursor:pointer" onclick="loadBoard('+res[i].no+')"><th>'+res[i].title+'</th><th>'+res[i].user_id+'</th><th>'+res[i].date+'</th><th>'+res[i].view+'</th></tr>');
						}
						
						if(page == null){
							$('#page1').css('font-weight', 'bold');
						} else {
							for(var i = 1; i <= 5; i++){
								if(i == page){
									$('#page'+i).css('font-weight', 'bold');
								} else {
									$('#page'+i).css('font-weight', '');
								}
							}
						}
					},
					error : function() {
						alert('게시판 리스트를 불러오는데 실패했습니다.');
					}
				});
			}
		}
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

.card:hover {
	opacity: 0.6;
	border-color: silver;
}

tbody>tr:hover {
	color: white;
	background-color: #454545;
	transition: all 100ms linear;
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
					<li class="nav-item"><a class="nav-link" href='board'><b>게시판</b></a></li>
					<li class="nav-item"><a class="nav-link" href='#' onclick="checkMP()">마이페이지</a></li>
				</ul>
				<div id="signBtns">
					<button class="btn" onclick="openLogin()"
						id="login" style="margin-right: 10px; border:none">로그인</button>
					<button class="btn" onclick="openSignUp()"
						id="signUp" style="border:none;">회원가입</button>
				</div>
			</div>
		</div>
	</nav>
	<!-- Header-->
	<header class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder"style ="font-family: 'Permanent Marker', cursive;">Board</h1>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="container"
		style="margin-bottom: 5%; width: 80%;">
		<div class="input-group"
			style="width: 25%; margin-bottom: 3%; float: right">
			<input type="text" class="form-control" id="searchWord" placeholder="Search"  onkeyup="enterkey3()">
			<div class="input-group-append">
				<button class="btn btn-secondary" type="button" onclick="loadBoardList(1, 0)">검색</button>
			</div>
		</div>
		<table class="table" style="color:white">
			<thead>
				<tr>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id = "boardList">
			</tbody>
		</table>
		<button class="btn btn-secondary" style="float: right" onclick="goWrite()">글쓰기</button>
		<div style="margin-left:35%; margin-top:8%;">
			<ul class="pagination" style='cursor:pointer'>
				<li class="page-item"><a class="page-link" style="background-color:black; color:white;"id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="loadBoardList(1)" style="background-color:black; color:white;">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="loadBoardList(2)"style="background-color:black; color:white;">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="loadBoardList(3)"style="background-color:black; color:white;">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="loadBoardList(4)"style="background-color:black; color:white;">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="loadBoardList(5)"style="background-color:black; color:white;">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)"style="background-color:black; color:white;">Next</a></li>
			</ul>
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

<div class="modal" id="sc2">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class=box style="color: white">로그아웃되었습니다.</div>
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