<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
<script src="./resources/js/jquery-3.0.0.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script src="./resources/js/jquery-3.0.0.js"></script>
<script>
  $(function(){
	  a_page = 1; // 첫 알림 받아오는 페이지
	  click_flag = 1; // 알림 드롭다운 계속 데이터 가져오는 것 방지
	  
	  $('#d_t_a').on('click', function(){
	  	  click_flag++;
	  });
	  
	  $('#mem_search_form').on('submit', function(){
		  if($.trim($('#search_input').val()) == ''){
			  alert('찾으시려는 회원의 이름이나 휴대폰 번호를 입력해주세요.');
			  $('#search_input').val('').focus();
			  return false;
		  }
	  });
	  
	  setTimeout(function() {
		 $('#c_1').css('display', 'block'); 
	  }, 2000);
	  
	  setInterval(function () {
		  $.ajax({
				 url : './allim_count_check.nf',
				 data : {
					 'id' : '${sessionScope.id}'
				 },
			  	 dataType : 'json',
			  	 type : 'POST',
			  	 cache : false,
			  	 success : function(rdata) {
			  		 if(rdata >= 10) {
			  			 $('#c_1').css('padding-right', '3px');
			  		 }
			  		 $('#c_1').text(rdata);
			  	 }
		  });
	  }, 2000);

	  // 알림 무한 스크롤
	  aa_page = 2;
	  
	  $(window).scroll(function() {
		var scrollHeight = $(window).scrollTop() + $(window).height();
		var documentHeight = $(document).height();
		
		if(scrollHeight >= documentHeight - 20){
			console.log('scrollHeight = ' + scrollHeight);
	 		console.log('documentHeight = ' + documentHeight);
	 		console.log('a_page = ' + aa_page);
			
			allimListPlus(event, aa_page);
			aa_page++;

			event.preventDefault();
		}
	  });
	  
	  allimListPlus(event, 1);
	  
	  // allim dropdown 무한 스크롤
	  $('#allim_dropdown').scroll(function() {
	      var allimScrollHeight = $('#allim_dropdown').scrollTop() + $('#allim_dropdown').height();
		  var allimHeight = $('#allim_dropdown').height();
			
		  if(allimScrollHeight >= (allimHeight * a_page)) {
			  a_page++;
			
			  allim_dropdown_scroll(event, a_page);
				
			  event.preventDefault();
		  }
 	  });
  }); // function end
  
  function allimListPlus(event, a_page) {
	  $.ajax({
		 url : './allim_list_plus.nf',
		 data : {
			 'id' : '${sessionScope.id}',
			 'a_page' : a_page
		 },
		 dataType : 'json',
		 type : 'POST',
		 cache : false,
		 success : function(rdata) {
		  if(rdata != null) {	 
			 $(rdata).each(function(index, item){
				 var goPost = "";
				 if(item.a_flag == 1 || item.a_flag == 2) {
				 	goPost = "goTimeline(" + item.a_flag + ", " + item.a_no + ", '" + item.id + "', event)";
				 } else if(item.a_flag == 3 || item.a_flag == 4) {
				 	goPost = "goBoardOne(" + item.a_flag + ", " + item.a_no + ", '" + item.accept_id + "', " + item.board_no + " , event)";
				 }
				 
				 var list_color = ' ';
				 if(item.read_check == '1') {
					 list_color = ' class="r_c2" ';
				 } else if(item.read_check == '2') {
					 list_color = ' class="r_c3" ';
				 }
				 var output = '<li' + list_color + '><div><a class="a_l_d" href="#" onclick="' + goPost + '">'
				 		    + '<img class="a_l_i" src="./resources/upload/profileimg' + item.prof_img_file + '">'
				 		    + '<span>' + item.name + '</span>';
				 
				 var img_src = '';
	 		     if(item.a_flag == '1') {
					 output += '님이 친구 요청을 보냈습니다.';
					 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yx/r/6758WWY2lvr.png" alt=""';
			 	 } else if(item.a_flag == '2') {
			 		 output += '님이 매칭 요청을 보냈습니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yx/r/6758WWY2lvr.png" alt=""';
			 	 } else if(item.a_flag == '3') {
			 		 output += '님이 회원님의 게시글을 좋아합니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yB/r/lDwm6Y_i0v8.png" alt=""';
			 	 } else if(item.a_flag == '4') {
			 		 output += '님이 회원님의 게시글에 댓글을 남겼습니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yj/r/AN4PFNRulRD.png" alt=""';
			 	 }
	 		     output += item.a_no + '<div class="r_d_c"><img class="d_img"' + img_src + '>' + item.reg_date + '</div></a></div></li>';
	 		     
	 		     $('#al_list').append(output);
			 });
		    }
		 else {
		   alert(a_page);
		   a_page--;			 
		 } 
		  
		 },
		 
		 
		 error : function(data) {
			 alert('error');
		 }
	  });
  }
  
  //알림 드롭 다운 시 목록 조회
  function allim_dropdown(event){
	  if(click_flag == 1) {
		  getAllim_dropdown_list(event);
	  } else {
		  return false;
	  }
  }
  
  function allim_dropdown_scroll(event){
	  getAllim_dropdown_list(event);
  }
  
  function getAllim_dropdown_list(event){
	  event.preventDefault();
	  
	  $.ajax({
		 url : './allim_dropdown_list.nf',
		 data : {
			 'id' : '${sessionScope.id}',
			 'a_page' : a_page
		 },
		 dataType : 'json',
		 type : 'POST',
		 cache : false,
		 success : function(rdata) {
		   if(rdata != "") {
			 $(rdata).each(function(index, item){
				 
				 // a_flag에 따라 주소값 달라져야함
				 var goPost = "";
				 if(item.a_flag == 1 || item.a_flag == 2) {
				 	goPost = "goTimeline(" + item.a_flag + ", " + item.a_no + ", '" + item.id + "', event)";
				 } else if(item.a_flag == 3 || item.a_flag == 4) {
				 	goPost = "goBoardOne(" + item.a_flag + ", " + item.a_no + ", '" + item.accept_id + "', " + item.board_no + " , event)";
				 }
				 
				 var list_color = ' ';
				 if(item.read_check == '1'){
					 list_color = ' class="gray" ';
				 } else if(item.read_check == '2'){
					 list_color = ' class="white" ';
				 }
				 
				 var output = '<li' + list_color + '><div><a href="#" onclick="' + goPost + '">' 
				 			+ '<img class="i_c_1" src="./resources/upload/profileimg' + item.prof_img_file + '">'
				 			+ '<strong>' + item.name + '</strong>';
				 
				 var img_src = '';
				 if(item.a_flag == '1') {
					 output += '님이 친구 요청을 보냈습니다.';
					 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yx/r/6758WWY2lvr.png" alt=""';
			 	 } else if(item.a_flag == '2') {
			 		 output += '님이 매칭 요청을 보냈습니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yx/r/6758WWY2lvr.png" alt=""';
			 	 } else if(item.a_flag == '3') {
			 		 output += '님이 회원님의 게시글을 좋아합니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yB/r/lDwm6Y_i0v8.png" alt=""';
			 	 } else if(item.a_flag == '4') {
			 		 output += '님이 회원님의 게시글에 댓글을 남겼습니다.';
			 		 img_src = 'src="https://static.xx.fbcdn.net/rsrc.php/v3/yj/r/AN4PFNRulRD.png" alt=""';
			 	 }
				 output += item.a_no + '<div class="o_d"><img class="d_img"' + img_src + '>' + item.reg_date + '</div></a></div></li>';
				 
				 $('#allim_dropdown').append(output); // 거꾸로 붙임
			 });
			 
		   } else{
			   a_page--;
		   }
		   
		 },
		 error : function(data){
			 alert('error');
		 }
	  }); // ajax end
  }
  
  //a_flag : 1, 2 - 타임라인
  function goTimeline(a_flag, a_no, id, event) {
	  event.preventDefault();

	  var f = document.createElement('form');
	  f.name = 'goTimelineForm';
	  
	  f.action = './timeline.nf?id=' + id;
	  
	  f.method = 'post';
	  f.appendChild(addData(a_no));
	  
	  document.body.appendChild(f);
	  f.submit();
  }
  
  // a_flag : 3, 4 - 글 하나 보기
  function goBoardOne(a_flag, a_no, id, board_no, event){
	  event.preventDefault();
	  
	  var form = document.createElement('form');
	  form.name = 'goBoardOneForm';
	  
	  form.action = 'board?id=' + id + '&board_no=' + board_no;
	  
	  form.method = 'post';
	  form.appendChild(addData(a_no));
	  
	  document.body.appendChild(form);
	  form.submit();
  }
  
  function addData(a_no) {
	  var elem = document.createElement('input');
	  
	  elem.setAttribute('type', 'hidden');
	  elem.setAttribute('name', 'a_no');
	  elem.setAttribute('value', a_no);
	  
	  return elem;
  }
