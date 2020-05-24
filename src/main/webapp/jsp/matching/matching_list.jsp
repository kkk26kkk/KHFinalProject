<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>친구매칭</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
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
	
	// 알림 표시 2초 후 나타남
	
	  setTimeout(function() {
		 $('#c_1').css('display', 'block'); 
	  }, 2000);
	  
	  // 2초마다 새 알림 체크
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
	
	/* 공통 끝 */
	
	/* jQuery 같은 경우 페이지가 로드되고나서 자체 함수를 dom객체에 하나씩 하나씩 넣습니다. 
	   ajax로 불러온 태그의 경우 제이쿼리 관련 메서드가 저장되어 있지 않기때문에 다음과 같은 문제가 발생합니다.
	   $(document)를 통해 함수가 호출되기전 문서를 새로 읽어서 작업을 하도록 하여야 합니다. */

	  $('.fr_accept_btn').click(function(){
		  $(this).parent().parent().append('<div class="f_d_b"><button class="btn btn-small btn-success disabled"><strong><i class="icon-ok icon-white"></i> 매칭 수락</strong></button></div>');
		  $(this).parent().remove();
	  });
	  $('.fr_reject_btn').click(function(){
		  $(this).parent().parent().append('<div class="f_d_b"><button class="btn btn-small btn-danger disabled"><strong><i class="icon-ban-circle icon-white"></i> 매칭 거절</strong></button></div>');
		  $(this).parent().remove(); 
	  });
	  $('.fr_delete_btn').click(function(){
		  $(this).parent().parent().append('<div class="f_d_b"><button class="btn btn-small btn-inverse disabled"><strong><i class="icon-remove icon-white"></i> 매칭 친구 목록에서 삭제됨</strong></button></div>');
		  $(this).parent().remove();
	  });
}); // function end

/* 공통 */

  // 알림 드롭 다운 시 목록 조회
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

// 매칭 요청 수락
function match_accept(id1){
	$.ajax({
		url : 'matching_accept',
		data : {
			'id1' : id1,
			'id2' : '${sessionScope.id}',
			'm_friend' : 2
		},
		type : 'POST',
		dataType : 'json',
		cache : false,
		success : function(){
			alert('매칭 요청 수락했습니다.');
		},
		error : function(){
			alert('error');
		}
	});
}

// 매칭 요청 거절
function match_reject(request_id){
	$.ajax({
		url : 'matching_reject',
		data : {
			'request_id' : request_id,
			'accept_id' : '${sessionScope.id}',
			'm_friend' : 2
		},
		type : 'POST',
		dataType : 'json',
		cache : false
	});
}

