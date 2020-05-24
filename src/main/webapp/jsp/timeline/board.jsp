<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>${m.name }</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.css" media="screen">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script src="./resources/js/jquery-3.0.0.js"></script>
<script>
$(function() {
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
	  
	//친구 접속 확인
		 setInterval(function(){
			$.ajax({
				url : 'friend_on_off',
				data : {'id' : '${sessionScope.id}'},
				dataType : 'json',
				type : 'POST',
				cache : false,
				success : function(rdata){
					if(rdata != ""){
						var str = "";
						
						$(rdata).each(function(index, item){						
							str += "<div class='friend_one'>"
								+	"<a href=timeline.nf?id="+item.id+">"
								+		"<span><img class='img-circle' alt='프로필사진' src=resources/upload/profileimg"+item.prof_img_file+"></span>"
								+		"<span>"+item.name+"</span>"
								if(item.on_off == 2){
								str +=	"<span class='On_Off' style='color:red;'>●</span>"
								}else{
								str +=	"<span class='On_Off' style='color:gray;'>●</span>"
								}
							str +="</a>"
								+ "</div>"
						});	//end each
					}	//end if
					$(".friend_one").remove();
					$("#friend_all").append(str);
				}	// end success
			});//end ajax
		}, 2000);  
	
	//화면 숨기기
	funcThisSize();
	
	//슬라이드
	var pos = 0;
	$("#news_all").on("click", "#next", function(){
		slideRight(this);
	});

	$("#news_all").on("click", "#previous", function(){
		slideLeft(this);
	});
	//슬라이드 끝
	
	//이미지 없을 경우 처리
	$(".slider").each
	
	$("#news_all").empty();
	
	
	selectData();
	
	function selectData(){
		$.ajax({
			url : 'boardOne',
			data : {"id" : '${id}', "board_no" : '${board_no}'}, 
			dataType : 'json',
			type	: "POST",
			cache	: false,
			success : function(rdata){
				var str = "";
				// 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
				if(rdata != ""){
					//반복
					$(rdata).each(
					function(index, item){

						var status = item.like_status

						 if(status == 0) {
							var result = 'style="width:33%; height:40px; background:white; border:none;"';
						 }else{
							var result = "style='width:33%; height:40px; background:white; border:none; color:green;'";
						 }
						 
						console.log(this);
						var year  = item.reg_date.substring(0,4);
						var month = item.reg_date.substring(5,7);
						var day	  = item.reg_date.substring(8,10);
						
						str	+=	"<div class='news_one'>"
						if(item.share_id == null){	
							str	+=	 "<a href=timeline.nf?id="+item.id+"><span class='label label-info' style='font-size: 20px; padding: 5px;' >"+item.name+"</span></a>님이 게시글을 만들었습니다."				
						}else{
							str	+=	 "<a href=timeline.nf?id="+item.id+"><span class='label label-info' style='font-size: 20px; padding: 5px;' >"+item.name+"</span></a>님이 게시글을 공유했습니다."	
						}
						
						if(item.id.trim() == '${sessionScope.id}'){
							str +=   "<a href='deleteboard.nf?id="+item.id+"&board_no="+item.board_no+"' style='float:right;'><i class='icon-trash'></i></a>"
						}
						
						str	+=	 "<div class='news_info' id='"+item.id+item.board_no+"'>" 			
						str	+=		"<div class='b_info' style='text-align: right; padding:3px;'><span class='label'>" + year + "년 "+month+"월 "+day+"일</span></div>"
			
						if(item.content == null){
							item.content="";
						str	+=		"<div class='b_content'></div>"	
						}else{
						str	+=		"<div class='b_content'><pre>" + item.content + "</pre></div>"	
						}		

						var file = "";				
						filePath = item.board_file;
						if (filePath != null){
							filePathArr = filePath.split("|");
							for (var i = 0 ; i < filePathArr.length-1 ; i++){						//toLowerCase() 대소문자 무시
								extn = filePathArr[i].substring(filePathArr[i].lastIndexOf('.')+1).toLowerCase();
								// 사진일 때
								if( extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg"){
									file += "<li><img class='img-rounded' width='100%' height='auto' "
										 + "src=resources/upload/file"+filePathArr[i]+"></li>"
								}//style='width:940px; height:636px;'
								// 영상일 때	poster -> 썸내일
								else if( extn =='mpg' || extn =='avi' || extn == 'mp4' || extn == 'flv' || extn == 'wmv' || extn == 'mov'){
									file += "<li><video controls width='560px' autoplay>"
										 + "<source src=resources/upload/file"+filePathArr[i]+">"
										 + "</video></li>"
								}
								// 오디오일 때
								else if( extn == 'mp3' || extn == 'wav' ){
									file += "<li><audio controls style='width: 100%;height: 50%;' preload='auto' src=resources/upload/file"+filePathArr[i]+" /></li>"
								}
							}	
							
							str	+=	"<div class='b_file wrapper'>"
								+			"<div class='slider-wrap'>"
								+				"<ul class='slider'>"
								+				file	
								+				"</ul>"	//end slider	
								+			"</div>"	//end slider-wrap
								
								//추가
								if(filePathArr.length > 2){
							str	+=		"<div class='slider-btns' id='next'><span class='fa fa-arrow-right'>▶</sapn></div>"
								+		"<div class='slider-btns' id='previous'><span class='fa fa-arrow-left'>◀</sapn></div>"
								}
								
							str	+=		"<div class='counter'></div>"
								+		"<div class='pagination-wrap'>"
								+	        "<ul>"
								+	        "</ul>"
								+	    "</div>"	//end pagination
								+	"</div>"	//end b_file	
						}
						
						if(item.share_id != null){
							str	+=	"<div class='b_share' style='margin:10px 0 10px 0;'>"
								+	"<a href=timeline.nf?id="+item.share_id+"><span class='label label-info' style='font-size: 10px; padding: 5px;' >"+item.share_name+"</span></a>"
								+	"<pre style='border: none; background: white;'>" + item.share_content + "</pre></div>"										
						}
						
						str	+=	"<div class='like'><img src='resources/images/like_up.png' style='width: 20px;'><span class='likecount'>"+item.like_count+"</span></div>" 
							+		"<div class='b_button'>"
						str	+=	 "<hr>"	
							+			"<span><input "+result+" type='button' name='likebutton' value='좋아요'"
							+			"onclick=likebtn('"+item.id+"',"+item.board_no+",this);></span>"
							+ 			"<span><input style='width:33%; height:40px; background:white; border:none;' type='button' name='showreply' value='댓글보기' "
							+			"onclick=replyshow('" + item.id + "'," + item.board_no + ",1,this)>"
							+			"</span>"
							+			"<span><input style='width:33%; height:40px; background:white; border:none;' type='button' name='sharebutton' value='공유하기'"
							+			"onclick=shareboard('" + item.id + "'," + item.board_no + ",this); ></span>"					
							+	"<div class='share_layer'></div>"
							+	 "<hr>"
							+		"</div>" //end b_buttion
							+ 	 "</div>"	//end news_info					
							+	"</div>"; //end news_one
					}); //each end
					$('#news_all').append(str);	
			 			    
				}	//if end
				else{
					str = "<h3>게시물이 존재하지 않습니다.</h3>"
				}
			}//success end		
		});//ajax end		
	};//selectData end
	
});//function end

