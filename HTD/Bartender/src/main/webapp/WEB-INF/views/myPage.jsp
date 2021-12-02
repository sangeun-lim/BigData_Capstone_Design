<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script>
	$(document).ready(function() {

		loginCheck();
		loadBC();
		loadBoardList();
		window.onkeyup = function(e) {
			var key = e.keyCode ? e.keyCode : e.which;

			if (key == 27) {
				$('#c_title').empty();
				$('#cig').empty();
				$('#garnish').empty();
				$('#make').empty();
				$('#cdt').empty();
				$('#cdc').empty();
				$('#glass').empty();
				newForm();
				$(".modal").fadeOut(0);
				$("#siw").empty();
				$('.pagination').empty();
			}
		}

		$('#loginBtn').click(function() {
			login();
		});

		$('#signUpSubmit').click(function() {
			signUp();
		});
		
	});
	
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
				location.href="boardDetail2?no="+param.no+"&title="+res.title+"&content="+res.content+"&view="+res.view+"&user_id="+res.user_id+"&date="+res.date+"&time="+res.time+"&attach_id="+res.attach_id;
			},
			error : function() {
				alert('게시글을 읽어오는데 실패하였습니다.');
			}
		});
	}

	function enterkey2() {
		if (window.event.keyCode == 13) {
		    signUp();
		}
	}
	
	function loadBookmark(){
		
		param = {
			user_no : '${user.user_no}'
		}
		
		var bookmark_no;
		
		$.ajax({
			type:"GET",
			data : param,
			url:"load",
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
	
	function loadBC(){
		var user = "${user}";
		
		if (user != "") {
			var b = loadBookmark();

			param={
				bookmark_no : b
			}
			
			$('#favorites').empty();
			$('#favorites').append('<div style="margin-left:0 auto;"><img src="resources/assets/pepe3.gif" style="width:300px;"><div style="text-align:center; font-size:30px;">찾는 중 이라구~</div></div>');
			$.ajax({
				type:"GET",
				data : param,
				url:"loadBC",
				success:function(res){
					$('#favorites').empty();
					if(res != null){
						for(var i = 0; i < res.length; i++){
							var img = eval("res["+i+"].image");
							if(img != ''){
								var img=eval("res["+i+"].image").replace("C:\\cocktail\\pic", "/filepath/");
							}else{
								var img = "/filepath/no_image.png";
							}
							$('#favorites').append('<div class="col md-1" onmouseover="showStarR(\''+i+'\')" onmouseout="showStar2R(\''+i+'\')" style="text-align:center"><image id="star'+i+'R" onmouseover="changeStarR(\''+i+'\')" onmouseout="changeStar2R(\''+i+'\')" onclick=bookmarkR(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="width:40px; position: relative; right: -70px; top: 200px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="position:relative; margin-left:25px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div style="text-align:center"><h5 class="fw-bolder">'+res[i].cocktail_name+'</h5></div></div></div></div></div>');
							$('#star'+i+'R').closest("div").append('<image id="star'+i+'coveredR" onclick="deleteBookmarkR(\''+i+'\',\''+res[i].cocktail_no+'\')" src = "/resources/assets/star2.png" style="position: relative; right: -70px; top: -187px; width:40px; color:white; z-index:1;">');	
						}
					}
				},
				error:function(request, status, error){
				}
			});
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

	function openrefrige(page) {
		
		var user_no_s = '${user.user_no}';
		
		if(user_no_s == ''){
			openLogin();
		} else {
			
			$('#refrige').fadeIn();
			
			$.ajax({
				type : "GET",
				url : "igList",
				success : function(res) {
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
					if($('.pagination').html() == ''){
						$('.pagination').append('<li class="page-item"><a class="page-link" id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="openrefrige(1)" style="font-weight:bold">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="openrefrige(2)">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="openrefrige(3)">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="openrefrige(4)">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="openrefrige(5)">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)">Next</a></li>');
					}
					if (page == null) {
						var start = 0;
						var end = 9;
					} else {
						var start = (parseInt($('#page' + page).text()) - 1) * 10;
						var end = parseInt($('#page' + page).text()) * 10 - 1;
						if(end > res.length){
							end = res.length;
						}
					}
					if(res[start] == null){
						alert('페이지에 내용이 없습니다.');
						return;
					} else {
						$('#list').empty();
					}
					
					for (var i = start; i <= end; i++) {
						
						var type;
	
						if (res[i].ig_type == 1) {
							type = "기주"
						} else if (res[i].ig_type == 2) {
							type = "리큐르"
						} else if (res[i].ig_type == 3) {
							type = "그외 술"
						} else if (res[i].ig_type == 4) {
							type = "음료 및 과일"
						} else {
							type = "부가재료"
						}
	
						$('#list').append(
								'<tr onclick="addrefrige(' + (i+1) + ')"><td>'
										+ res[i].ig_name + '</td><td>' + type
										+ '</td></tr>');
					}
				},
				error : function() {
					alert("리스트를 불러오는 중 오류가 발생했습니다.");
				}
			});
		}
	}

	function addrefrige(no) {

		var user_no_s = '${user.user_no}';
		
		if(user_no_s == 0){
			openLogin();
		}
		
		param = {
			ig : no,
			user_no : user_no_s
		}

		$.ajax({
			type : "GET",
			data : param,
			url : "addRefrige",
			success : function(res) {
				if(res==0){
					alert('냉장고가 꽉찼거나 이미 있는 재료입니다.');
				} else {
					alert("추가하였습니다!");
				}
				
				loadrefrige();
			},
			error : function() {
				alert("냉장고에 추가 중 오류가 발생했습니다.");
			}
		});
	}
	
	function deleteRefri(num){
		
		var user_no_s = '${user.user_no}';
		
		param = {
			ig : 'ig'+num,
			user_no : user_no_s
		}
		
		$.ajax({
			type : "GET",
			data : param,
			url : "deleteRefri",
			success : function(res) {
				alert('삭제하였습니다.');
				location.reload();
			},
			error : function() {
				alert("삭제 중 오류가 발생했습니다.");
			}
		});
	}
	
	function loadrefrige(){
		var user_no_s = '${user.user_no}';
		
		param = {
			user_no : user_no_s
		}
		
		$.ajax({
			type : "GET",
			data : param,
			url : "loadRefrige",
			success : function(res) {
				$('#refri').empty();
				for(var i= 1; i <= 30; i++){
					if(eval("res.ig"+i+"_pic") != null){
						var img=eval("res.ig"+i+"_pic").replace("C:\\ig_pic", "/filepath2/");
					}else{
						var img = "/filepath/no_image.png";
					}
					if(eval("res.ig"+i+"_name")!=null)
						$('#refri').append('<div class="card" id= "ig'+i+'" style="width: 15%; padding: 0; margin-right: 3%;"><div class="card-header">'+eval("res.ig"+i+"_name")+'<div type="button" onclick="deleteRefri('+i+')" style="color: white; float: right">✖</div></div><div class="card-body" id="ig"><img class="card-img-top" style="width:150px; height:170px;" src="'+img+'"alt="..."/></div></div>');
				}
				fitCocktail();
			},
			error : function() {
			}
		});
	}

	function openLogin() {
		$("#myModal").fadeIn();
	}

	function closeModal(){
		$(".modal").fadeOut(0);
		$('#c_title').empty();
		$('#cig').empty();
		$('#garnish').empty();
		$('#make').empty();
		$('#cdt').empty();
		$('#cdc').empty();
		$('#glass').empty();
		newForm();
		$("#siw").empty();
		$('.pagination').empty();
	}

	function newForm() {
		$('#emailSU').val('');
		$('#nickSU').val('');
		$('#idSU').val('');
		$('#pwSU').val('');
		$('#idSI').val('');
		$('#pwSI').val('');
	}

	function modifyInfo(){
		location.href="modifyInfo"	
	}
	
	function openSignUp() {
		$("#myModal2").fadeIn();
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
								location.href="myPage";
							} else {
								closeModal();
								$("#fc").fadeIn();
								setTimeout(function() {
									$("#fc").fadeOut(400)
								}, 1000);
							}
							loginCheck();
							loadrefrige();
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

	function loginCheck() {

		var user = "${user}";
		
		if (user != "") {
			$('#signBtns').empty();
			$('#signBtns')
					.append(
							'<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">'
									+ "${user.user_nick}"
									+ ' 님</button><ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"><li><a onclick ="modifyInfo()" class="dropdown-item">회원정보 수정</a></li><li><a  onclick="logout()" class="dropdown-item">로그아웃</a></li></ul></div>');
			$('#hello').html("안녕하세요!! ${user.user_nick} 님");
		}
		loadrefrige();
		
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

	function logout() {
		$.ajax({
					type : "GET",
					url : "logout",
					success : function(res) {
						closeModal();
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

	function searchIg(page) {
		param = {
			ig_name : $('#siw').val()
		}
		
		if(param.ig_name == ''){
			openrefrige();
			return;
		}
		
		$.ajax({
					type : "GET",
					url : "searchIg",
					data: param,
					success : function(res) {
						$('#list').empty();
						$('.pagination').empty();

						for (var i = 0; i <= res.length; i++) {

							var type;

							if (res[i].ig_type == 1) {
								type = "기주"
							} else if (res[i].ig_type == 2) {
								type = "리큐르"
							} else if (res[i].ig_type == 3) {
								type = "그외 술"
							} else if (res[i].ig_type == 4) {
								type = "음료 및 과일"
							} else {
								type = "부가재료"
							}

							$('#list').append(
									'<tr onclick="addrefrige(' + res[i].ig + ')"><td>'
											+ res[i].ig_name + '</td><td>' + type
											+ '</td></tr>');
						}
					},
					error : function() {
						$("#fc2").fadeIn();
						setTimeout(function() {
							$("#fc2").fadeOut(400)
						}, 1000);
					}
				});
	}
	
	function changeStar(i){
		$('#star'+i).attr('src', 'resources/assets/star2.png');
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
					$('#star'+i).closest("div").append('<image id="star'+i+'covered" onclick="deleteBookmark(\''+i+'\',\''+bookmark_no+'\')" src = "/resources/assets/star2.png" style="position: relative; right: -70px; top: -187px; width:40px; color:white; z-index:1;">')
				}
				loadBC();
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
				loadBC();
			},
			error:function(){
				alert('즐겨찾기 추가 실패');
			}
		});
	}
	
	function changeStarR(i){
		$('#star'+i+'R').attr('src', 'resources/assets/star2.png');
	}

	function changeStar2R(i){
		$('#star'+i+'R').attr('src', 'resources/assets/star1.png');
	}

	function showStarR(i){
		$('#star'+i+'R').css('opacity', 1);
	}

	function showStar2R(i){
		$('#star'+i+'R').css('opacity', 0);
	}

	function bookmarkR(bookmark_no, i){
		
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
					$('#star'+i+'R').closest("div").append('<image id="star'+i+'coveredR" onclick="deleteBookmarkR(\''+i+'\',\''+bookmark_no+'\')" src = "/resources/assets/star2.png" style="position: relative; right: -70px; top: -187px; width:40px; color:white; z-index:1;">')
				}
				loadBC();
			},
			error:function(){
				alert('즐겨찾기 추가 실패');
			}
		});
	}
	
	function deleteBookmarkR(i, bookmark_no){
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
					$('#star'+i+'coveredR').remove();
				}
				location.reload();
			},
			error:function(){
				alert('즐겨찾기 추가 실패');
			}
		});
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
	
	function loadBoardList(page, num){
		var user_id = '${user.user_id}';	
		if(num == null){
			if(page==null){
				var p = 1;
			} else {
				var p = $("#page"+page).text();
			}
			
			param={
				page : p,
				user_id : user_id
			};
			
			$.ajax({
				type : "GET",
				data : param,
				url : "loadBoardList2",
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
			$('.pagination').empty();
			
			$('.pagination').append('<li class="page-item"><a class="page-link" style="background-color:black; color:white;"id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="loadBoardList(1)" style="background-color:black; color:white;">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="loadBoardList(2)"style="background-color:black; color:white;">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="loadBoardList(3)"style="background-color:black; color:white;">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="loadBoardList(4)"style="background-color:black; color:white;">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="loadBoardList(5)"style="background-color:black; color:white;">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)"style="background-color:black; color:white;">Next</a></li>');
			
			var p = 1;
			
			param={
				page : p,
				user_no : user_no
			};
			
			$.ajax({
				type : "GET",
				data : param,
				url : "loadBoardList2",
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
	
	function fitCocktail(){
		
		var arr = null;
		
		if('${user}'!=''){
			var b = loadBookmark();
			if(b != null){
				arr = b.split(" ");
			}
		}
		
		$('#cocktail_card').empty();
		$('#cocktail_card').append('<div style="margin: 0 auto"><img src="resources/assets/pepe3.gif" style="width:300px;"><div style="text-align:center; font-size:30px;">찾는 중 이라구~</div></div>');
		
		var user_no_s = '${user.user_no}';
		
		param = {
			user_no : user_no_s
		}
		
		$.ajax({
			type : "GET",
			url : "fitCocktail",
			data: param,
			success : function(res) {
				
				$('#cocktail_card').empty();
				
				for(var i = 0; i < res.length; i++){
					
					if(res[i].image!=null)
						var img=res[i].image.replace("C:\\cocktail\\pic", "/filepath/");
					else
						var img = "/filepath/no_image.png";
					
					if(arr == null || arr.indexOf(res[i].cocktail_no+"") == -1) {
						$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')" style="text-align:center"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="width:40px; position: relative; right: -70px; top: 200px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="position:relative; margin-left:25px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div style="text-align:center"><h5 class="fw-bolder">'+res[i].cocktail_name+'</h5></div></div></div></div></div>');
					} else {
						$('#cocktail_card').append('<div class="col md-1" onmouseover="showStar(\''+i+'\')" onmouseout="showStar2(\''+i+'\')" style="text-align:center"><image id="star'+i+'" onmouseover="changeStar(\''+i+'\')" onmouseout="changeStar2(\''+i+'\')" onclick=bookmark(\''+res[i].cocktail_no+'\',\''+i+'\') src = "/resources/assets/star1.png" style="width:40px; position: relative; right: -70px; top: 200px; opacity:0; color:white; z-index:1;"><div class="card h-100" style="color: white; background-color:transparent; border:none;" onclick="cocktailDetail(\''+res[i].cocktail_name+'\')" style="width:220px;"><img class="card-img-top" style="position:relative; margin-left:25px; width:200px; height:200px; position:relative" src="'+img+'" alt="..." /><div style="text-align:center"><h5 class="fw-bolder">'+res[i].cocktail_name+'</h5></div></div></div></div></div>');
						$('#star'+i).closest("div").append('<image id="star'+i+'covered" onclick="deleteBookmark(\''+i+'\',\''+res[i].cocktail_no+'\')" src = "/resources/assets/star2.png" style="position: relative; right: -70px; top: -187px; width:40px; color:white; z-index:1;">');
					}
				}
			},
			error : function() {
				
			}
		});
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
							$('#cig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<br>");
						} else {
							if('${user.user_no}' != 0 && eval("res.ig"+i+"_name") != null){
								$('#cig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<span style='color:red'> - 냉장고에 없음.</span><br>");
							} else {
								if(eval("res.ig"+i+"_name") != null)
									$('#cig').append(eval("res.ig"+i+"_name")+"("+eval("res.ig"+i+"_amt")+")"+"<br>");
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
</script>

<style>

.card {
	margin-bottom: 20px;
	border: none
}

.box2 {
	width: 1000px;
	height: 700px;
	padding: 40px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color:white;
	background: black;
	transition: 0.25s;
	color: white;
	left: 50%;
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

tbody>tr:hover {
	background-color: #e9ecef;
	color:black;
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

.card-body>a {
	text-decoration: none;
	color: black;
}

.span {
	display: none;
}

.list-group-item:hover {
	color: white;
	background-color: #adb5bd;
	transition: all 100ms linear;
}

#page {
	color: black;
	text-decoration: none;
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

.card > .card-header{
	background-color:black;
	color:white
}

.card > .card-body{
	background-color:#424242;
	color:white
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
					<li class="nav-item"><a class="nav-link active" href='myPage'><b>마이페이지</b></a></li>
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
	<header class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder"style ="font-family: 'Permanent Marker', cursive;">My Bar Stage</h1>
				<p class="lead fw-normal text-white-50 mb-0 mt-3" id="hello"></p>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5" style="margin-top:-40px;">
			<div class="card" style="width: 100%;">
				<div class="card-header">> 내가 쓴 글 목록</div>
				<div class="card-body">
					<div id="myPosts" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
						<table class="table" style="color: white; width:90%;">
							<thead>
								<tr>
									<th>제목</th>
									<th>작성자</th>
									<th>날짜</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody id="boardList">
							</tbody>
						</table>
						<div style="margin-top: 3%; margin-left:-10%">
							<ul class="pagination" style='cursor: pointer'>
								<li class="page-item"><a class="page-link"
									style="background-color: black; color: white;" id="page0"
									onclick="paging(0)">Previous</a></li>
								<li class="page-item"><a class="page-link" id="page1"
									onclick="loadBoardList(1)"
									style="background-color: black; color: white;">1</a></li>
								<li class="page-item"><a class="page-link" id="page2"
									onclick="loadBoardList(2)"
									style="background-color: black; color: white;">2</a></li>
								<li class="page-item"><a class="page-link" id="page3"
									onclick="loadBoardList(3)"
									style="background-color: black; color: white;">3</a></li>
								<li class="page-item"><a class="page-link" id="page4"
									onclick="loadBoardList(4)"43
									style="background-color: black; color: white;">4</a></li>
								<li class="page-item"><a class="page-link" id="page5"
									onclick="loadBoardList(5)"
									style="background-color: black; color: white;">5</a></li>
								<li class="page-item"><a class="page-link" id="page6"
									onclick="paging(1)"
									style="background-color: black; color: white;">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="card" style="width: 100%;">
				<div class="card-header">> 즐겨찾기</div>
				<div class="card-body">
					<div id="favorites" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
					</div>
				</div>
			</div>
			<div class="card" style="width: 100%;">
				<div class="card-header">> 만들 수 있는 칵테일</div>
				<div class="card-body">
					<div id="cocktail_card" class="row gx-4 gx-lg-5 row-cols-xl-4">
					</div>
				</div>
			</div>
			<div class="card" style="width: 100%;">
				<div class="card-header" style="display: flex;">
					> 냉장고
					<button type="button" class="btn btn-secondary"
						onclick="openrefrige()"
						style="margin-left: 75%; width: 200px; height: 30px; padding: 3px;">냉장고 추가하기</button>
				</div>
				<div class="card-body">
					<div id="refri" class="row gx-5 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-5 justify-content-center">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5">
		<div class="container"style="background-color:transparent">
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
				<div class=box style="color: white;">
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

<div class="modal" id="refrige">
	<div class="modal-content">
		<div class="box2" style="width: 600px;">
		<div type="button" onclick="closeModal()" style="float:right; margin-bottom:20px; color:black; font-size:30px; color:white">×</div>
			<div class="input-group" style="width: 100%; float: left">
				<input type="text" class="form-control" id="siw"
					style="border-radius: 0; height: px;"onkeypress="if( event.keyCode == 13 ){searchIg();}" placeholder="Search">
				<div class="input-group-append">
					<button class="btn btn-secondary" onclick="searchIg()" type="button">검색</button>
				</div>
			</div>
			<table class="table" style="width: 100%; color:white">
				<thead>
					<tr>
						<th>재료 이름</th>
						<th>타입</th>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
			</table>
			<div style="margin-left:10%;">
				<ul class="pagination">
					<li class="page-item"><a class="page-link" style="background-color:black; color:white;"id="page0" onclick="paging(0)">Previous</a></li><li class="page-item"><a class="page-link" id="page1" onclick="openrefrige(1)" style="background-color:black; color:white;">1</a></li><li class="page-item"><a class="page-link" id="page2" onclick="openrefrige(2)"style="background-color:black; color:white;">2</a></li><li class="page-item"><a class="page-link" id="page3" onclick="openrefrige(3)"style="background-color:black; color:white;">3</a></li><li class="page-item"><a class="page-link" id="page4" onclick="openrefrige(4)"style="background-color:black; color:white;">4</a></li><li class="page-item"><a class="page-link" id="page5" onclick="openrefrige(5)"style="background-color:black; color:white;">5</a></li><li class="page-item"><a class="page-link" id="page6" onclick="paging(1)"style="background-color:black; color:white;">Next</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="cocktailDetail">
	<div class="modal-content">
		<div class="box2">
			<div type="button" onclick="closeModal()" style="color:white; float:right; font-size:30px;">×</div>
			<div class="row">
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>
						<div id="c_title"></div>
					</h1>
					<img id="c_img" style="width: 200px; height: 200px;">
				</div>
				<div class="col-md-6" style="padding: 20px; padding-left: 40px;">
					<h1>재료</h1>
					<div id="cig"></div>
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