<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="date" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<title>메신저</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
<link rel="stylesheet" type="text/css" href="./resources/css/ws.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script src="./resources/js/jquery-3.3.1.js"></script>
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
  });
  
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
  
var id= "${sessionScope.id}";
var s_id = "${id1}";
var r_id = "${id2}";
var g_webSocket = null;

function call(){
   $.ajax({
      url : "call",
      data : {"s_id":s_id,
            "r_id":r_id},
      dataType : "json", 
      type : "POST",
      cache : false,
      success : function(r) {            
         $('#toyou').empty();
         $(r).each(function(index, item) {
            if(item.s_id == s_id){
               $('#toyou').append('<div class="cloud"><div class="msg">' +item.m+
                     '</div><br><div class="time1">'+item.inputdate+'</div></div>');
               }
               else{
               $('#toyou').append('<div class="cloud2"><div class="msg">'  +item.m+
                     '</div><br><div class="time1">'+item.inputdate+'</div></div>');
               }
            toyou.scrollTop = toyou.scrollHeight;
         })
      },
      /* error : function(r) {
         alert("대화를 건네보세요.");
      } */
   });// ajax 끝: receiver창 update
}//call() end

function save(){
   $.ajax({
      url : "save",
      data : {"s_id":s_id,
            "r_id":r_id,
            "m": $('#inputMsgBox').val()},
      dataType : "json", 
      type : "POST",
      cache : false,
      success : function(r) {
         
            $('#toyou').empty();
            $(r).each(function(index, item) {
               if(item.s_id==s_id){
               /* $('#toyou').append('<div class="cloud"><p>' +item.m+ '</p></div>'); */
                  $('#toyou').append('<div class="cloud"><div class="msg">' +item.m+
                        '</div><br><div class="time1">'+item.inputdate+'</div></div>');
                  }
                  else{
                  $('#toyou').append('<div class="cloud2"><div class="msg">'  +item.m+
                        '</div><br><div class="time1">'+item.inputdate+'</div></div>');
                  }
               toyou.scrollTop = toyou.scrollHeight;
            })
      },
      /* error : function(r) {
   
         alert("대화를 건네보세요.");
      } */
   });// ajax 끝: sender창 update 
}

function fr(){
   $.ajax({
      url : "friend_request.nf",
      data : {"a_flag": '1',
         "m_friend": 1,
         "request_id": $('#id1').val(),
         "accept_id": $('#id2').val()},
      dataType : "json", 
      type : "POST",
      cache : false,
//       error : function(r) {
//          alert("fr() error");
//       }
   });// ajax 끝
}

window.onload = function(){
   inputMsgBox = document.getElementById("inputMsgBox");
   chatBoxArea = document.getElementById("chatBoxArea");
   toyou = document.getElementById("toyou");
   outer = document.getElementById("outer");
         
   g_webSocket = new WebSocket("ws://192.168.0.46:8088/pro/websocket");
         
      /*웹 소켓 사용자 연결 성립하는 경우 호출*/
   g_webSocket.onopen = function(message){
      addLineToChatBox("Server is connected.");
      g_webSocket.send("'"+id+"' 님이 채팅방에 입장하셨습니다: '" + r_id+"'님과의 일대일 대화입니다.");
      call();
   };//onopen end
         
      /*웹 소켓 message from server 수신하는 경우 호출*/
   g_webSocket.onmessage = function(message){
      addLineToChatBox(message.data);
   };
         
      /*웹 소켓 사용자 연결 해제하는 경우 호출*/
   g_webSocket.onclose = function(message){
      addLineToChatBox("Server is disconnected.");
   };
         
      /*웹 소켓 사용자 error 발생하는 경우 호출*/
   g_webSocket.onerror = function(message){
      addLineToChatBox("Error");
   };
}//onload end

   /*채팅 박스 영역에 내용 한줄 추가*/
 function addLineToChatBox(_line){
   
   if(_line == null){
      _line = "";
   }
   
   if(_line == "2"){
      call();
   }
   
   chatBoxArea.value += _line + "\n";
   chatBoxArea.scrollTop = chatBoxArea.scrollHeight;
}   //addLineToChatBox end

function sendButton_onclick(){
   
   if(inputMsgBox == null || inputMsgBox.value==null
         ||inputMsgBox.value.length ==0){
      return false;
   }
   
   if(g_webSocket == null || g_webSocket.readyState == 3){
      chatBoxArea.value += "Server is disconnected.\n";
      return false;
   }
   
   save();
   g_webSocket.send("2");
   inputMsgBox.value="";
   inputMsgBox.focus();
}   //sendButton_onclick() end

/*Disconnect button click*/
 function disconnectButton_onclick(){
   if(g_webSocket != null){
      g_webSocket.close();
   }
}
 /*inputMsgBox 키 입력하는 경우 호출*/
 function inputMsgBox_onkeypress(){
   if(event == null){
      return false;
   }
   
   //엔터 키 누를 경우 send a message to the server
   var keyCode = event.keyCode||event.which;
   if(keyCode == 13){
      sendButton_onclick();
   }
}//inputMsgBox_onkeypress() end
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