</script>
<style>
  /* 헤더 */
  .m_ul{
  	font-size: 13px;
  }

  #c_1{
    display: none;
    z-index: 10005;
    background: red;
    position: absolute;
    top: 0px;
    right: 5px;
    line-height: 12px;
    color: #fff;
  }
  #c_1 span{
    color: #fff;
  }
  
  #d_t_a {
    position: relative;
  }
  
  #a_p_i{
    padding: 9px 15px 7px 15px;
  }
  #a_p_i img{
    width: 24px;
    height: 24px;
    border-radius: 50%;
    margin-right: 5px;
  }
  
  .i_c_1{
  	width:40px;
  	height:40px;
  	border-radius: 50%;
  	margin-right: 10px;
  	float: left;
  }
  
  /* 알림 드롭다운 */
  .gray{
    background: #eeeeee;
  }
  
  #allim_dropdown{
    overflow-y: scroll;
    height: 400px; /* 400px 이상 */
    width: 400px;
    margin: 0;
  }
  #allim_dropdown li{
    height: 60px;
  }
  .gray{
  	background: #dfe3ee;
    border-bottom: 1px solid #dddfe2;
  }
  .white{
  	background: #fff;
    border-bottom: 1px solid #dddfe2;
  }
  .gray a, .white a{
  	text-decoration: none;
    display: block;
	height: 40px;
	padding: 10px;
  	color: #000;
  	font-size: 12px;
  }
  .gray:hover, .white:hover{
  	background: #eeeeee;
  }
  .gray a:hover, .white a:hover{
  	color: #000;
  }
  #a_h{
  	padding-left: 11px;
    padding-bottom: 4px;
    border-bottom: 1px solid #dddfe2;
    font-weight: 800;
  }
  #a_f{
  	padding-left: 13px;
    padding-top: 4px;
    border-top: 1px solid #dddfe2;
    text-align: center;
    font-weight: 800;
  }
  #a_f a{
  	text-decoration: none;
  	color: #000;
  }
  .d_img{
  	margin-right: 3px;
  }
  /* 알림 드롭다운  끝 */
  
  /* 본문 */
  body{
 	background: #f7f7f7; 
    padding-top: 60px;
    padding-bottom: 40px;
  }
  
  ul{
    list-style: none;
  }
  
  #containerWrap{
    width: 940px;
    margin: 0 auto;
  }
  
  .r_c2{
    background: #dfe3ee;
    border-bottom: 1px solid #dddfe2;
  }
  .r_c3{
  	background: #fff;
    border-bottom: 1px solid #dddfe2;  	
  }
  .r_c2 a, .r_c3 a{
    display: block;
  	height: 60px; /* 40px로 수정 */
  	color: #000;
  	font-size: 12px;
  }
  .r_c2 a > span, .r_c3 a > span{
  	font-weight: 800;
  }
  .r_c2:hover, .r_c3:hover{
    background: #eeeeee;
  }
  
  #al_list{
  	margin: 0;
  }
  #al_list a{
    text-decoration: none;
  }
  .a_l_i{
    float:left;
    width:40px;
    height:40px;
    border-radius:50%;
    margin-right: 10px;
  }
  .a_l_d{
    padding: 10px;
    position: relative;
  }
  .r_d_c{
  	color: #90949c;
    position: absolute;
    width: 116px;
    left: 60px
  }
  .d_img{
    margin-right: 3px;
  }
  #cont_t{
  	padding-left: 16px;
    margin-bottom: 29px;
    font-size: 22px;
    border-bottom: 1px solid #dddfe2;
  }
  
