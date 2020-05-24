<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>로그인</title>
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
		#a{width: 278px;
    	   text-align: center;
   	       margin: 0 auto;
   	       margin-top: 100px;
   	       background-color: white;
	       padding-top: 50px;
		   padding-bottom: 50px;
		   padding-left: 120px;
		   padding-right: 120px;
		   border-radius: 4px;
		   border: 1px solid #ccc;
   	       }
   	    .container{
   	       padding: 2px;
   	    }
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
        <a class="brand" style="font-size: 35px; line-height: 30px;" href="member_login.nf">NewFace</a>
      	<a href="join2.nf"><input type="button" class="btn span2 btn-success" value="가입하기" style="margin-top: 10px; width: 100px;"></a>
      </div>
    </div>
  </div>
  
  <div id="content">
    <div id="content_inner" style="margin-top: 100px;">
	<div id="a">
	  <form action="login_ok.nf" method="post" style="margin-bottom: 0px;">
	  	<div><h4>NewFace에 로그인</h4></div>
		<div id="p1">
			<input style="width: 250px;" type="text" name="id" placeholder="이메일 또는 휴대폰 번호"><br>
			<input style="width: 250px;" type="password" name="pw" placeholder="비밀번호"><br>
		</div>
		<input style="width: 264px;" type="submit" class="btn btn-primary" value="로그인"><br>
		<div style="padding-top: 10px;"><a href="member_find.nf">비밀번호를 잊으셨나요?</a></div>
		<div style="float: left; width: 103px;"><hr style="border-color: #dcdada;"></div>
		<div style="width: 70px; float: left; padding-top: 10px;">또는</div>
		<div style="float: left; width: 103px;"><hr style="border-color: #dcdada;"></div>
		<input type="button" class="btn span2 btn-success" value="새 계정 만들기">
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