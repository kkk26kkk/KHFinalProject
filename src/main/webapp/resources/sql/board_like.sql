drop table board_like;

create table board_like(
	id			varchar2(100)			,	/* 게시글 아이디*/
	board_no	number					,	/* 게시글 넘버*/
	like_id		varchar2(100)	not null,	/* 좋아요 아이디*/
	like_status number    				,	/* 좋아요 상태 기본 null상태*/
	foreign key(id, board_no) references board(id, board_no) on delete cascade
);

insert into BOARD_LIKE values ()

delete from board_like;

select * from board_like 

select * from board order by like_date desc;

select *
from (select rownum rnum, b.*, like_status, like_id from(
            select * from board
			where id = 'user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
			order by like_date desc
			) b , board_like bl
  where b.id = bl.id and b.board_no = bl.board_no and like_id='user1@naver.com'
)where rnum >= (1*2-1) and rnum <= (1*2)





select b.*, like_status
from 
	( select rownum rnum, b.id, b.board_no, name, content, board_file, board_original, reg_date, like_date, like_count, like_status		
	 from (select * from board
		   where id = 'user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
		   order by like_date desc  )b , board_like bl
	)
where rnum >= (1*2-1) and rnum <= (1*2) and b.id = bl.id and b.board_no = bl.board_no	and bl.like_id='user1@naver.com'





select b.id, b.board_no, name, content, board_file, board_original, reg_date, like_date, like_count, like_id, like_status
from(
select * 
	from 
		( select rownum rnum, id, board_no, name, content, board_file, board_original, reg_date, like_date, like_count		
		from (select * from board
			where id = 'user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
			order by like_date desc  )
	)
	) b, board_like bl
where b.id = bl.id and b.board = bl.board_id

select b.id, b.board_no, name, content, board_file, board_original, reg_date, like_date, like_count, like_id, like_status
from
	(select 
		*
	from 
		BOARD 
	where 
		id='user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
	) b ,
where b.id = bl.id and b.board_no = bl.board_no


select * from board	
	
select * 
	from 
		( select rownum rnum, id, board_no, name, content, board_file, board_original, reg_date, like_date, like_count,like_id, like_status		
			from (select b.id, b.board_no, name, content, board_file, board_original, reg_date, like_date, like_count,like_id, like_status	
					from board b, BOARD_LIKE bl  
					where b.id = bl.id and b.board_no = bl.board_no and like_id = 'user1@naver.com')
			where id = 'user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
			order by like_date desc  )
			 
	where rnum >= (1*2-1) and rnum <= (1*2) 
	
	
select rownum rnum, id, board_no, name, content, board_file, board_original, reg_date, like_date, like_count,like_id, like_status	
from (select b.id, b.board_no, name, content, board_file, board_original, reg_date, like_date, like_count,like_id, like_status 
	 from board b, BOARD_LIKE bl  
	 where b.id = bl.id and b.board_no = bl.board_no )
where id = 'user1@naver.com' or id in ( select accept_id from friend_list where request_id = 'user1@naver.com' )
	

<![CDATA[
	select * 
	from 
		( select rownum rnum, id, board_no, name, content, board_file, board_original, reg_date, like_date, like_count		
		from (select * from board
			where id = #{id} or id in ( select accept_id from friend_list where request_id = #{id} )
			order by like_date desc  )
			 )
	where rnum >= (#{page}*2-1) and rnum <= (#{page}*2) 
]]>