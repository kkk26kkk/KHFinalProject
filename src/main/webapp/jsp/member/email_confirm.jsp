<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>이메일 인증</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
	<script src="./resources/js/jquery-3.3.1.js"></script>
	<script src="./resources/js/member2.js"></script>
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
	/*   	margin: 0 auto; */
		position: absolute;
		top: 120px;
		
	  }
	  .c_2{
	    width: 350px;
		margin: 0 auto;
		margin-top: 100px;
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
	  #id2{display:none;}
	  #a{   margin: 0 auto;
		    width: 270px;
		    margin-top: 100px;
		    background-color: white;
		    padding: 50px;
		    border-radius: 4px;
		    border: 1px solid #ccc;}
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
</head>
<body>
	<!-- 메인 헤더 -->
	  <div id="navbarwrap" class="navbar navbar-inverse navbar-fixed-top">
	    <div class="navbar-inner">
	      <div class="container">
	        <a class="brand" style="font-size: 35px; line-height: 35px;" href="member_login.nf">NewFace</a>
	      	<form class="navbar-form pull-right" action="login_ok.nf" method="post">
	      	  <input type="text" name="id" class="span2" value="${saveid}" placeholder="이메일">
	      	  <input type="password" name="pw" class="span2" placeholder="비밀번호">
	      	  <button type="submit" class="btn btn-inverse">로그인</button><br>
	      	  <a href="member_find.nf">계정을 잊으셨나요?</a>
	        </form>
	      </div>
	    </div>
	  </div>
	<!-- 메인 헤더 끝 -->
	
	<div id="content">
    <div id="content_inner" style="margin-top: 100px;">
	<div id="a">
	  <form action="./email_confirm_ok.nf" method="post" style="margin-bottom: 0px;">
	  <h3 style="margin-top: 0px; margin-bottom: 20px;">인증</h3>
	  <strong>인증키를 입력해주세요.</strong>
	    <input type="hidden" name="id" value="${id}"><br>
	    <input type="text" name="authkey" style="margin-bottom: 0px;" placeholder="인증키">
		<input type="submit" class="btn-primary" value="전송">    
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