/* scroll */
body::-webkit-scrollbar,
ul::-webkit-scrollbar {
    width: 6px;
}
 
body::-webkit-scrollbar-track,
ul::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
}
 
body::-webkit-scrollbar-thumb,
ul::-webkit-scrollbar-thumb {
  background-color: darkgrey;
  outline: 1px solid slategrey;
}
</style>
</head>
<body>
<!-- 헤더 -->
  <div id="navbarwrap" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
      <a class="brand" href="./main.nf">NewFace</a>
      <form id="mem_search_form" class="navbar-search pull-left form-search" action="./member_search.nf" method="post">
  		<div class="input-append">
	   	  <input type="text" id="search_input" name="name_phone" class="span5 search-query" placeholder="이름 또는 휴대폰 번호">
	      <button type="submit" class="btn btn-inverse">검색</button>
	    </div>
	  </form>
      <ul class="nav pull-right">
        <li>
          <a id="a_p_i" href="./timeline.nf?id=${s_m.id }">
		  <img src="./resources/upload/profileimg${s_m.prof_img_file }">
        	<strong>${s_m.name }</strong></a>
        </li>
        <li><a href="./friend.nf">친구</a>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">매칭</a>
          <ul class="dropdown-menu m_ul">
            <li><a href="./matching.nf">매칭하기</a></li>
            <li><a href="matchinglist">매칭목록</a></li>
          </ul>
        </li>
        <li><a href="one">메신저</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" id="d_t_a"
	         data-toggle="dropdown"
	         href="#" onclick='allim_dropdown(event)'>알림</a>
	      <!-- 안 읽은 알림 개수 페이지 로딩 후 2초 후에 뜸 -->
		  <div id="c_1"></div>
	      
	      <div id="allim_dropdown_list" class="dropdown-menu">
	      	<div id="a_h">알림</div>
		      <ul id="allim_dropdown">
	    	  </ul>
	    	  <div id="a_f"><a href="./allim_list.nf">모두 보기</a></div>
    	  </div>
    	  
        </li>
        <li class="dropdown">
	      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	        <b class="caret"></b>
	      </a>
	      <ul class="dropdown-menu m_ul">
	        <li><a href="./member_info.nf">회원정보 관리</a></li>
	        <li><a href="./change_pw.nf">비밀번호 변경</a></li>
	        <li class="divider"></li>
	        <li><a href="./logout">로그아웃</a></li>
    	  </ul>
  		</li>
      </ul>
      </div>
    </div>
    
  </div>
