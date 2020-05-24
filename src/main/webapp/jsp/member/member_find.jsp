<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>계정찾는 페이지</title>
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
	  #a0{  width: 400px;
		    margin: 0 auto;
		    margin-top: 100px;}
		    #a0 {
		    width: 555px;
		    margin: 0 auto;
		    margin-top: 100px;
		    background-color: #fff;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		}
	  #id{height: 15px;
   		  width: 260px;}
   		  
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
		<form action="member_find_ok.nf" method="post">
			<div id="a0">
				<div style=" padding-left: 10px; padding-left: 20px; padding-top: 10px;">
					<h4 style="margin-bottom: 0px;">계정 찾기</h4>
					<hr style="margin-top: 0px; margin-bottom: 10px;">
				</div>
				<div style="padding-bottom: 10px;">
					<table style="margin: 0 auto;">
						<tr><td>
							<label>계정을 검색하려면 이메일 또는 전화번호를 입력하세요.</label>
						</td></tr>
						<tr><td>
							<input type="text" id="id" name="id" placeholder="전화번호 또는 이메일 주소">
						</td></tr>
					</table>
				</div>
				<div style="text-align: right; background-color: #f2f2f2; border: 1px solid #ccc; padding: 10px; border-bottom: none; border-left: none; border-right: none;">
					<input type="submit" class="btn-primary" value="검색">
					<input type="button" class="btn-danger" value="취소" onclick="location.href='member_login.nf';">
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