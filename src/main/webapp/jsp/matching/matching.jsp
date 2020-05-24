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
	
	// 관심사 선택된 것이 체크될 수 있도록	
	var interest = '${m.m_hobby}'.split(',');
	for(var x of interest) {
		$('.m_hobby').each(function(e){
		    if($(this).val() == x){
		        $(this).attr('checked', 'checked');
		    }
		});
	}
	
	/* jQuery 같은 경우 페이지가 로드되고나서 자체 함수를 dom객체에 하나씩 하나씩 넣습니다. 
	   ajax로 불러온 태그의 경우 제이쿼리 관련 메서드가 저장되어 있지 않기때문에 다음과 같은 문제가 발생합니다.
	   $(document)를 통해 함수가 호출되기전 문서를 새로 읽어서 작업을 하도록 하여야 합니다. */
	   
	// 매칭 요청 버튼 눌렀을 경우
	$(document).on('click', '.fr_req_btn', function(){
		$(this).parent().parent().append('<div class="m_f_d_b"><button class="btn btn-small btn-primary disabled"><strong><i class="icon-hand-right icon-white"></i> 매칭 요청 전송됨</strong></button></div>');
		$(this).parent().remove();
	});
	
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
				 output += '<div class="o_d"><img class="d_img"' + img_src + '>' + item.reg_date + '</div></a></div></li>';
				 
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

