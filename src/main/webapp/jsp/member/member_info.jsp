<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>회원정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script src="./resources/js/jquery-3.0.0.js"></script>
<script>
function si(z) {
   //강원도
   var sigungu_a = [ "강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "원주시",
         "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군" ];
   //경기도
   var sigungu_b = [ "가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시",
         "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시 분당구",
         "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구",
         "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구",
         "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구",
         "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시",
         "포천시", "하남시", "화성시" ];
   //경상북도
   var sigungu_c = [ "거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군",
         "양산시", "의령군", "진주시", "창녕군", "창원시 마산합포구", "창원시마산회원구", "창원시 성산구",
         "창원시 의창구", "창원시 진해구", "통영시", "하동군", "함안군", "함양군", "합천군", "" ];

   //경상남도
   var sigungu_d = [ "경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군",
         "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군",
         "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구" ];

   //광주광역시
   var sigungu_e = [ "광산구", "남구", "동구", "북구", "서구" ];

   //대구광역시
   var sigungu_f = [ "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구" ];

   //대전광역시
   var sigungu_g = [ "대덕구", "동구", "서구", "유성구", "중구" ];

   //부산광역시
   var sigungu_h = [ "강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
         "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구" ];

   //서울특별시
   var sigungu_i = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구",
         "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구",
         "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];
   //세종특별자치시 
   var sigungu_j = [ "시/군/구 없음" ];

   //울산광역시 
   var sigungu_k = [ "남구", "동구", "북구", "울주군", "중구" ];

   //인천광역시 
   var sigungu_l = [ "강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "웅진구",
         "중구" ];

   //전라남도
   var sigungu_n = [ "강진구", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시",
         "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군",
         "장흥군", "진도군", "함평군", "해남군", "화순군" ];

   //전라북도
   var sigungu_m = [ "고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군",
         "익산시", "임실군", "장수군", "전주시 덕진구", "전주시 완산구", "정읍시", "진안군" ];

   //제주특별자치시
   var sigungu_o = [ "서귀포시", "제주시" ];

   //충청남도
   var sigungu_p = [ "계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시",
         "서천군", "아산시", "예산군", "천안시 동남구", "천안시 서북구", "청양군", "태안군", "홍성군" ];

   //충청북도
   var sigungu_q = [ "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군",
         "진천군", "아산시", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시" ];

   var target = document.getElementById("sigungu");

   if (z.value == "강원도")   var giyek = sigungu_a;
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

$(function(){
	// 관심사 선택된 것이 체크될 수 있도록	
	var interest = '${m.m_hobby}'.split(',');
	for(var x of interest) {
		$('.m_hobby').each(function(e){
		    if($(this).val() == x){
		        $(this).attr('checked', 'checked');
		    }
		});
	}
	
	$('.gender').each(function(e){
		if($(this).val() == '${m.gender}'){
			$(this).attr('checked', 'checked');
		}
	});

	if('${m.sido}' != '') {
		$('#sido').val('${m.sido}');
		var sido = document.createElement('option');
		sido.value = '${m.sido}';
		si(sido);
		$('#sigungu').val('${m.sigungu}');
		
		$('#m_gender').val('${m.m_gender}');
		
		$('#m_age').val('${m.m_age}');
		
		$('.m_flag').each(function(e){
			if($(this).val() == '${m.m_flag}')
				$(this).attr('checked', 'checked');
		});
	}
	
});

// 프로필 사진 or 배경 사진 바로 바뀌어 보이게
function changeImg(input, number) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e){
        	if(number == 1) {
	            $('#prof_img')
	                .attr('src', e.target.result)
	                .width(180)
	                .height(180);
        	} else if(number == 2) {
        		$('#bg_img')
                .attr('src', e.target.result)
                .width(180)
                .height(180);
        	}
        };

        reader.readAsDataURL(input.files[0]);
    }
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
/*     width: 10px; */
/*     height: 15px; */
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
  /* 알림 드롭다운 */
  body{
    background: #e9ebee;
    padding-top: 60px;
    padding-bottom: 40px;
  }
  
  ul{
    list-style: none;
  }
  
  #c_1{
    display: none;
    z-index: 10005;
    background: red;
    position: absolute;
    top: 0px;
    right: 5px;
    width: 10px;
    height: 15px;
    line-height: 16px;
  }
  #c_1 span{
    color: #fff;
  }
  
  #d_t_a {
    position: relative;
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
  
  #containerWrap{
    width: 940px;
    margin: 0 auto;
  }
  #containerinner{
	background: #fff;
    border: 1px solid #dddfe2;
    padding: 20px;
  }
  
  .info_t{
  	padding-left: 16px;
    border-bottom: 1px solid #dddfe2;
    font-size: 22px;
  }
  
  #prof_img{
  	width: 180px;
  	height: 180px;
  }
  #bg_img{
  	width: 180px;
  	height: 180px;
  }
  
  #p_i_d{
  	display: inline-block;
  	margin-bottom: 10px;
  }
  #b_i_d{
  	display: inline-block;
  	margin-bottom: 10px;
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