//댓글 보이기
function replyshow(id, board_no, r_page, t){	
	var info = $(t).parent().parent();
	var info2 = document.getElementById(board_no+id);
	var count = 0;
	//존재하면 실행
	if( info2 == null ){
	$.ajax({
		url : "replyshow",
		data : {"id" : id, "board_no": board_no, "r_page" : r_page},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){	
				var str = "";
				var str2 = "";
				str +="<div class='reply_form' id='"+board_no+id+"' style='margin-top:20px; margin-bottom:20px;' >"
					+ "<input type='text' name='reply_write' class='reply_write' style='margin-bottom:0px; width:60%;'>"
					+ "<input type='button' class='btn btn-inverse' value='답글쓰기' style='float:right; width:33%;' value='답글쓰기' onclick=replyInsert('"+id+"',"+board_no+",this);>"
				str += "<div class='reply_all'>"
				if(rdata != ""){	
					//반복		
					$(rdata).each(function(index, item){
						console.log(this);				
						var r_r_page = 1;
						str +=	"<div class='reply_one'>"
						str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
						str +=	   "<div><input type='button' class='btn btn-link' onclick=re_replyshow('re_replyshow','"+id+"',"+board_no+","+item.re_ref+","+r_r_page+",this); value='답글달기'></div>"
						str +=   "</div>"	//end reply_one	
						count++;
					}); //each end	
				}	//if end
				else {
				}// else end
				str += "</div>"		//end 댓글모음
				if(count == 5){
					str +="<div class='replyplus' style='text-align:right;'>"
					str += "<input type='button' class='btn-link' name='replyShowPlus' value='댓글더보기' "
					str += "onclick=replyShowPlus('" + "replyShowPlus" + "','"+ id+"',"+ board_no +","+ (r_page+1) +",this)>"
					str += "</div>"	//end replyplus	
				}
				str += "</div>" //end reply_form
				$(info).append(str);
		}//success end		
	});//ajax end
	} else info2.remove();

};//replyshow end

