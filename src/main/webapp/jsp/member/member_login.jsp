<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>NewFace - 로그인 또는 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script src="./resources/js/jquery-3.0.0.js"></script>
<style>
  body{
    background: #e9ebee;
    padding-top: 60px;
    padding-bottom: 40px;
    position: relative;
  }
  #content{
    width: 100%;
    position: relative;
  }
  #content_inner{
  	width: 940px;
  	min-height: 300px;
  	margin: 0 auto;
  	position: relative;
  }
  .c_1{
  	width: 500px;
	position: absolute;
	top: 120px;
  }
  .c_2{
    width: 350px;
/*   	margin: 0 auto; */
	position: absolute;
	right: 8px;
	top: 100px;
  }
  .c_2 .span4{
    width: 336px;
    font-size: 18px;
  }
  .c_2 input[type="text"], .c_2 input[type="password"]{
    height: 30px;
  }
  .c_2 label{
    display: inline-block;
  }
  
  #j_btn{
    margin: 0;
    margin-top: 10px;
    width: 170px;
    height: 40px;
    font-weight: bold;
    letter-spacing: 1px;
    font-size: 20px;
  }
  
  #img1{
	  	width: 160px;
	  	height: 160px;
	  }
	  #img2, #img3{cursor: pointer;}
	  #id2{display:none;}
	  #img2:hover,#img3:hover{transform:scale(1.1);}
	 #p{width: 160px;
	 	height: 206px;
	 	cursor: pointer;
	 	position: relative;
	 	z-index: 1;
 	    border-radius: 4px;
	 	border: 1px solid #ccc;}
	 #p:hover{box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1)}
	 #p1{height: 206px;}
	 #p2{background-color: white;
	 	font-size: 18px;
   		background-color: #fff;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	    overflow: hidden;
	    text-align: center;
	    padding: 12px 0;
	    text-decoration: none;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	 	}
	 #1p{ 
	 } 
	 #2p{
	 	margin:auto;
	 	text-align: center;
	 	position: fixed;
	 }
	 li a{cursor: pointer;}
	 li{width: 200px; float: left;}
	 #b{position: absolute;
	    font-size: 20px;
	    background-color: white;
	    z-index: 1;
	    top: 575px;
	    bottom: 0px;
	    margin-top: 0px;
	    padding-top: 0px;
	    padding-bottom: 0px;
	    margin-bottom: 0px;
	    height: 300px;
	    padding-left: 460px;
	    padding-right: 266px;
	    right: 0px;
	    margin-left: 0px;
	    margin-right: 0px;
	    width: 1190px;
	    left: -488px;}
</style>
<script>
	$(function(){
		$("#p").click(function(){
			$('#1p').css('display','block');
			$('#2p').css('display','block');
		})
		
		$('#1p').click(function () {  
            $(this).hide();  
            $('#2p').hide();
            $('.window').hide();  
        });
		$('#img2').click(function(){
			$('#1p').hide();
            $('#2p').hide();
            $('.window').hide();  
		});
		$('#img3').click(function(){
			cookieDel();
		});
		

		function cookieDel() {
	      $.ajax({
	         url : "cookieDel.nf",
	         data : null,
	         type : "POST",
	         cache : false,         
	         success : function() {
	            location.reload();
	         },
	         error : function(data) {alert("오류 발생");}
	      });// ajax 끝
		};

		
		$("#j_btn").click(function(){
			if($.trim($("#id1").val()) == ""){
				alert("이메일를 입력하세요!");
				$("#id1").val("").focus();
				return false;
			}
			if($.trim($("#id2").val()) == ""){
				alert("이메일 확인을 입력하세요!");
				$("#id2").val("").focus();
				return false;
			}
			if($.trim($("#id1").val()) != $.trim($("#id2").val())){
				alert('이메일이 다릅니다.');
				$("#id1").val("");
				$("#id2").val("");
				$('#id1').focus();
				return false;
			}
			if($.trim($("#pw").val()) == ""){
				alert("회원비번을 입력하세요!");
				$("#pw").val("").focus();
				return false;
			}
			if($.trim($("#name").val()) == ""){
				alert("회원이름를 입력하세요!");
				$("#name").val("").focus();
				return false;
			}
			if($.trim($("#phone").val()) == ""){
				alert("휴대전화번호를 입력하세요!");
				$("#phone").val("").focus();
				return false;
			}
			if($.trim($("#birth").val()) == ""){
				alert("생년월일를 입력하세요!");
				$("#birth").val("").focus();
				return false;
			}
			if($("#birth").val().match(/[^0-9]/g)){
				alert("정수만 입력해주세요!");
				$("#birth").val("").focus();
				return false;
			}
			if($(':radio[name="gender"]:checked').length < 1){
				alert("성별을 선택해주세요!");
				return false;
			}
		});
	}); // function end
	
	function onkeydown_event(){
		if($("#id1").val().length > 8){
			$("#id2").css('display', 'block');
		}
	}
</script>
</head>
<body>
<!-- 메인 헤더 -->
  <div id="navbarwrap" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <a class="brand" style="font-size: 35px; line-height: 35px;" href="./member_login.nf">NewFace</a>
      	
      	<form class="navbar-form pull-right" action="./member_login_ok.nf" method="post">
      	  <input type="text" name="id" class="span2" value="${saveid }" placeholder="이메일">
      	  <input type="password" name="pw" class="span2" placeholder="비밀번호">
      	  <button type="submit" class="btn btn-inverse">로그인</button><br>
      	  <a href="member_find.nf">계정을 잊으셨나요?</a>
        </form>
      </div>
    </div>
  </div>