<c:if test="${sessionScope.id == id1}">
   <div id="all">
      <div id="fl">
         <div class="relative">
         <h4>친구목록</h4>
         <div class="scroll">
         <c:forEach var="m" items="${m_friend_list}">
         <c:if test="${m.m_friend == 1}">
         <!-- colored -->
         <c:choose>
            <c:when test="${m.id2 == id2}">
               <div class="colored">   
               <form action="one" method="get" class="m_list">
         
               <input type="hidden" name="id1" value="${m.id1}">
               <input type="hidden" name="id2" value="${m.id2}">
                  <div class="inline">
                         <c:choose>
                        <c:when test="${m.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="50" width="50">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${m.prof_img_file}" height="50" width="50">
                        </c:otherwise>
                     </c:choose>
                  </div>
                  <div class="inline">
                      ${m.name}<br>
                      ${m.id2}
                     </div>
                     <div class="inline">   
                     <button type="submit" class="btn btn-small"><strong>대화</strong></button>
                  </div>      
               </form>
               </div>
            </c:when>
            <c:otherwise>
            <div class="absolute">   
               <form action="one" method="get" class="m_list">
         
               <input type="hidden" name="id1" value="${m.id1}">
               <input type="hidden" name="id2" value="${m.id2}">
                  <div class="inline">   
                         <c:choose>
                        <c:when test="${m.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="50" width="50">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${m.prof_img_file}" height="50" width="50">
                        </c:otherwise>
                     </c:choose>
                  </div>
                  <div class="inline">
                         ${m.name}<br>
                         ${m.id2}
                     </div>   
                  <div class="inline">
                     <button type="submit" class="btn btn-small"><strong>대화</strong></button>
                  </div>   
               </form>
            </div>
            </c:otherwise>
         </c:choose>
         </c:if>
         </c:forEach>      
         </div>
      </div>   
      </div>
      
      <div id="middle">
      <c:if test="${id1 != id2}">
         <div class="relative2">
         <c:choose>
            <c:when test="${mfriend_detail.m_friend == 1}">
               <div class="inline1">
                     <c:choose>
                        <c:when test="${mfriend_detail.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="80" width="80">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${mfriend_detail.prof_img_file}" height="80" width="80">
                        </c:otherwise>
                     </c:choose>
                     <br>
                     <a href="http://192.168.0.46:8088/pro/timeline.nf?id=${mfriend_detail.id2}">${mfriend_detail.name}</a>
               </div>
            </c:when>
            <c:otherwise>
               <div class="inline1">
                     <c:choose>
                        <c:when test="${mfriend_detail.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="50" width="50">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${mfriend_detail.prof_img_file}" height="50" width="50">
                        </c:otherwise>
                     </c:choose>
               <div class="inline2">
               <form>
               <input type="hidden" id="id1" name="id1" value="${mfriend_detail.id1}">
               <input type="hidden" id="id2" name="id2" value="${mfriend_detail.id2}">
               <input type="hidden" id="m_friend" name="m_friend" value="${mfriend_detail.m_friend}">
                     <br>매칭조건: ${common_hobby}
                     <button type="submit" class="btn btn-small fr_req_btn" onclick="fr()">
                     <strong>친구신청</strong></button>   
               </form>      
               </div>
               </div>
               <div class="inline2">
                     ${mfriend_detail.m_pr}
               </div>
            </c:otherwise>
         </c:choose>
<!--          </form>    -->      
         <!-- if end -->
         <div id="out" style="margin-top:42px;">
            <div id="outer" style="height:500px;">
               <div id="toyou"></div>
            </div>
               <textarea id="chatBoxArea" style="width:800px;height:150px; display:none;"></textarea>
            
            <div id="buttondiv">      
               <input id="inputMsgBox" type="text"placeholder="Type a message" onkeypress="inputMsgBox_onkeypress()">
               <input id="sendButton" value="send" class="btn btn-small" type="button" onclick="sendButton_onclick()">
               <!-- <input id="disconnectButton" value="Disconnect" type="button" onclick="disconnectButton_onclick()"> -->
               
            </div>
         </div>
         </div>
      </c:if>
      </div>
      
      <div id="ml">
         <div class="relative">
         <h4>매칭 목록</h4>
         
         <div class="scroll">
         <c:forEach var="m" items="${m_friend_list}">
         <c:if test="${m.m_friend == 2}">
         <!-- color -->
         <c:choose>
            <c:when test="${m.id2 == id2}">
               <div class="colored">   
               <form action="one" method="get" class="m_list">
         
               <input type="hidden" name="id1" value="${m.id1}">
               <input type="hidden" name="id2" value="${m.id2}">
                  <div class="inline">
                         <c:choose>
                        <c:when test="${m.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="50" width="50">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${m.prof_img_file}" height="50" width="50">
                        </c:otherwise>
                     </c:choose>
                  </div>
                  <div class="inline">
                      ${m.name}<br>
                      ${m.id2}
                     </div>
                     <div class="inline">   
                     <button type="submit" class="btn btn-small"><strong>대화</strong></button>
                  </div>      
               </form>
               </div>
            </c:when>
            <c:otherwise>
               <div class="absolute">   
               <form action="one" method="get" class="m_list">
         
               <input type="hidden" name="id1" value="${m.id1}">
               <input type="hidden" name="id2" value="${m.id2}">
                  <div class="inline">
                         <c:choose>
                        <c:when test="${m.prof_img_file == null}">
                           <img src="./resources/upload/profileimg/default.jpg" height="50" width="50">
                        </c:when> 
                        <c:otherwise>
                           <img src="./resources/upload/profileimg${m.prof_img_file}" height="50" width="50">
                        </c:otherwise>
                     </c:choose>
                  </div>
                  <div class="inline">
                      ${m.name}<br>
                      ${m.id2}
                     </div>
                     <div class="inline">   
                     <button type="submit" class="btn btn-small"><strong>대화</strong></button>
                  </div>      
               </form>
               </div>
            </c:otherwise>
         </c:choose>
         </c:if>
         </c:forEach>
         </div>
         </div>
      </div>
   </div>
</c:if>

<c:if test="${sessionScope.id != id1 && sessionScope.id != id2 || empty sessionScope.id}">
    <script>
      location.href='http://192.168.0.46:8088/pro';
    </script>

</c:if>
</body>
</html>