//댓글 플러스
function replyShowPlus(url, id, board_no, r_page, t){
	$.ajax({
		url : url,
		data : {"id" : id, "board_no": board_no, "r_page": r_page},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){			
			var str = "";
			var str2 = "";
			var reply_all = $(t).parent().parent().find($('.reply_all'));
			var reply_form = $(t).parent().parent();
			var replyplus = $(t).parent().parent().find($('.replyplus'))
			// 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
			if(rdata != ""){
				//반복
				$(rdata).each(function(index, item){
					console.log(this);	
					var r_r_page = 1;
					str +=	"<div class='reply_one' >"
					str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
					str +=	   "<div><input type='button' class='btn btn-link' onclick=re_replyshow('re_replyshow','"+id+"',"+board_no+","+item.re_ref+","+r_r_page+",this); value='답글달기'></div>"
					str +=   "</div>"	//end reply_one	
				}); //each end
				
				str2 +="<div class='replyplus' style='text-align:right;'>"
				str2 += "<input type='button' class='btn-link' name='replyShowPlus' value='댓글더보기' "
				str2 += "onclick=replyShowPlus('" + "replyShowPlus" + "','"+ id+"',"+ board_no +","+ (r_page+1) +",this)>"
				str2 += "</div>"	//end replyplus	
				
				$(reply_all).append(str);
				$(reply_form).append(str2);
				$(replyplus).remove();
			}	//if end
			else {
				$(replyplus).remove();
				alert("더 불러올 데이터가 없습니다.");		
			}// elsd end
		}//success end		
	});//ajax end		
};//replyShowPlus

//submit 게시글 등록
function boardInsert(event){
	event.preventDefault();
	var formData = new FormData($("#insert_board")[0]);	//uploadForm
	$.ajax({
		type : 'post',
		url : 'boardInsert',	//fileUpload
		dataType : 'json',
		data : formData,		
		processData : false,
		contentType : false,
		success : function(rdata){
// 			alert("성공");
			location.href = 'main.nf';
		},	//success end
		error : function(error){
			alert("실패");
			console.log(error);
			console.log(error.status);
		}//end error
	});//end ajsx
}; //end submit

//댓글 쓰기
function replyInsert(id, board_no, t){
	var content = $(t).prev().val();
	$.ajax({
		url : 'replyInsert',
		data :  {"id" : id, "board_no": board_no, "content" : content,
					"a_flag" : 4},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){
// 			alert("성공");
			var str = "";
			if(rdata != ""){	
				$(rdata).each(function(index, item){
					console.log(this);					
					str +=	"<div class='reply_one' >"
					str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
					str +=   "</div>" 							
				}); //each end		
			}	//if end	
			var reply_all = $(t).parent().find($('.reply_all'));
			if( $(reply_all).children().length < 5)
				$(reply_all).append(str);
			$(t).prev().val("").focus();
		}//success end	
	
	});	//ajax end
};

