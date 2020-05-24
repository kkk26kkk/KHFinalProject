drop table board_share;

create table board_share(
	id				varchar2(100)			,	
	board_no		number					,	
	
	share_id		varchar2(100)	not null,	/* ���� ���̵�*/
	share_no		varchar2(100)	not null,	/* ���� �ѹ�*/
	share_name		varchar2(100)	not null ,	/* ���� �̸�*/
	
	foreign key(id, board_no) references board(id, board_no) on delete cascade
);

select * from  board_share

delete from board_share