<!-- 헤더 끝 -->


<!-- 알림 목록 -->
<div id="containerWrap">
  <div id="containerinner">
    <h3 id="cont_t">내 알림</h3>
	<ul id="al_list">
<%--       <c:forEach var="a" items="${allim_list }"> --%>
<%--         <c:if test="${a.read_check == 1 }"> --%>
<!--         <li class="r_c2"> -->
<%--         </c:if> --%>
<%--         <c:if test="${a.read_check == 2 }"> --%>
<!--         <li class="r_c3"> -->
<%-- 		</c:if>         --%>
<!--  	       <div> -->
<%--  	         <a class="a_l_d" href="#" onclick="goPost('${a.a_flag}', '${a.a_no }', '${a.id }', event)"> --%>
<%--  	           <img class="a_l_i" src="./resources/upload/profileimg${a.prof_img_file }"> --%>
<%--                <c:if test="${a.a_flag == 1}"> --%>
<%--  	             <strong>${a.name }</strong>님이 친구 신청을 보냈습니다.${a.a_no } --%>
<%--  	           </c:if> --%>
<%--  	           <c:if test="${a.a_flag == 2 }"> --%>
<%--  	             <strong>${a.name }</strong>님이 매칭 친구 신청을 보냈습니다.${a.a_no } --%>
<%--  	           </c:if> --%>
<%--  	           <c:if test="${a.a_flag == 3 }"> --%>
<%--  	             <strong>${a.name }</strong>님이 회원님의 게시글을 좋아합니다.${a.a_no } --%>
<%--  	           </c:if> --%>
<%--  	           <c:if test="${a.a_flag == 4 }"> --%>
<%--  	             <strong>${a.name }</strong>님이 회원님의 게시글에 댓글을 남겼습니다.${a.a_no } --%>
<%--  	           </c:if> --%>
<%--  	           <div>${a.reg_date }</div> --%>
<!--  	         </a> -->
<!--  	       </div> -->
<!--  	     </li> -->
<%--       </c:forEach> --%>
    </ul>
  </div>
</div>
<!-- 알림 목록 끝 -->
</body>
</html>