//답글 보이기
function re_replyshow(url, id, board_no, re_ref,r_r_page, t ){
	var reply_one = $(t).parent().parent();
	
	$.ajax({
		url : url,
		data : {"id" : id, "board_no": board_no, "re_ref" : re_ref, "r_r_page" : r_r_page},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){
			var str = "";
			e = $(t).parent().find('.re_reply_one').length;
			var re_reply = reply_one.find('.re_reply').length ;
			if(e == 0){
				if(rdata != ""){	
					$(rdata).each(function(index, item){	
					str +=	"<div class='re_reply_one' style='margin-left: 20px; margin-bottom:10px; margin-top:10px;'>"
					str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
					str +=  "</div>"	//end re_reply_one		
					}); //each end	
					
				}
				var re_replyPlus = $(t).parent().find($('.re_replyPlus')).length;
				if( $(t).parent().parent().find($('.re_replyPlus')).length == 0 ){
					if( re_reply  == 0 ){
						var str2 = "";
						str +="<div class='re_replyplus' style='text-align:left;'>"
						str += "<input type='button' class='btn-link' name='re_replyShowPlus' value='더보기' "
						str += "onclick=re_replyshowPlus('re_replyshow','"+ id+"',"+ board_no +","+re_ref+","+(r_r_page+1)+",this)>"
						str += "</div>"	//end replyplus	
					}
				}else{
					$(t).parent().remove();
				}
			}
			if( re_reply == 0 ){	
				var str3 = "";		
				str3 +=	"<div class='re_reply' style='margin-left:20px;'>"
				str3 +=     "<input type='text' name='re_reply_write' style='margin-bottom:0px; width:35%;'>"
				str3 +=	   "<input type='button' value='답글쓰기' class='btn btn-inverse' style='margin-left: 30px;'  onclick=re_replyInsert('"+id+"',"+board_no+","+re_ref+",this);>"
				str3 +=  "</div>"
				reply_one.append(str3);
			}else{
			}		
			$(t).parent().append(str);
		}//end success
	});	//end ajax
};	//end re_replyshow

//대 댓글 보기 플러스
function re_replyshowPlus(url, id, board_no, re_ref, r_r_page, t){
	$.ajax({
		url : url,
		data : {"id" : id, "board_no": board_no, "re_ref" : re_ref, "r_r_page" : r_r_page},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){
			var str ="";	
			if(rdata != ""){	
				$(rdata).each(function(index, item){	
					str +=	"<div class='re_reply_one' style='margin-left: 20px; margin-bottom:10px; margin-top:10px;'>"
					str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
					str +=  "</div>"	//end re_reply_one		
				}); //each end	
				str +="<div class='re_replyplus' style='text-align:left;'>"
				str += "<input type='button' class='btn-link' name='re_replyShowPlus' value='더보기' "
				str += "onclick=re_replyshowPlus('re_replyshow','"+ id+"',"+ board_no +","+re_ref+","+(r_r_page+1)+",this)>"
				str += "</div>"	//end replyplus	
			}
			$(t).parent().parent().append(str);
			$(t).parent().remove();
		}//end success	
	});
};