function si(z) {
   //강원도
   var sigungu_a = [ "전체", "강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "원주시",
         "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군" ];
   //경기도
   var sigungu_b = [ "전체", "가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시",
         "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시 분당구",
         "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구",
         "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구",
         "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구",
         "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시",
         "포천시", "하남시", "화성시" ];
   //경상북도
   var sigungu_c = [ "전체", "거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군",
         "양산시", "의령군", "진주시", "창녕군", "창원시 마산합포구", "창원시마산회원구", "창원시 성산구",
         "창원시 의창구", "창원시 진해구", "통영시", "하동군", "함안군", "함양군", "합천군", "" ];

   //경상남도
   var sigungu_d = [ "전체", "경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군",
         "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군",
         "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구" ];

   //광주광역시
   var sigungu_e = [ "전체", "광산구", "남구", "동구", "북구", "서구" ];

   //대구광역시
   var sigungu_f = [ "전체", "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구" ];

   //대전광역시
   var sigungu_g = [ "전체", "대덕구", "동구", "서구", "유성구", "중구" ];

   //부산광역시
   var sigungu_h = [ "전체", "강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
         "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구" ];

   //서울특별시
   var sigungu_i = [ "전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구",
         "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구",
         "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];
   //세종특별자치시 
   var sigungu_j = [ "시/군/구 없음" ];

   //울산광역시 
   var sigungu_k = [ "전체", "남구", "동구", "북구", "울주군", "중구" ];

   //인천광역시 
   var sigungu_l = [ "전체", "강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "웅진구",
         "중구" ];

   //전라남도
   var sigungu_n = [ "전체", "강진구", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시",
         "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군",
         "장흥군", "진도군", "함평군", "해남군", "화순군" ];

   //전라북도
   var sigungu_m = [ "전체", "고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군",
         "익산시", "임실군", "장수군", "전주시 덕진구", "전주시 완산구", "정읍시", "진안군" ];

   //제주특별자치시
   var sigungu_o = [ "전체", "서귀포시", "제주시" ];

   //충청남도
   var sigungu_p = [ "전체", "계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시",
         "서천군", "아산시", "예산군", "천안시 동남구", "천안시 서북구", "청양군", "태안군", "홍성군" ];

   //충청북도
   var sigungu_q = [ "전체", "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군",
         "진천군", "아산시", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시" ];

   var target = document.getElementById("sigungu");

   if (z.value == "전국") {
	 $('#sigungu').attr('readonly', 'readonly');
   } else {
	 $('#sigungu').attr('readonly', false);
   }
   
   if (z.value == "강원도") var giyek = sigungu_a;
   else if (z.value == "경기도") var giyek = sigungu_b;
   else if (z.value == "경상북도") var giyek = sigungu_c;
   else if (z.value == "경상남도") var giyek = sigungu_d;
   else if (z.value == "광주광역시") var giyek = sigungu_e;
   else if (z.value == "대구광역시") var giyek = sigungu_f;
   else if (z.value == "대전광역시") var giyek = sigungu_g;
   else if (z.value == "부산광역시") var giyek = sigungu_h;
   else if (z.value == "서울특별시") var giyek = sigungu_i;
   else if (z.value == "세종특별자치시") var giyek = sigungu_j;
   else if (z.value == "울산광역시") var giyek = sigungu_k;
   else if (z.value == "인천광역시") var giyek = sigungu_l;
   else if (z.value == "전라남도") var giyek = sigungu_n;
   else if (z.value == "전라북도") var giyek = sigungu_m;
   else if (z.value == "제주특별자치시") var giyek = sigungu_o;
   else if (z.value == "충청남도") var giyek = sigungu_p;
   else if (z.value == "충청북도") var giyek = sigungu_q;

   target.options.length = 0;

   for (x in giyek) {
      var opt = document.createElement("option");
      opt.value = giyek[x];
      opt.innerHTML = giyek[x];
      target.appendChild(opt);
   }
}

// 매칭 조건 검색
function matching_search(){
	var hobbys = new Array();
	$('.m_hobby:checked').each(function(i){
		hobbys.push($(this).val());
	});
	
	$.ajax({
		url : './matching_search.nf',
		type : 'POST',
		data : {
			'sido' : $('#sido').val(),
			'sigungu' : $('#sigungu').val(),
			'm_hobby' : hobbys,
			'm_age' : $('#m_age').val(),
			'm_gender' : $('#m_gender:checked').val()
		},
		traditional : true,
		dataType : 'json',
		cache : false,
		success : function(rdata) {
			$('#m_f_ul').empty();
			var output = '';
			$(rdata).each(function(index, item){
				var match_request = "match_request('" + item.id + "')";
				
				if(item.id != '${sessionScope.id}') {
					output = '<li><div class="m_f_p_dd"><div><img class="m_f_p" src="./resources/upload/profileimg' + item.prof_img_file + '">'
						   + '<div class="m_f_d"><a href="./timeline.nf?id=' + item.id + '"><strong>' + item.name + '</strong></a>'
						   + '<div class="m_f_d_d">' + item.birth + '</div><div class="m_f_d_d">' + item.sido + '&nbsp;' + item.sigungu + '</div>'
						   + '<div class="m_f_d_d">' + item.m_hobby + '</div></div></div>';
						output += '<div class="m_f_d_b"><button type="submit" class="btn btn-small';
						if(item.id == item.id2) {
							output += ' btn-info disabled"><strong><i class="icon-user icon-white"></i> 매칭 친구</strong></button></div>';
						} else if(item.id == item.accept_id) {
							output += ' btn-primary disabled"><strong>･･･ 매칭 수락 대기중</strong></button></div>';
						} else {
							output += ' fr_req_btn" onclick="' + match_request + '"><strong><i class="icon-plus-sign"></i> 매칭 요청</strong></button></div>';
						}
					output += '</li>';
					$('#m_f_ul').append(output);
				}
			});
		},
		error : function() {
			alert('error');
		}
	});
}

// 매칭 친구 요청
function match_request(accept_id){
  $.ajax({
	  url : './matching_request.nf',
	  data : {
		  'a_flag' : 2,
		  'request_id' : '${sessionScope.id}',
		  'accept_id' : accept_id,
		  'm_friend' : 2
	  },
	  dataType : 'json',
	  type : 'POST',
	  cache : false
  }); // ajax end
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
    <h4 id="m_c_t2">지역, 연령, 성별, 관심사가 맞는 친구를 찾아보세요!</h4>
    <div id="condition_menu">
   	
   	<div class="m_d_c" id="m_r_d">
      <strong>지역</strong>
      <br>
      <%@include file="/jsp/include/sido.jsp" %>
      <select id="sido" class="span3" name="sido" onchange="si(this)">
        <option selected value="0">시/도를 선택하세요.</option>
        <c:forEach var="sido" items="${sido }">
          <option value="${sido }">${sido }</option>
        </c:forEach>
      </select>&nbsp;&nbsp;
 
      <select id="sigungu" name="sigungu" class="span3">
        <option selected value="0">시/군/구를 선택하세요.</option>
      </select>
	</div>
    
    <div class="m_d_c" id="m_a_d">
	  <strong>연령</strong><br>
	  <select id="m_age" name="m_age">
	    <option selected value="0">==연령 선택==</option>
	 	<option value="전 연령">전 연령</option>
	    <option value="10대">10대</option>
	    <option value="20대">20대</option>
	    <option value="30대">30대</option>
	    <option value="40대">40대</option>
	    <option value="50대">50대</option>
	    <option value="60대">60대</option>
	    <option value="70대">70대</option>
	    <option value="80대">80대</option>
	    <option value="90대">90대</option>
	  </select>
    </div>
    
    <div id="m_g_d">
	  <strong>성별</strong><br> 
	  <label class="radio inline">
	    <input type="radio" id="m_gender" name="m_gender" value="남성">남성
	  </label>
	  <label class="radio inline">
	    <input type="radio" id="m_gender" name="m_gender" value="여성">여성
	  </label>
	  <label class="radio inline">
	    <input type="radio" id="m_gender" name="m_gender" value="모두">모두
	  </label>
    </div>
    
    <div class="m_d_c" id="m_h_d">
	  <strong>관심사</strong><br>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="스포츠">스포츠
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="영화">영화
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="요리">요리
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="뮤지컬">뮤지컬
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="음악">음악
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="여행">여행
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="뷰티">뷰티
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="게임">게임
	  </label>
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="독서">독서
	  </label>  
	  <label class="checkbox inline">
	    <input class="m_hobby" type="checkbox" name="m_hobby" value="자기계발">자기계발
	  </label>  
    
      <div id="m_o_b">
        <button type="button" id="m_s_btn" class="btn btn-small" onclick="matching_search()"><strong>매칭</strong></button>
      </div>
    </div>
    
    </div>
        
    <div id="m_f_list">
    <h4 class="m_c_t3">지금 바로 매칭 요청을 보내세요!</h4>
      <ul id="m_f_ul">
        <c:forEach var="sm" items="${m_list }">
          <c:if test="${sm.id != sessionScope.id }"> <%-- 자기 자신은 나타나지 않음 --%>
          <li>
            <div class="m_f_p_dd">
              <div>
	            <img class="m_f_p" src="./resources/upload/profileimg${sm.prof_img_file }">
	            <div class="m_f_d">
	              <a href="./timeline.nf?id=${sm.id }"><strong>${sm.name }</strong></a>
	              <div class="m_f_d_d">${sm.birth }</div>
	              <div class="m_f_d_d">${sm.sido }&nbsp;${sm.sigungu }</div>
	              <div class="m_f_d_d">${sm.m_hobby }</div>
	            </div>
	          </div>
	          
			  <div class="m_f_d_b">
				<c:choose>
				  <c:when test="${sm.id == sm.id2 }">
				    <button type="button" class="btn btn-small btn-info disabled"><strong><i class="icon-user icon-white"></i> 매칭 친구</strong></button>
				  </c:when>
				  <c:when test="${sm.id == sm.accept_id }">
				    <button type="button" class="btn btn-small btn-primary disabled"><strong>･･･ 매칭 수락 대기중</strong></button>
				  </c:when>
				  <c:otherwise>  
				    <button type="submit" class="btn btn-small fr_req_btn" onclick="match_request('${sm.id}')"><strong><i class="icon-plus-sign"></i> 매칭 요청</strong></button>
				  </c:otherwise>
				</c:choose>
			  </div>
            </div>
          </li>
          </c:if>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>
<!-- 본문 끝 -->
</body>
</html>