// 매칭 친구 삭제
function friend_delete(id1){
	  $.ajax({
		 url : 'friend_delete',
		 data : {
			 'id1' : id1,
			 'id2' : '${sessionScope.id}',
			 'm_friend' : 2
		 },
		 dataType : 'json',
		 type : 'POST',
		 cache : false
	  });
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
    background: #e9ebee;
    padding-top: 60px;
    padding-bottom: 40px;
  }
  
  ul{
    list-style: none;
    margin: 0;
  }  
  
  #containerWrap{
    width: 940px;
    margin: 0 auto;
  }
  
  #m_f_list, #m_f_reqlist{
    background: #fff;
  }
  #m_f_ul li, #m_f_requl li{
  	padding: 10px;
  	border-bottom: 1px solid #dddfe2;
  }
  #m_c_t{
  	padding-left: 16px;
    font-size: 22px;
    border-bottom: 1px solid #dddfe2;
  }
  #m_c_t2{
  	padding-left: 16px;
    font-size: 13px;
  }
  .m_c_t3{
  	margin: 0;
  	padding-left: 16px;
    font-size: 13px;
    padding: 10px 10px 10px 16px;
    border-bottom: 1px solid #dddfe2
  }
  
  #condition_menu{
    border-bottom: 1px solid #dddfe2;
  	background: #fff;
  	padding: 12px 12px 12px 16px;
  	margin-top: 10px;
  	margin-bottom: 20px;
    position: relative;
  }
  
  .m_d_c{
  	margin-bottom: 15px;
  }
  #m_g_d{
  	position: absolute;
    bottom: 105px;
    left: 287px;
  }
  #m_o_b{
  	display: inline-block;
    margin-left: 40px;
  }
  
  .m_f_d{
  	margin-left: 10px;
    display: inline-block;
  }
  .m_f_d_d{
  	font-size: 13px;
  	padding-left: 1px;
  	color: #90949c;
  }
  .m_f_p{
  	width: 80px;
  	height: 80px;
  	border-radius: 50%;
  	float: left;
    margin-left: 10px;
  }
  .m_f_d_b{
  	position: absolute;
    bottom: 30px;
    right: 15px;
  }
  .m_f_p_dd{
  	position: relative;
  }
  .m_f_d a{
  	text-decoration: none;
  }
  
  #m_f_reqlist{
  	margin-bottom: 20px;
  }
  .f_d_b{
  	position: absolute;
    bottom: 30px;
    right: 15px;
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

<!-- 본문 -->
<div id="containerWrap">
  <div id="containerinner">
    <h3 id="m_c_t">매칭</h3>
    
    <div id="m_f_reqlist">
    <h4 class="m_c_t3">매칭 요청</h4>
      <ul id="m_f_requl">
        <c:if test="${empty m_req_list }">
          <li><span style="padding-left: 5px; font-size:12px;"><strong>매칭 요청이 없습니다.</strong></span></li>
        </c:if>
        
        <c:if test="${!empty m_req_list }">
        <c:forEach var="reqm" items="${m_req_list }">
          <li>
            <div class="m_f_p_dd">
              <div>
	            <img class="m_f_p" src="./resources/upload/profileimg${reqm.prof_img_file }">
	            <div class="m_f_d">
	              <a href="./timeline.nf"><strong>${reqm.name }</strong></a>
	              <div class="m_f_d_d">${reqm.birth }</div>
	              <div class="m_f_d_d">${reqm.sido }&nbsp;${reqm.sigungu }</div>
	              <div class="m_f_d_d">${reqm.m_hobby }</div>
	            </div>
	          </div>
	          
	          <c:if test="${reqm.id != sessionScope.id }">
				<div class="m_f_d_b">
				  <button type="button" class="btn btn-small fr_accept_btn" onclick="match_accept('${reqm.id}')"><strong>수락</strong></button>
                  <button type="button" class="btn btn-small fr_reject_btn" onclick="match_reject('${reqm.id}')"><strong>거절</strong></button>
				</div>
              </c:if>
            </div>
          </li>
        </c:forEach>
        </c:if>
      </ul>
    </div>
    
    <div id="m_f_list">
    <h4 class="m_c_t3">매칭 친구</h4>
      <ul id="m_f_ul">
      <c:if test="${empty m_f_list }">
        <li><span style="padding-left: 5px; font-size:12px;"><strong>지금 바로 매칭 요청을 보내세요!</strong></span></li>
      </c:if>
      
      <c:if test="${!empty m_f_list }">
        <c:forEach var="sm" items="${m_f_list }">
          <li>
            <div class="m_f_p_dd">
              <div>
	            <img class="m_f_p" src="./resources/upload/profileimg${sm.prof_img_file }">
	            <div class="m_f_d">
	              <a href="./timeline.nf"><strong>${sm.name }</strong></a>
	              <div class="m_f_d_d">${sm.birth }</div>
	              <div class="m_f_d_d">${sm.sido }&nbsp;${sm.sigungu }</div>
	              <div class="m_f_d_d">${sm.m_hobby }</div>
	            </div>
	          </div>
	          
	          <div class="f_d_b">
                <button type="button" class="btn btn-small fr_delete_btn" onclick="friend_delete('${sm.id}')"><strong>삭제</strong></button>
              </div>
	          
            </div>
          </li>
        </c:forEach>
      </c:if>
      </ul>
    </div>
  
  </div>
</div>
<!-- 본문 끝 -->
</body>
</html>