//답글쓰기
function re_replyInsert(id, board_no, re_ref, t){
	var content = $(t).prev().val();
	$.ajax({
		url : 're_replyInsert',
		data :  {"id" : id, "board_no": board_no, "content" : content, "re_ref" : re_ref},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(rdata){
// 			alert("성공");
			var str = "";
			if(rdata != ""){	
				$(rdata).each(function(index, item){
					console.log(this);
					var cnt =  item.re_lev;
					str +=	"<div class='reply_one' style='margin-left: 20px; margin-bottom:10px; margin-top:10px;'>"
					str +=     "<div><span><a href='timeline.nf?id="+item.reply_id+"'><img src='resources/upload/profileimg"+item.prof_img_file+"' class='img-circle'></a></span><span class='label label-info'><a href='timeline.nf?id="+item.reply_id+"'>" + item.name +"</a></span><span> "+ item.content +"</span></div>"
					str +=  "</div>" 							
				}); //each end								
			}	//if end		
			var re_replyplus = $(t).parent().parent().find('.re_replyplus');
			var reply_one =  $(t).parent().parent();
			if( $(reply_one).children().length < 5)
				$(re_replyplus).before(str);
			$(t).prev().val("").focus();
		}//success end	
	
	});	//ajax end
};

//좋아요 버튼
function likebtn(id, board_no, t){
	$.ajax({
		url 	: 'likeStatus',
		data 	: {"id" : id , "board_no" : board_no},
		type	: "POST",
		success : function(status){
			text = $(t).parent().parent().parent().find(".likecount");
			if(status == 1){
				text.text(Number(text.text())+1);
				$(t).css("color","#239738")
					.css("font-weight", "bolder")
			}else{
				text.text(Number(text.text())-1);
				$(t).css("color", "initial")
				.css("font-weight", "initial")
			}
		}	//end success
	});//end ajax
}

//공유하기
function shareboard(id, board_no, t){
	if('${sessionScope.id}'==id){
		alert("자신의 글은 공유할수 없습니다.");
		return false;
	} 
	
	$.ajax({
		url		: "shareboard",
		data	: {"id" : id, "board_no" : board_no},
		dataType : 'json',
		type	: "POST",
		cache	: false,	
		success : function(bdata){
		str = ""	
			if(bdata != ""){
				$(bdata).each(function(index, item){
		if(item.content == null){
			item.content="";
		}	
		str +=			"<div class='pop-layer'>"
			+			  "<div class='pop-conts'>"
			+				"<div><h5>내 타임 라인에 공유</h5></div>"	
			+				"<div class='b_content'><pre>" + item.content + "</pre></div>"
		var file = "";
		filePath = item.board_file;
		if (filePath != null){
			filePathArr = filePath.split("|");
			extn = filePathArr[0].substring(filePathArr[0].lastIndexOf('.')+1).toLowerCase();
			if( extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg"){
				file += "<img class='img-rounded' width='400px' height='300px' "
					 + "src=resources/upload/file"+filePathArr[0]+">"
			}
			else if( extn =='mpg' || extn =='avi' || extn == 'mp4' || extn == 'flv' || extn == 'wmv' || extn == 'mov'){
				file += "<video controls width='400px' autoplay>"
					 + "<source src=resources/upload/file"+filePathArr[0]+">"
					 + "</video>"
			}
			// 오디오일 때
			else if( extn == 'mp3' || extn == 'wav' ){
				file += "<audio controls style='width: 100%; height: 50%;' preload='auto' src=resources/upload/file"+filePathArr[0]+" />"
			}
		}
		str +=		"<div class='b_file' style='width:400px;'>"+file+"</div>"
		+			"<div class='addtext'><textarea name='content' id='content' style='width:97%; resize:none; margin-top:20px;'></textarea></div>"
		+				"<div class='b_button'>"
		+					"<input type='button' class='btn' value='공유하기' style='width:50%' onclick=insertshare('"+id+"',"+board_no+",this);>"
		+					"<input type='button' class='btn' value='Close' style='width:50%' onclick='closeshare(this);'>"
		+				"</div>" //end btn
		+			  "</div>" //end pop-conts
		+			 "</div>" //end pop-layer
				}); //each end	
			}
		
			share_layer = $(t).parent().parent().parent().find($(".share_layer"));
			
			share_layer.append(str);
			
			share_layer.css({
				 "top": (($(window).height()-share_layer.outerHeight())/2+$(window).scrollTop())+"px",
				 "left": (($(window).width()-share_layer.outerWidth())/2+$(window).scrollLeft())+"px",
				 "background-color" : "white",
				 "z-index" : "3"
				});
							
			 $("#popup_mask").css("display","block"); //팝업 뒷배경 display block
			 share_layer.css("display","block"); //팝업창 display block
			 
			 $("body").css("overflow","hidden");//body 스크롤바 없애기
		},
		error : function(){
			alert ("에러");
		}
	});
}

