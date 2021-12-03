<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>

$(document).ready(function(){
	
	srci();
	
	loginCheck();
	
	checkMessage();
	
	window.onkeyup = function(e) {
		var key = e.keyCode ? e.keyCode : e.which;

		if(key == 27) {
			$(".modal").fadeOut(0);
			setTimeout(clean(), 100);
			newForm();
		}
	}
	
	$('#loginBtn').click(function(){
		login();
	});
	
	$('#signUpSubmit').click(function(){
		signUp();
	});
});

function changeStar(i){
	$('#star'+i).attr('src', 'resources/assets/star2.png');
}

function checkMP(){
	if('${user.user_no}'!=0){
		location.href="myPage"
	} else {
		alert('로그인 후 이용가능합니다.');
		openLogin();
	}
}

function checkMessage(){
	if('${msg}'!=''){
		alert('${msg}');
	}
}

function changeStar2(i){
	$('#star'+i).attr('src', 'resources/assets/star1.png');
}

function showStar(i){
	$('#star'+i).css('opacity', 1);
}

function showStar2(i){
	$('#star'+i).css('opacity', 0);
}

function bookmark(bookmark_no, i){
	
	var user_no = '${user.user_no}';
	
	param = {
		bookmark_no : bookmark_no,
		user_no : user_no
	}
	
	$.ajax({
		type:"GET",
		url:"bookmark",
		data: param,
		async: true,
		success:function(res){
			if(res==1){
				$('#star'+i).closest("div").append('<image id="star'+i+'covered" onclick="deleteBookmark(\''+i+'\',\''+bookmark_no+'\')" src = "/resources/assets/star2.png" style="position:absolute; width:40px; top:150px; left:190px; color:white; z-index:1;">')
			}
		},
		error:function(){
			alert('즐겨찾기 추가 실패');
		}
	});
}