<div id="containerWrap">
  <h3 class="info_t">회원정보 관리</h3>
  <div id="containerinner">
	
	
	<form action="./member_info_ok.nf" method="post" enctype="multipart/form-data">
		<strong>이름 </strong><input type="text" name="name" value="${m.name }"><br><br>
		<strong>휴대폰번호 </strong><input type="text" name="phone" value="${m.phone }"><br><br>
		<strong>생년월일 </strong><input type="text" name="phone" value="${m.birth }"><br><br>
		<strong>성별</strong><br>
		<label class="radio inline">
	      <input type="radio" class="gender" name="gender" value="남자">남자
	    </label>
	    <label class="radio inline">
	      <input type="radio" class="gender" name="gender" value="여자">여자
	    </label>
	    <br><br>
		
		<div id="p_i_d">	  
		  <strong>프로필사진</strong><br>
		  <img id="prof_img" src="./resources/upload/profileimg${m.prof_img_file }"><br>
		  <input type="file" name="prof_img" onchange="changeImg(this, 1)"><br>
		</div>
		<div id="b_i_d">
		  <strong>배경사진</strong><br>
		  <img id="bg_img" src="./resources/upload/backgroundimg${m.bg_img_file }"><br>
	  	  <input type="file" name="bg_img" onchange="changeImg(this, 2)"><br>
		</div>
		<br><br>
		
		<input type="hidden" name="birth" value="${m.birth }"> <!-- 생년월일 히든값으로 넘김 -->
		 
		<strong>지역</strong><br>
		  <%@include file="/jsp/include/sido.jsp" %>
		  시/도 <select class="span3" id="sido" name="sido" onchange="si(this)">
		    <option selected value="0">시/도를 선택하세요.</option>
		    <c:forEach var="sido" items="${sido2 }">
		      <option value="${sido }">${sido }</option>
		    </c:forEach>
		  </select>
		  
		 시/군/구 <select class="span3" id="sigungu" name="sigungu" class="span2">
		    <option selected value="0">시/군/구를 선택하세요.</option>
		  </select>
		  <br>
		  
		  <br>
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
		  <br><br>
		  
		  
		  <strong>자기소개</strong><br>
		  <textarea name="m_pr" cols="40" rows="10" style="width: 670px;">${m.m_pr }</textarea><br>
		  
		  <strong>매칭허용여부</strong><br/>
		  <label class="radio inline">
		    <input class="m_flag" type="radio" name="m_flag" value="1">허용
		  </label>
		  
		  <label class="radio inline">
		    <input class="m_flag" type="radio" name="m_flag" value="2">허용 안함
		  </label>
		  
		  <br><br><br><br><br>
		  <input class="btn-success span3" type="submit" value="완료" style="margin-left: 340px">
	</form>
  </div>
</div>
</body>
</html>