//공유하기 닫기
function closeshare(t){
	alert("취소");
	$(t).parent().parent().parent().parent().css("display", "none");
	$(t).parent().parent().parent().remove();
	$("#popup_mask").css("display","none");
	$("body").css("overflow","scroll");
}

//공유하기 추가
function insertshare(id, board_no, t){
	content = $(t).parent().parent().find("#content").val();
	$.ajax({
		url		: "insertshare",
		data	: {"id" : id, "board_no" : board_no, "content" : content},
		dataType : 'json',
		type	: "POST",
		cache	: false,
		success : function(){
			location.href = 'main.nf';
		}
	})
}


/***********
 SLIDE LEFT
************/
function slideLeft(t){
	var pos = $(t).parent().parent().find(".slider").css("left");
	pos = pos.split('px')[0];
	pos = -pos/600;
	
	var totalSlides = $(t).parent().parent().find(".slider-wrap ul li").length
	var sliderWidth = $(t).parent().parent().find('.slider-wrap').width();

    pos--;
    if(pos < 0){ 
    	$(t).parent().parent().find('.slider-wrap ul.slider').css('left', -(sliderWidth*(totalSlides-1)));
    }else{
    	$(t).parent().parent().find('.slider-wrap ul.slider').css('left', -(sliderWidth*pos));    
    }
}


/************
 SLIDE RIGHT
*************/
function slideRight(t){
	var pos = $(t).parent().parent().find(".slider").css("left");
	pos = pos.split('px')[0];
	pos = -pos/600;
	
	var totalSlides = $(t).parent().parent().find(".slider-wrap ul li").length
	var sliderWidth = $(t).parent().parent().find('.slider-wrap').width();

    pos++;
    if(pos == totalSlides){ pos = 0; }
    $(t).parent().parent().find('.slider-wrap ul.slider').css('left', -(sliderWidth*pos)); 

}

//비디오 자동 재생

function checkScroll() {
	
	var videos = document.getElementsByTagName("video");
	var fraction = 0.8;
	
    for(var i = 0; i < videos.length; i++) {

        var video = videos[i];
        //.offset()은 선택한 요소의 좌표를 가져오거나 특정 좌표로 이동시킵니다.
        var x = video.offsetLeft;
        var y = video.offsetTop;
        var w = video.offsetWidth;
        var h = video.offsetHeight;
        var 
        	r = x + w, //right
            b = y + h, //bottom
            visibleX, visibleY, visible;

            visibleX = Math.max(0, Math.min(w, window.pageXOffset + window.innerWidth - x, r - window.pageXOffset));
            visibleY = Math.max(0, Math.min(h, window.pageYOffset + window.innerHeight - y, b - window.pageYOffset));
	
            visible = visibleX * visibleY / (w * h);
            
            if (visible < 0.68) {
            	////오류 https://developers.google.com/web/updates/2017/06/play-request-was-interrupted
            	video.play(); 
            //	alert(visible);
            	//video.pause(); 
            } else {
            	//video.play();
            	video.pause(); 
            //	alert(visible);
            }
    }

};

//숨기기
function funcThisSize(){
	if(window.innerWidth <= 1050)
		$("#friend_all").css("display", 'none');
	else 
		$("#friend_all").css("display", 'initial');	
	
	if(window.innerWidth <= 1350)
		$("#m").css("display", "none");
	else
		$("#m").css("display", "initial");
	
	$(".share_layer").css({
		 "top": (($(window).height()-$(".share_layer").outerHeight())/2+$(window).scrollTop())+"px",
		 "left": (($(window).width()-$(".share_layer").outerWidth())/2+$(window).scrollLeft())+"px",
		 "background-color" : "white",
		 "z-index" : "3"
	});
}

