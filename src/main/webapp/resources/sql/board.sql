drop table board;
create table board(
	id 			varchar2(100),
	board_no 	number,
	name 		varchar2(50)		not null,
	content 	varchar2(4000),
	board_file 		varchar2(4000),
	board_original	varchar2(4000),
	reg_date 	date,
	like_date 	date,
	like_count 	number,
	
	primary key(id,board_no)
)


select * from board;

select * from friend_list;

-- 글 가져오기
select *
from board
where id = 'user1' or id in (
select accept_id
from friend_list
where request_id = 'user1' -- 'user1' 자리에 session id
);
