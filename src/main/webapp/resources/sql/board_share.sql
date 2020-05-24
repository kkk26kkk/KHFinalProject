drop table board_share;

create table board_share(
	id				varchar2(100)			,	
	board_no		number					,	
	
	share_id		varchar2(100)	not null,	/* 원본 아이디*/
	share_no		varchar2(100)	not null,	/* 원본 넘버*/
	share_name		varchar2(100)	not null ,	/* 원본 이름*/
	
	foreign key(id, board_no) references board(id, board_no) on delete cascade
);

select * from  board_share

delete from board_share