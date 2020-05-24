<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 재설정 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
	<script src="./resources/js/bootstrap.js"></script>
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
	  img{width: 100px;}
	  #a0{  width: 580px;
		    margin: 0 auto;
		    margin-top: 100px;
		    background-color: white;
            border: 1px solid #ccc;
   			border-radius: 4px;}
	  #a1{padding-top: 10px;
    	  padding-left: 20px;}
	  #a2{padding-left: 20px;
	      padding-right: 20px;
	      padding-top: 20px;}
 	  #a4{text-align: right;
   	 	  padding: 8px 10px;
 	      background-color: #f2f2f2;
    	  border-top: 1px solid #ccc;} 
	  hr{margin-top: 0px;
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
	
	$(function(){
		$("#r").click(function(){
			location.href='member_find.nf';	
		})
	});
	</script>
</head>
<body>	
<!-- 메인 헤더 -->
  <div id="navbarwrap" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <a class="brand" style="font-size: 35px; line-height: 35px;" href="member_login.nf">NewFace</a>
      	
      	<form class="navbar-form pull-right" action="login_ok.nf" method="post">
      	  <input type="text" name="id" class="span2" placeholder="이메일">
      	  <input type="password" name="pw" class="span2" placeholder="비밀번호">
      	  <button type="submit" class="btn">로그인</button><br>
      	  <a href="member_find.nf">계정을 잊으셨나요?</a>
        </form>
      </div>
    </div>
  </div>
<!-- 메인 헤더 끝 -->

	<div id="content">
    <div id="content_inner" style="margin-top: 100px;">
	<div id="member_find">
		<form action="member_find_pw.nf" method="post">
			<div id="a0">
				<div id="a1">
					<h4>비밀번호 재설정</h4><hr style="width: 520px;">
				</div>
				<div id="a2">
					<div>
						<input type="hidden" name="id" value="${fid}">
					</div>
					<table>
						<tr>
							<td>
								<table style="width: 400px; height: 140px; border-right: 1px solid #e8ebf3;">
									<tr>
										<td><strong>이메일로 임시 비밀번호 코드를 받으시겠어요?</strong></td>
									</tr>
									<tr>
										<td>
											<img style="width: 30px; height: 25px;" src="resources/images/email.png">
											<strong>이메일로 코드받기</strong><br>
											<div style="padding-left: 35px;">${fid}</div><br><br>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<div style="padding-left: 25px;">
									<div>
										<img style="width: 50px; height: 50px;" src="./resources/upload/profileimg${fprof_img}">
									</div>
									<div>
										<strong>${fname}</strong>
									</div>
									<div style="color: #90949c; font-size: 12px;">NewFace 사용자</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div id="a4">
					<input type="submit" class="btn-primary" value="계속하기">
					<input type="button" id="r" class="btn-danger" value="회원님이 아니신가요?">
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