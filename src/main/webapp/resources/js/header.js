
  $(function(){
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
		  		 $('#c_1 span').text(rdata);
		  	 }
		  });
	  }, 2000);
  });
  
  //알림 드롭 다운 시 목록 조회
  function allim_dropdown(event){
	  event.preventDefault();

	  $('#allim_dropdown').empty();
	  $.ajax({
		 url : './allim_dropdown_list.nf',
		 data : {
			 'id' : '${sessionScope.id}'
		 },
		 dataType : 'json',
		 type : 'POST',
		 cache : false,
		 success : function(rdata) {
			 $(rdata).each(function(index, item){
				 
				 // a_flag에 따라 주소값 달라져야함
				 var goPost = 'goPost('+ item.a_flag + ', ' + item.a_no + ')';
				 
				 var output = '';
				 // 1번 친구요청, 2번 댓글, 3번 좋아요 구분
				 if(item.read_check == '1') {
				 	output = '<li style="background: #eeeeee"><a href="#" onclick="' + goPost + '"><strong>' + item.name + '</strong>님이 친구 요청을 보냈습니다.' + '</a></li>';
				 } else {
					output = '<li><a href="#" onclick="' + goPost + '"><strong>' + item.name + '</strong>님이 친구 요청을 보냈습니다.' + '</a></li>';
				 }
				 
				 $('#allim_dropdown').prepend(output); // 거꾸로 붙임
			 });
			 			 
			 var remain_li = '<li class="divider"></li><li><a href="./allim_list.nf">모두 보기</a></li>';
			 $('#allim_dropdown').append(remain_li);
		 },
		 error : function(data){
			 alert('error');
		 }
	  }); // ajax end
  }
  
  function goPost(a_flag, a_no) {
	  event.preventDefault();
// 	  alert('a_flag:' + a_flag + 'a_no:' + a_no);

	  var f = document.createElement('form');
	  f.name = 'goPostForm';
	  
	  // 1 : 타임라인
	  if(a_flag == '1') {
	  	f.action = './timeline.nf';
	  }
	  // 2: board
	  
	  // 3. 댓글
	  
	  f.method = 'post';
	  f.appendChild(addData(a_no));
	  
	  document.body.appendChild(f);
	  f.submit();
  }
  
  function addData(a_no) {
	  var elem = document.createElement('input');
	  
	  elem.setAttribute('type', 'hidden');
	  elem.setAttribute('name', 'a_no');
	  elem.setAttribute('value', a_no);
	  
	  return elem;
  }