<!-- 메인 헤더 끝 -->

<!-- 팝업창 -->
	<div id="1p" style="position:absolute; display:none; height: 938px; width: 1920px; left:0; top:0; z-index:3; background-color: rgba(0, 0, 0, .4);"></div>
	<div id="2p" style="position: absolute; width: 280px; margin-top: 100px; margin-left: 40%;z-index: 3;display: none; text-align: center; background-color: white; padding: 20px; border-radius: 3px;">
	  <form action="member_login_ok.nf" method="post" style="margin-bottom: 0px;">
		<img id="img2" style="width: 30px; height: 30px; margin-left: 250px;" src="resources/images/closebtn.png">
		<div id="p1">
			<input type="hidden" name="id" value="${saveid}">
			<img id="img1" style="margin: auto; text-align: center; border-radius: 4px;" src="resources/upload/profileimg${m.prof_img_file}">
			<div id="p2">${m.name}</div>
		</div>
		<input type="password" name="pw" placeholder="비밀번호"><br>
		<input style="width: 220px;" type="submit" class="btn btn-primary" value="로그인"><hr>
		<a href="member_find_ok.nf?id=${saveid}">비밀번호를 잊으셨나요?</a>
	  </form>
	</div>
<!-- 팝업창 끝 -->

<!-- 컨테이너 -->
  <div id="content">
    <div id="content_inner">
	  <div id="c1" class="c_1">
		<!-- 이미지 넣읍시다 -->
		<c:if test="${empty saveid }">
		<div id="s_i_d1">
			<img id="img" src="./resources/images/main.png">
		</div>
		</c:if>
		<c:if test="${!empty saveid }">
		<div id="s_i_d2">
			<h1>최근 로그인 기록</h1>
			<h4>사진을 클릭하여 로그인하세요.</h4><br><br>
			<img id="img3" style="width: 30px; height: 30px; position:absolute; z-index: 2;" src="resources/images/closebtn.png">
			<div id="p">
				<img id="img1" src="./resources/upload/profileimg${m.prof_img_file}">
				<div id="p2">${m.name}</div>
			</div>
		</div>
		</c:if>
      </div>
    
      <div class="c_2">
        <h1>회원 가입</h1>
        <form class="navbar-form pull-right" action="./member_join_ok.nf" method="post">
      	  <input type="text" id="id1" name="id" class="span4" placeholder="이메일" onkeydown="onkeydown_event();">
      	  <input type="text" id="id2" class="span4" placeholder="이메일 확인">
      	  <input type="password" id="pw" name="pw" class="span4" placeholder="비밀번호">
		  <input type="text" id="name" name="name" class="span4" placeholder="이름">
		  <input type="text" id="phone" name="phone" class="span4" placeholder="휴대폰번호">
		  <input type="text" id="birth" name="birth" class="span4" maxlength="8" placeholder="생년월일">
<!-- 		  <span> -->
		    <label class="radio inline" for="gender1">
		      <input id="gender1" type="radio" name="gender" value="남자">남자
		    </label>
<!-- 		  </span> -->
<!-- 		  <span> -->
		    <label class="radio inline" for="gender2">
		      <input id="gender2" type="radio" name="gender" value="여자">여자
		    </label>
<!-- 		  </span> -->
		  <div><button id="j_btn" type="submit" class="btn span2 btn-success" onclick="submit1();">가입하기</button></div>
        </form>
      </div>
      
      <div id="b">
	      <div style="z-index: 2; position: absolute; width: 1030px; font-size: 20px;">
	      	<div style="color: #737373; font-size: 15px; padding-left: 25px; padding-top: 30px;">
	      		<span>한국어</span>&nbsp;&nbsp;
	      		<span>Korean</span>&nbsp;&nbsp;
	      		<span>韓国語</span>&nbsp;&nbsp;
	      		<span>Koreanisch</span>&nbsp;&nbsp;
	      		<span>Coreanica</span>&nbsp;&nbsp;
	      		<span>корейски</span>&nbsp;&nbsp;
	      		<span>ພາສາເກົາຫຼີ</span>&nbsp;&nbsp;
	      		<span>корейский</span>&nbsp;&nbsp;
	      		<span>เกาหลี</span>&nbsp;&nbsp;
	      		<span>Chi Korea</span>&nbsp;&nbsp;
	      		<span>Korejsky</span>&nbsp;&nbsp;
	      		<span>IsiKorea</span>&nbsp;&nbsp;
	      		<span>కొరియన్</span>
	      	</div>
	      	<hr style="margin-top: 10px; margin-bottom: 10px; width: 960px;border-top: 1px solid #bdbdbd;">
	      	<ul style="list-style:none;">
	      		<li><a title="NewFace에 가입하기" href="join2.nf">가입하기</a></li>
	      		<li><a title="NewFace에 로그인" href="login.nf">로그인</a></li>
	      		<li><a title="NewFace Messenger" href="login.nf">Messenger</a></li>
	      		<li><a title="NewFace에 친구 찾기" href="login.nf">친구 찾기</a></li>
	      		<li style="width: 100px;"><a title="NewFace에 프로필" href="login.nf">프로필</a></li>
	      	</ul>
	      	<div style="color: #737373; font-size: 11px; padding-left: 25px; padding-top: 30px;">
	      		<span>NewFace © 2019</span> 	
	      	</div>
	      </div>
      	</div>
    </div>
  </div>
<!-- 컨테이너 끝 -->
</body>
</html>