function deleteBookmark(i, bookmark_no){
	var user_no = '${user.user_no}';
	
	param = {
		bookmark_no : bookmark_no,
		user_no : user_no
	}
	
	$.ajax({
		type:"GET",
		url:"bookmark",
		data: param,
		success:function(res){
			if(res==1){
				$('#star'+i+'covered').remove();
			}
		},
		error:function(){
			alert('즐겨찾기 추가 실패');
		}
	});
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

function search(){
	
	var param = {cocktail_name: $('#si').val()}
	
	if(param.cocktail_name == ''){
		location.reload();
		return;
	}
	
	if(param.cocktail_name.length >= 1 && param.cocktail_name.replaceAll(' ', '') != ''){
		var arr = null;
		
		if('${user}'!=''){
			var b = loadBookmark();
			if(b != null){
				arr = b.split(" ");
			}
		}
		
		$.ajax({
			type:"GET",
			url:"searchCocktail",
			async:false,
			data: param,
			success:function(res){
				
				$('#cocktail_card').empty();
				
				if($('#rcm').html()!=''){
					$('#rcm').empty();
				}
				
				if(res.length == 0){
					alert('검색결과가 없습니다!!!');
					location.reload();
				}
				
				for(var i = 0; i < res.length; i++){
					
					if(res[i].image!=null)
						var img=res[i].image.replace("C:\\cocktail\\pic", "/filepath/");
					else
						var img = null;
					
					if("${user}" != "") {
						if(arr == null || arr.indexOf(res[i].cocktail_no+"") == -1) {
							$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="position:absolute; width:40px; top:150px; left:190px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px">'+res[i].cocktail_name+'</h5></div></div></div></div>');
						} else {
							$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="position:absolute; width:40px; top:150px; left:190px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px">'+res[i].cocktail_name+'</h5></div></div></div></div>');
							$('#star'+i).closest("div").append('<image id="star'+i+'covered" onclick="deleteBookmark(\''+i+'\',\''+res[i].cocktail_no+'\')" src = "/resources/assets/star2.png" style="position:absolute; width:40px; top:150px; left:190px; color:white; z-index:1;">');
						}
					} else {
						$('#cocktail_card').append('<div class="col md-1"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px">'+res[i].cocktail_name+'</h5></div></div></div></div>');
					}	
				}
			},
			error:function(){
				closeModal();
				$("#error").fadeIn();
				setTimeout(function(){$("#error").fadeOut(400)},1000);
			}
		});
	} else {
		alert("검색어를 입력하세요!!");
	}
}

function requiredIg(ig){
	
	var user_no_copy = '${user.user_no}';
	
	var result;
	
	param = {
		user_no : user_no_copy,
		ig : ig
	}
	
	$.ajax({
		type:"GET",
		url:"requiredIg",
		async:false,
		data: param,
		success:function(res){
			result = res;
		},
		error:function(){
		}
	});
	
	return result;
}

function cocktailDetail(name){
	
	$('#cocktailDetail').fadeIn();
	
	param = {
		cocktail_name : name	
	}
	
	if(param.cocktail_name != ""){
		$.ajax({
			type:"GET",
			url:"selectCocktail",
			data: param,
			success:function(res){
				$('#c_title').append(res.cocktail_name);
				
				for(var i = 1; i <= 10; i++){
					
					const j = requiredIg(eval("res.ig"+i));
					
					if(eval("res.ig"+i+"_name") != null && j == 1 && '${user.user_no}' != 0){
						$('#ig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<br>");
					} else {
						if('${user.user_no}' != 0 && eval("res.ig"+i+"_name") != null){
							$('#ig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<span style='color:red'> - 냉장고에 없음.</span><br>");
						} else {
							if(eval("res.ig"+i+"_name") != null)
								$('#ig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<br>");
						}
					}
				}
				
				const arr = res.make.split("\\n");
				for (var i=0; i<arr.length; i++){
					$('#make').append(arr[i]+"<br>");
				}
				
				$('#garnish').append(res.garnish);
				
				var img = res.image.replace("C:\\cocktail\\pic", "/filepath/");
				$('#c_img').attr('src', img);
				$('#glass').append(res.glass_name);
			},
			error:function(){
				closeModal();
				$("#error").fadeIn();
				setTimeout(function(){$("#error").fadeOut(400)},1000);
			}
		});
	} else {
		alert("오류가 발생하였습니다.");
	}
}

function openLogin(){
	$("#myModal").fadeIn();
}

function closeModal(){
	$(".modal").fadeOut(0);
	$('#c_title').empty();
	$('#ig').empty();
	$('#garnish').empty();
	$('#make').empty();
	$('#glass').empty();
	$('#cdt').empty();
	$('#cdc').empty();
	newForm();
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

function modifyInfo(){
	location.href="modifyInfo"	
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
							+res.user_nick+'  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li onclick= "modifyInfo()"><a class="dropdown-item">회원정보 수정</a></li><li><a onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
					alert('로그인 되었습니다.');
					location.href="index";
				} else {
					alert('아이디, 비밀번호를 확인해주세요.');
					closeModal();
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

function enterkey(param) {
	if (window.event.keyCode == 13) {
	    if(param == null) 
			login();
	    else
	    	search();
	}
}

function loginCheck(){
	
	if("${user}" != ""){
		$('#signBtns').empty();
		$('#signBtns').append('<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
				+"${user.user_nick}"+'  님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a class="dropdown-item" onclick="modifyInfo()">회원정보 수정</a></li><li><a class="dropdown-item" onclick="logout()" >로그아웃</a></li></ul></div>');
	}
}

function logout(){
	
	$.ajax({
		type:"GET",
		url:"logout",
		success:function(res){
			$('#signBtns').empty();
			$('#signBtns').append('<button class= "btn" id="login" onclick = "openLogin()" style = "margin-right:10px">로그인</button><button class= "btn" onclick="openSignUp()" id="signUp">회원가입</button>');
			alert('로그아웃 되었습니다.');
			location.reload();
		},
		error:function(){
			closeModal();
			$("#fc2").fadeIn();
			setTimeout(function(){$("#fc2").fadeOut(400)},1000);
		}
	});
}

function loadBookmark(){
	
	param = {
		user_no : '${user.user_no}'
	}
	
	var bookmark_no;
	
	$.ajax({
		type:"GET",
		data : param,
		url:"loadBookmark",
		async:false,
		dataType:"json",
		success:function(res){
			bookmark_no = res.bookmark_no;
		},
		error:function(){
			closeModal();
			$("#fc2").fadeIn();
			setTimeout(function(){$("#fc2").fadeOut(400)},1000);
		}
	});
	
	return bookmark_no;
}

function srci(){
	
	var arr = null;
	
	if('${user}'!=''){
		var b = loadBookmark();
		if(b != null){
			arr = b.split(" ");
		}
	}
	
	$.ajax({
		type:"GET",
		url:"srci",
		async:false,
		dataType:"json",
		success:function(res){
			$('#spirit').html('기주 : '+res[0].spirit);
			
			for(var i = 0; i < res.length; i++){
				
				if(res[i].image!=null)
					var img=res[i].image.replace("C:\\cocktail\\pic", "/filepath/");
				else
					var img = null;
				
				if("${user}" != "") {
					if(arr == null || arr.indexOf(res[i].cocktail_no+"") == -1) {
						$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')" style="text-align:center"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="position:absolute; width:40px; top:150px; left:190px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px;">'+res[i].cocktail_name+'</h5></div></div></div></div>');
					} else {
						$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')" style="text-align:center"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="position:absolute; width:40px; top:150px; left:190px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px;">'+res[i].cocktail_name+'</h5></div></div></div></div>');
						$('#star'+i).closest("div").append('<image id="star'+i+'covered" onclick="deleteBookmark(\''+i+'\',\''+res[i].cocktail_no+'\')" src = "/resources/assets/star2.png" style="position:absolute; width:40px; top:150px; left:190px; color:white; z-index:1;">');
					}
				} else {
					$('#cocktail_card').append('<div class="col md-1" style="text-align:center"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="margin-left:20px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div class="card-body" style = "height:70px;"><div><h5 class="fw-bolder" style="margin-left:20px">'+res[i].cocktail_name+'</h5></div></div></div></div>');
				}
			}
		},
		error:function(){
			alert("통신 실패");
		}
	});
}



function clean(){
	$('#cdc').empty();
	$('#cdt').empty();
	$('#c_title').empty();
	$('#ig').empty();
	$('#garnish').empty();
	$('#make').empty();
	$('#c_img').removeAttr('src');
	$('#glass').empty();
}
</script>

<style>

.card-img-top {
  position:relative;
}

#star {
  position:absolute;
  top:40px;
  left:80px;
  opacity:0;
}

#recommend {
	margin-top: 10px;
	margin-left: 16px;
	position: absolute;
	background: black;
	padding: 0 10px;
	z-index: 1;
}

.item {
	height: 2.5em;
	font-size: 20px;
	color: white;
	width: 400px;
	outline: none;
	padding: 5px;
}

.item:hover {
	color: #9baec8;
}

.navbar {
	background-color:black;
	color:white;
}

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

.suggest {
	display: none;
	position: absolute;
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

.box2 {
	width: 1000px;
	height: 700px;
	padding: 40px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: black;
	transition: 0.25s;
	color: white;
	left: 50%;
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

.card-img-top {
	text-align:center;
}

.searchbar {
	margin-bottom: auto;
	margin-top: auto;
	height: 60px;
	background-color: black;
	border-radius: 30px;
	padding: 10px;
}

a:link { color: white; text-decoration: none;}
a:visited { color: white; text-decoration: none;}

.search_input {
	color: white;
	border: 0;
	outline: 0;
	background: none;
	caret-color: transparent;
	line-height: 40px;
	transition: width 0.4s linear;
	padding: 0 10px;
	width: 450px;
	caret-color: red;
}

.search_icon {
	height: 40px;
	width: 40px;
	float: right;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 50%;
	background: white;
	color: black;
	text-decoration: none;
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

#aa:hover{
	background-color:white;
	color:black;
}

</style>

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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="index" method="GET" style ="font-family: 'Permanent Marker', cursive;">Hometender</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation" style="background-color:silver;">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" href='index'><b>홈</b></a></li>
					<li class="nav-item"><a class="nav-link" href='about'>소개</a></li>
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
				<h1 class="display-4 fw-bolder" style ="font-family: 'Permanent Marker', cursive;">Hometender</h1>
				<p class="lead fw-normal mb-0" style="color:white;">우리를 위한 칵테일!</p>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section>
		<div class="d-flex justify-content-center"
			style="margin-bottom: 5%; float:center;">
			<div class="searchbar">
				<input class="search_input" id="si" type="text" placeholder="검색.."
					onkeypress="enterkey(1)"> <a
					class="search_icon"><i class="fas fa-search" onclick="search()"></i></a>
				<div id="recommend" style="display: none">
					<div class="item"></div>
				</div>
			</div>
		</div>
		<div id="rcm" style="text-align:center; margin-top:-30px; margin-bottom:-20px; color:white; font-size:25px;"><b>오늘의 추천 칵테일</b><div id="spirit" style="font-size:20px;"></div></div>
		<div class="container px-lg-5 mt-5">
			<div id="cocktail_card"
				class="row gx-4 gx-lg-5 row-cols-xl-4">
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

<div class="modal" id="sc">
	<div class="modal-content">
		<div class="row">
			<div class="col-md-6">
				<div class=box style=": white">로그인되었습니다.</div>
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
				<div class=box
					style="color: white">
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
					<b style="color: red">에러 발생</b><br><br> 에러가 발생하였습니다.
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

<div class="modal" id="cocktailDetail">
	<div class="modal-content">
		<div class="box2">
			<div type="button" onclick="closeModal()" style="color:white; float:right; font-size:20px;">X</div>
			<div class="row">
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>
						<div id="c_title"></div>
					</h1>
					<img id="c_img" style="width: 200px; height: 200px;">
				</div>
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>재료</h1>
					<div id="ig"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>장식</h1>
					<div id="garnish"></div>
					<br> <br>
					<h1>잔</h1>
					<div id="glass"></div>
				</div>
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>만드는 방법</h1>
					<div id="make"></div>
				</div>
			</div>
		</div>
	</div>
</div>