//이벤트 추가
window.addEventListener('scroll', checkScroll, false);
window.addEventListener('resize', checkScroll, false);
window.addEventListener('resize', funcThisSize, false);

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
  *{margin:0; padding:0; list-style:none;}
  a{text-decoration:none; color:#666;}
  a:hover{color:#1bc1a3;}
  
  body{
    background: #e9ebee;
    padding-bottom: 40px;
  }
    
  #contentWrap{
    width: 100%;
    background: #eeeeee;
  }
  #contentArea{
    margin: 0 auto;
  	width: 600px;
  	padding-top: 60px;
  }
    /* 수정 */
  #insert_board{
  	background: #ffffff;
  	margin-top: 10px;
  }
  #write_box{
  	padding: 20px;
  	border: 1px solid lightgray;
  	}
  .news_one{
  	background: #ffffff;
    padding: 20px;
    margin-top: 10px;
    border: 1px solid lightgray;
  }
  
  #friend_all{
    position: fixed;
    right: 1px;
    height: 100%;
    width: 255px;
    margin-top: 10px;
    padding-top: 40px;
    background: rgb(255, 255, 255);
    border-left: 1px solid #dddfe2;
    text-align: center;
  }
  .friend_one{
  	width: 100%;
  	height: 40px;
  	margin: 10px 0 10px 0;
  } 
  .friend_one:hover{
  	background: #eeeeee;
  } 
  .friend_one span{
  	float: left;
  	width: 33%;
  	line-height: 40px;
  }
  /* 친구 추가 */
  .friend_one img{width: 30px; height: 30px;}
  
  /* 회원 정보 */
 #m{ 
  height: 450px;
  width: 300px;
  position: fixed;
  z-index: 1;
  top: 0;
  margin-top : 50px;
  left: 4vw;
  background-color: #ffffff;
  overflow-x: hidden;
  padding-top: 20px;
  border: 1px solid lightgray;
 }
 
 #m .m_button{
 	text-align: center;
	background: #ffffff;
 	border: none;
 	padding: 0px;
 	height: 70px;
 }
 #m .m_button span{
 	margin: 0px;
 	height: 70px;
 	width: 100px;
 	background: #ffffff; 
 	color: #8d8b8b;	
 	padding: 24px 19px 25px 19px;    
 	line-height: 70px;
 	font-size: larger;
    font-weight: 600;	
 }
 #m .m_button a:hover{
 	text-decoration: none;
 	
 }
 #m .m_button span:hover{
 	text-decoration: none;
 	background: skyblue;
 	color: #ffffff;
 }
 
 #m .m_info{height: 360px;}
 #m .m_info .m_name{
    color: white;
    text-align: center;
    margin-left: 0px;
    margin-top: 20px;
	}
 #m .m_info .m_name a {color: white;}
 #m .m_info .m_name a:hover{text-decoration: none;}
 #m .m_info .m_bg{
 	position: absolute;
    width: 100%;
    top: 0px;
    }
 #m .m_info .m_bg img{
	position: absolute;
    z-index: -1;
    height: 400px;
 }
 
 #m .m_info .m_prof{text-align: center; line-height: 260px;}
 #m .m_info .m_prof img{width: 200px; height: 200px;}
 #all_file .one_file .img-rounded{width: 120px; height: 120px;}
 #all_file .filevalue {font-size: 1vw;}
  
 hr{margin: 10px 0;}
 .uploadfile{display: none;}
 .close{display: none;} 
 .one_file{width:20%; height:148px; float: left; position: relative;}
 .one_file::after{content: ''; dispaly: block; clear: both; }
 .f_name{width: 120px; height: 20px;}
 

  .reply_form img {width: 35px; height: 35px; margin: 10px;}
  .re_reply_one img{ width: 20px; height: 20px;}
  .reply_one a {color: white;}
 
