<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 변경 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
	<script src="./resources/js/jquery-3.3.1.js"></script>
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
	  	width: 350px;
	/*   	margin: 0 auto; */
		position: absolute;
		
	  }
	  .c_2{
	    width: 350px;
	/*   	margin: 0 auto; */
		position: absolute;
		right: 8px;
		top: 0px;
	  }
	  .c_2 .span4{
	    width: 336px;
	    font-size: 18px;
	  }
	  .c_2 input{
	    height: 30px;
	  }
	  .c_2 label{
	    display: inline-block;
	  }
	  
	  #j_btn{
	    margin: 0;
	    width: 170px;
	    height: 40px;
	    font-weight: bold;
	    letter-spacing: 1px;
	    font-size: 20px;
	  }
	  #a0{
	  	width : 222px;
	  	margin: 0 auto;
	  	margin-top: 100px;
  	    padding: 50px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background-color: white;
	  }
	  h3{margin-top: 0px;
    	 margin-bottom: 0px;}
    	 
    	 li a{cursor: pointer;}
      li{width: 200px; float: left;}
      #b{position: absolute;
          font-size: 20px;
          background-color: white;
          z-index: 1;
          top: 470px;
          bottom: 0px;
          margin-top: 0px;
          padding-top: 0px;
          padding-bottom: 0px;
          margin-bottom: 0px;
          height: 320px;
          padding-left: 460px;
          padding-right: 266px;
          right: 0px;
          margin-left: 0px;
          margin-right: 0px;
          width: 1190px;
          left: -488px;}
</style>
<script>
$(document).ready(function(){
	$("#a").click(function(){
		if($.trim($("#pw1").val()) == ""){
			alert("회원비번을 입력하세요!");
			$("#pw1").val("").focus();
			return false;
		}
		if($.trim($("#pw2").val()) == ""){
			alert("회원비번 확인을 입력하세요!");
			$("#pw2").val("").focus();
			return false;
		}
		if($.trim($("#pw1").val()) != $.trim($("#pw2").val())){
			//!=같지않다 연산. 비번이 다를 경우
			alert("비번이 다릅니다!");
			$("#pw1").val("")
			$("#pw2").val("")
			$("#pw1").focus();
			return false;
		}
	})
	
	$("#logout").click(function(){
		location.href="logout.nf";
	})
})
</script>
</head>
<body>	
<!-- 메인 헤더 -->
  <div id="navbarwrap" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container" style="margin-top: 10px; margin-bottom: 10px;">
        <a class="brand" style="font-size: 35px;" href="member_login.nf">NewFace</a>
      	<div class="brand">${name}</div>
      	<div><input type="button" id="logout" class="btn" value="로그아웃"></div>
      </div>
    </div>
  </div>
<!-- 메인 헤더 끝 -->
	
	<div id="content">
    <div id="content_inner" style="margin-top: 100px;">
	
	<div id="member_find">
		<form action="member_find_pw_form_ok_ok.nf" method="post">
			<div id="a0">
				<div>
					<h3>비밀번호 변경</h3><hr>
				</div>
				<div style="padding-bottom: 20px;">
					<input type="hidden" value="${id})">
					<input type="password" id="pw1" name="pw" placeholder="비밀번호"><br>
					<input type="password" id="pw2" placeholder="비밀번호 확인"><br>
				</div>
				<div style="text-align: right;">
					<input type="submit" id="a" class="btn-primary" value="변경하기"
							onclick="submit();">
					<input type="reset" class="btn-danger" value="취소"
							onclick="$('#pw1').focus()">
				</div>
			</div>
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
               <li><a title="NewFace Messenget" href="login.nf">Messenger</a></li>
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
</body>
</html>