.share_layer{
	top : 0px;
    position: absolute;
	border: 1px solid;
	padding: 20px;
	display: none;
} 
#popup_mask{
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0px;
    left: 0px;
    display: none;
    opacity: 0.8;
    background-color: #a4a4a4;
    z-index: 2;
}

.share_layer img{width: 400px; height: 300px;} 
  
  
/* 슬라이드 */
.wrapper{
    margin:50px auto;
    height:400px;
    position:relative;
    color:#fff;
    text-shadow:rgba(0,0,0,0.1) 2px 2px 0px;    
}

.slider-wrap{
    width:600px;
    height:400px;
    position:relative;
    overflow:hidden;
}

.slider-wrap ul.slider{
    width: max-content;
    height:100%;
    position:absolute;
    top:0;
    left:0; 
    margin-left: 0px;    
}

.slider-wrap ul.slider li{
    float:left;
    position:relative;
    width:600px;
    height:400px;   
}

.slider-wrap ul.slider li > div{
    position:absolute;
    top:20px;
    left:35px;  
}

.slider-wrap ul.slider li > div h3{
    font-size:36px;
    text-transform:uppercase;   
}

.slider-wrap ul.slider li > div span{
    font-family: Neucha, Arial, sans serif;
    font-size:21px;
}

.slider-wrap ul.slider li img{
    display:block;
    width:560px;
    height: 100%;
}

.wrapper img, #write_box img, #next, #previous {
	z-index: 1;
}

/*btns*/
.slider-btns{
    position:absolute;
    width:50px;
    height:60px;
    top:50%;
    margin-top:-25px;
    line-height:57px;
    text-align:center;
    cursor:pointer; 
    background:rgba(0,0,0,0.1);
    z-index:100;
    
    
    -webkit-user-select: none;  
    -moz-user-select: none; 
    -khtml-user-select: none; 
    -ms-user-select: none;
    
    -webkit-transition: all 0.1s ease;
    -moz-transition: all 0.1s ease;
    -o-transition: all 0.1s ease;
    -ms-transition: all 0.1s ease;
    transition: all 0.1s ease;
}

.slider-btns:hover{
    background:rgba(0,0,0,0.3); 
}

#next{right:-50px; border-radius:7px 0px 0px 7px;}
#previous{left:-50px; border-radius:0px 7px 7px 7px;}
.counter{
    top: 30px; 
    right:35px; 
    width:auto;
    position:absolute;
}

.slider-wrap.active #next{right:0px;}
.slider-wrap.active #previous{left:0px;}


/*ANIMATION*/
.slider-wrap ul, .pagination-wrap ul li{
    -webkit-transition: all 0.3s cubic-bezier(1,.01,.32,1);
    -moz-transition: all 0.3s cubic-bezier(1,.01,.32,1);
    -o-transition: all 0.3s cubic-bezier(1,.01,.32,1);
    -ms-transition: all 0.3s cubic-bezier(1,.01,.32,1);
    transition: all 0.3s cubic-bezier(1,.01,.32,1); 
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

<div id ="popup_mask" ></div> <!-- 팝업 배경 DIV -->
<!-- 친구 목록 -->
<div id="friend_all" class="container-fluid">
	<h4>친구목록</h4>
	<c:forEach var="f" items="${friendlist}">
	<div class="friend_one">
	<a href="timeline.nf?id=${f.id}">
		<span><img class='img-circle' alt="프로필사진" src="resources/upload/profileimg${f.prof_img_file}"></span>
		<span>${f.name}</span>
		<c:choose>
			<c:when test="${f.on_off == 2}">
				<span class="On_Off" style="color:red;">●</span>
			</c:when>
			
			<c:otherwise>
				<span class="On_Off" style="color:gray;">●</span>
			</c:otherwise>
		</c:choose>
	</a>
	</div>
	</c:forEach>
</div>

<div id="contentWrap">
<div id="contentArea">
<!-- 뉴스피드 모두  -->
<div id="news_all">

</div>	<!-- end news_all -->
	
</div> <!-- end contentArea -->
</div>

</body>
</html>